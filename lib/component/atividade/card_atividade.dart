import 'package:brinquedoteca_flutter/component/atividade/alert_atividade.dart';
import 'package:brinquedoteca_flutter/component/atividade/icon_atividade.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_atividade_controller.dart';
import 'package:brinquedoteca_flutter/events/remove_dialog.dart';
import 'package:brinquedoteca_flutter/model/atividade.dart';
import 'package:brinquedoteca_flutter/utils/utils.dart';
import 'package:brinquedoteca_flutter/view/cadastros/atividades/cadastro_atividade_view.dart';
import 'package:flutter/material.dart';

class CardAtividade extends StatelessWidget {
  final Atividade atividade;
  final CadastroAtividadeController? controller;
  final bool enableOnTap;

  CardAtividade({super.key, required this.atividade, this.enableOnTap = true, this.controller,});

  @override
  Widget build(BuildContext context) {
    final content = Card(
      color: controller?.atividadeSelected?.id == atividade.id ? Theme.of(context).colorScheme.primary.withOpacity(0.1) : null,
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Row(
          spacing: 10,
          children: [
            IconAtividade(atividade: atividade),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${atividade.nome}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${atividade.descricao}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            if(atividade.padrao == false)
              AlertAtividade(),
            IconButton(
                onPressed: () {
                  controller!.setAtividade(atividade: atividade);
                  final dialog = RemoveDialog<Atividade>();
                  dialog.show(
                    context: context,
                    item: atividade,
                    itemName: (item) => atividade.nome??"",
                    isLoading: () => controller?.isDeleting??false,
                    onDelete: controller!.deleteAtividade,
                  );
                },
                icon: Icon(Icons.delete,color: Colors.red,)
            )
          ],
        ),
      ),
    );

    if (!enableOnTap) return content;

    return InkWell(
      onTap: () {
        controller!.setAtividade(atividade: atividade.id == controller?.atividadeSelected?.id ? null : atividade);
      },
      child: content,
    );
  }
}