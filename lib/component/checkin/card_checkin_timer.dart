import 'package:brinquedoteca_flutter/controller/checkin/checkin_list_controller.dart';
import 'package:brinquedoteca_flutter/model/checkin.dart';
import 'package:brinquedoteca_flutter/view/checkin/cadastro_checkin_view.dart';
import 'package:flutter/material.dart';
import 'dart:async';

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
    final horas = duration.inHours.toString().padLeft(2, '0');
    final minutos = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final segundos = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return "$horas:$minutos:$segundos";
  }

  @override
  Widget build(BuildContext context) {
    final urlImage = (checkin.urlImageResponsavelEntrada ?? checkin.crianca?.urlImage) ?? '';
    final nome = checkin.crianca?.nome ?? 'Sem nome';
    String message = "Atividades:\n";
    // for(int i = 0; i < (checkin.atividades??[]).length; i++)
    //   message += "${checkin.atividades![i].descricao}\n";

    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CadastroCheckinView(
            checkin:checkin,
            listController: controller,
          ))
      ),
      child: Card(
        child: Column(
          children: [
            Expanded(
              flex: 8, // 90%
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: urlImage.isNotEmpty ? Image.network(
                  urlImage,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                  const Center(child: Icon(Icons.broken_image)),
                ) : const Center(child: Icon(Icons.image_not_supported)),
              ),
            ),
            Expanded(
              flex: 2, // 10%
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          nome,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Tooltip(
                        message: message,
                          child: Icon(Icons.info,color: Colors.grey)
                      )
                    ],
                  ),
                  const SizedBox(height: 4),
                  StreamBuilder(
                    stream: Stream.periodic(const Duration(seconds: 1)),
                    builder: (context, snapshot) {
                      final tempo = _tempoPermanencia();
                      final minutosDecorridos = tempo.inMinutes;
                      final minutosDesejados = checkin.minutosDesejados ?? 60;
                      final passouTempo = minutosDecorridos > minutosDesejados;

                      return Text(
                        "Tempo: ${_formatDuration(tempo)}",
                        style: TextStyle(
                          color: passouTempo ? Colors.red : Colors.green,
                        ),
                        textAlign: TextAlign.center,
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
