import 'package:brinquedoteca_flutter/events/image_preview_dialog.dart';
import 'package:brinquedoteca_flutter/model/crianca.dart';
import 'package:brinquedoteca_flutter/utils/utils.dart';
import 'package:brinquedoteca_flutter/view/crianca/cadastro_crianca_view.dart';
import 'package:flutter/material.dart';

class CardCrianca extends StatelessWidget {
  final Crianca crianca;
  final bool enableOnTap;

  CardCrianca({super.key, required this.crianca, this.enableOnTap = true});

  @override
  Widget build(BuildContext context) {
    final content = Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            InkWell(
              onTap: crianca.urlImage != null && crianca.urlImage!.isNotEmpty
                  ? () => ImagePreviewDialog.show(context, imageUrl: crianca.urlImage!)
                  : null,
              child: CircleAvatar(
                radius: 30,
                backgroundImage: crianca.urlImage != null && crianca.urlImage!.isNotEmpty
                    ? NetworkImage(crianca.urlImage!)
                    : null,
                onBackgroundImageError: (exception, stackTrace) => Icons.child_care,
                child: crianca.urlImage == null || crianca.urlImage!.isEmpty
                    ? const Icon(Icons.child_care, size: 30)
                    : null,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(crianca.nome!),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.cake, size: 13, color: Colors.purple),
                      const SizedBox(width: 4),
                      if(crianca.dataNascimento != null)
                        Text(
                          "${Utils.calcularIdade(crianca.dataNascimento!)} anos",
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
    );


    if (!enableOnTap) return content;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CadastroCriancaView(crianca: crianca),
          ),
        );
      },
      child: content,
    );
  }
}