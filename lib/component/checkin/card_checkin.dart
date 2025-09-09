import 'package:brinquedoteca_flutter/events/image_preview_dialog.dart';
import 'package:brinquedoteca_flutter/model/checkin.dart';
import 'package:brinquedoteca_flutter/utils/date_helper_util.dart';
import 'package:brinquedoteca_flutter/view/checkin/cadastro_checkin_view.dart';
import 'package:flutter/material.dart';

class CardCheckin extends StatelessWidget {
  final Checkin checkin;
  CardCheckin({super.key, required this.checkin});

  @override
  Widget build(BuildContext context) {
    final imageUrl = checkin.urlImageCrianca?.isNotEmpty == true
        ? checkin.urlImageCrianca!
        : (checkin.crianca?.urlImage?.isNotEmpty == true ? checkin.crianca!.urlImage! : null);
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CadastroCheckinView(checkin: checkin,)),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => imageUrl == null ? null : ImagePreviewDialog.show(
                  context,
                  imageUrl: imageUrl,
                ),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
                  onBackgroundImageError: imageUrl != null
                      ? (exception, stackTrace) {
                    debugPrint("Erro ao carregar imagem: $exception");
                  }
                      : null,
                  child: imageUrl == null ? const Icon(Icons.child_care, size: 30) : null,
                )
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(checkin.crianca!.nome!),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.login, size: 16, color: Colors.green),
                        const SizedBox(width: 4),
                        Text(
                          "Chegada: ${DateHelperUtil.formatDateTime(checkin.dataEntrada!)}",
                          style: const TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    if (checkin.dataSaida != null)
                      Row(
                        children: [
                          const Icon(Icons.logout, size: 16, color: Colors.red),
                          const SizedBox(width: 4),
                          Text(
                            "Partida: ${DateHelperUtil.formatDateTime(checkin.dataSaida!)}",
                            style: const TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
