import 'package:brinquedoteca_flutter/events/image_preview_dialog.dart';
import 'package:brinquedoteca_flutter/model/checkin.dart';
import 'package:brinquedoteca_flutter/utils/date_helper_util.dart';
import 'package:brinquedoteca_flutter/utils/utils.dart';
import 'package:brinquedoteca_flutter/view/checkin/cadastro_checkin_view.dart';
import 'package:flutter/material.dart';

class CardCheckin extends StatelessWidget {
  final Checkin checkin;
  CardCheckin({super.key, required this.checkin});

  @override
  Widget build(BuildContext context) {
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
                onTap: () => ImagePreviewDialog.show(
                  context,
                  imageUrl: checkin.urlImageCrianca ?? checkin.crianca!.urlImage,
                ),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    (checkin.urlImageCrianca ?? checkin.crianca!.urlImage)??'',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      checkin.crianca!.nome!,
                      //style: const TextStyle(
                      //  fontWeight: FontWeight.bold,
                      //  fontSize: 16,
                      //),
                    ),
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
