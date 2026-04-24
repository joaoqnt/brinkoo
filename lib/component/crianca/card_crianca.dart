import 'package:brinquedoteca_flutter/component/custom/custom_circle_avatar.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_crianca_controller.dart';
import 'package:brinquedoteca_flutter/events/image_preview_dialog.dart';
import 'package:brinquedoteca_flutter/events/remove_dialog.dart';
import 'package:brinquedoteca_flutter/model/crianca.dart';
import 'package:brinquedoteca_flutter/pdf/ficha_cadastral_pdf.dart';
import 'package:brinquedoteca_flutter/style.dart';
import 'package:brinquedoteca_flutter/utils/date_helper_util.dart';
import 'package:brinquedoteca_flutter/utils/utils.dart';
import 'package:flutter/material.dart';

class CardCrianca extends StatelessWidget {
  final Crianca crianca;
  final CadastroCriancaController? controller;
  final bool enableOnTap;
  final double elevation;

  CardCrianca({
    super.key,
    required this.crianca,
    this.enableOnTap = true,
    this.controller,
    this.elevation = 2,
  });

  @override
  Widget build(BuildContext context) {
    final content = Card(
      color: controller?.criancaSelected == crianca ? Theme.of(context).colorScheme.primary.withOpacity(0.1) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: elevation == 0 ? BorderSide.none : BorderSide(color: pkLight),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            CustomCircleAvatar(
              urlImage: crianca.urlImage,
              radius: 30,
              onTap: () {
                ImagePreviewDialog.show(context, imageUrl: crianca.urlImage!);
              },
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    spacing: 5,
                    children: [
                      Text(crianca.nome!),
                      if(crianca.ativo == false)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6,vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text(
                            "Inativo",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.cake, size: 13, color: Colors.purple),
                      const SizedBox(width: 4),
                      if(crianca.dataNascimento != null)...[
                        Text(
                          "${Utils.calcularIdade(crianca.dataNascimento!)} anos - ",
                          style: const TextStyle(fontSize: 13),
                        ),
                        Text(
                          "${DateHelperUtil.formatDate(crianca.dataNascimento!)}",
                          style: const TextStyle(fontSize: 13),
                        ),
                      ]
                    ],
                  ),
                  if((crianca.responsaveis??[]).isNotEmpty)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.phone, size: 13, color: Colors.purple),
                        const SizedBox(width: 4),
                        Text(
                          Utils.obterTelefoneResponsavelCrianca(crianca),
                          style: const TextStyle(fontSize: 13),
                        )
                      ]
                    ),
                ],
              ),
            ),
            if(enableOnTap)...[
              IconButton(
                tooltip: "Gerar ficha cadastral",
                onPressed: () async{
                  await FichaCadastralPdf.imprimir(crianca);
                },
                icon: Icon(Icons.picture_as_pdf,color: Colors.purple),
              ),
              IconButton(
                tooltip: "Excluir cadastro",
                onPressed: () {
                  final dialog = RemoveDialog<Crianca>();
                  dialog.show(
                    context: context,
                    item: crianca,
                    itemName: (item) => crianca.nome??"",
                    isLoading: () => controller?.isDeleting??false,
                    onDelete: controller!.deleteCrianca,
                  );
                },
                icon: Icon(Icons.delete,color: Colors.red,),
              )
            ]
          ],
        ),
      ),
    );


    if (!enableOnTap) return content;

    return InkWell(
      onTap: () {
        controller!.setCrianca(crianca: crianca);
        controller!.setIndexPage(0);
        controller!.setIndexPage(0);
      },
      child: content,
    );
  }
}