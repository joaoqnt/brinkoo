import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_circle_avatar.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_responsavel_controller.dart';
import 'package:brinquedoteca_flutter/events/image_preview_dialog.dart';
import 'package:brinquedoteca_flutter/events/remove_dialog.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/style.dart';
import 'package:flutter/material.dart';

class CardResponsavel extends StatelessWidget {
  final Responsavel responsavel;
  final bool enableOnTap;
  final bool fromCrianca;
  final CadastroResponsavelController? controller;
  final Widget? widget;
  final double elevation;

  const CardResponsavel({
    super.key,
    required this.responsavel,
    this.enableOnTap = true,
    this.fromCrianca = false,
    this.widget,
    this.controller,
    this.elevation = 2,
  });

  @override
  Widget build(BuildContext context) {
    final content = Card(
      color: controller?.responsavelSelected?.id == responsavel.id ? Theme.of(context).colorScheme.primary.withOpacity(0.1) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: elevation == 0 ? BorderSide.none : BorderSide(color: pkLight),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            CustomCircleAvatar(
              urlImage: responsavel.urlImage,
              icon: Icons.person,
              radius: 30,
              onTap: () {
                ImagePreviewDialog.show(context, imageUrl: responsavel.urlImage);
              },
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    responsavel.nome??"",
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
                        (responsavel.celular??'').length >= 10 ? UtilBrasilFields.obterTelefone(responsavel.celular??'') : '',
                          // responsavel.celular??'',
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if(enableOnTap)
              IconButton(
                  onPressed: () {
                    final dialog = RemoveDialog<Responsavel>();
                    dialog.show(
                      context: context,
                      item: responsavel,
                      itemName: (item) => responsavel.nome??"",
                      isLoading: () => controller?.isDeleting??false,
                      onDelete: controller!.deleteResponsavel,
                    );
                  }, 
                  icon: Icon(Icons.delete,color: Colors.red,)
              ),
            if(widget != null)
              widget!
          ],
        ),
      ),
    );


    if (!enableOnTap) return content;

    return InkWell(
      onTap: () {
        controller!.setResponsavel(responsavel: responsavel);
      },
      child: content,
    );
  }
}
