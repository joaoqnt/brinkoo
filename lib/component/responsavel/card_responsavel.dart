import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/events/image_preview_dialog.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/view/responsavel/cadastro_responsavel_view.dart';
import 'package:flutter/material.dart';

class CardResponsavel extends StatelessWidget {
  final Responsavel responsavel;
  final bool enableOnTap;

  const CardResponsavel({
    super.key,
    required this.responsavel,
    this.enableOnTap = true,
  });

  @override
  Widget build(BuildContext context) {
    final content = Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            InkWell(
              onTap: responsavel.urlImage != null && responsavel.urlImage!.isNotEmpty
                  ? () => ImagePreviewDialog.show(context, imageUrl: responsavel.urlImage!)
                  : null,
              child: CircleAvatar(
                radius: 30,
                backgroundImage: responsavel.urlImage != null && responsavel.urlImage!.isNotEmpty
                    ? NetworkImage(responsavel.urlImage!)
                    : null,
                child: responsavel.urlImage == null || responsavel.urlImage!.isEmpty
                    ? const Icon(Icons.person, size: 30)
                    : null,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    responsavel.nome!,
                    //style: const TextStyle(
                    //  fontWeight: FontWeight.bold,
                    //  fontSize: 16,
                    //),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.phone, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        UtilBrasilFields.obterTelefone(responsavel.celular??''),
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
            builder: (context) => CadastroResponsavelView(responsavel: responsavel),
          ),
        );
      },
      child: content,
    );
  }
}
