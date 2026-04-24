import 'package:brinquedoteca_flutter/controller/checkin/checkin_list_controller.dart';
import 'package:brinquedoteca_flutter/model/checkin.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:flutter/material.dart';

class CardCheckinTimer extends StatelessWidget {
  final Checkin checkin;
  final CheckinListController controller;

  const CardCheckinTimer({
    super.key,
    required this.checkin,
    required this.controller,
  });

  Duration _tempoPermanencia() {
    final dataEntrada = DateTime.tryParse(checkin.dataEntrada.toString());
    if (dataEntrada == null) return Duration.zero;
    return DateTime.now().difference(dataEntrada);
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {
    final urlImage = (checkin.urlImageResponsavelEntrada ?? checkin.crianca?.urlImage) ?? '';
    final nome = checkin.crianca?.nome ?? 'Sem nome';
    final minutosDesejados = checkin.minutosDesejados ?? 60;
    String message = "Atividades:\n";

    for(int i = 0; i < (checkin.atividades??[]).length; i++)

    message += "${checkin.atividades![i].descricao}\n";

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias, // Garante que a imagem respeite o arredondamento
      child: InkWell(
        onTap: () {
          Singleton().navigationController.setIndex(Singleton().navigationController.indexCadastroCheckinView);
          Singleton().cadastroCheckinController.setCheckin(checkin: checkin);
          Singleton().cadastroCheckinController.setIsFromHome(true);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Área da Imagem
            Expanded(
              flex: 3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  urlImage.isNotEmpty
                      ? Image.network(urlImage, fit: BoxFit.cover)
                      : Container(
                    color: Colors.grey[200],
                    child: Icon(Icons.person, size: 50, color: Colors.grey[400]),
                  ),
                  // Overlay de gradiente para leitura de informações se necessário
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black.withOpacity(0.1)],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Área de Informações
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          nome,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Tooltip(child: const Icon(Icons.info_outline, size: 18, color: Colors.blueGrey),message: message),
                    ],
                  ),
                  const SizedBox(height: 8),
                  StreamBuilder(
                    stream: Stream.periodic(const Duration(seconds: 1)),
                    builder: (context, snapshot) {
                      final tempo = _tempoPermanencia();
                      final minutosDecorridos = tempo.inMinutes;
                      final atingiuLimite = minutosDecorridos >= minutosDesejados;
                      final progresso = (minutosDecorridos / minutosDesejados).clamp(0.0, 1.0);

                      return Column(
                        children: [
                          LinearProgressIndicator(
                            value: progresso,
                            backgroundColor: Colors.grey[200],
                            color: atingiuLimite ? Colors.red : Colors.green,
                            minHeight: 6,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.access_time_filled,
                                size: 14,
                                color: atingiuLimite ? Colors.red : Colors.green,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _formatDuration(tempo),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: atingiuLimite ? Colors.red : Colors.green[700],
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}