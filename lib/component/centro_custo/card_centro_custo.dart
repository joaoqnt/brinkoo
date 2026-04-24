import 'package:brinquedoteca_flutter/controller/configuracao/cadastro_centro_custo_controller.dart';
import 'package:brinquedoteca_flutter/events/remove_dialog.dart';
import 'package:brinquedoteca_flutter/model/centro_custo.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:flutter/material.dart';

class CardCentroCusto extends StatelessWidget {
  final CentroCusto centroCusto;
  final CadastroCentroCustoController? controller;
  final bool enableOnTap;

  CardCentroCusto({super.key, required this.centroCusto, this.enableOnTap = true, this.controller});

  @override
  Widget build(BuildContext context) {
    final content = Card(
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            CircleAvatar(
              child: Icon(Icons.business_center)
            ),
            const SizedBox(width: 10),
            Expanded(child: Text("${centroCusto.descricao}")),
            if(enableOnTap)
              IconButton(
                tooltip: "Excluir cadastro",
                onPressed: () {
                  final dialog = RemoveDialog<CentroCusto>();
                  dialog.show(
                    context: context,
                    item: centroCusto,
                    itemName: (item) => centroCusto.descricao??"",
                    isLoading: () => controller?.isDeleting??false,
                    onDelete: controller!.deleteCenCus,
                  );
                },
                icon: Icon(Icons.delete,color: Colors.red,),
              )
          ],
        ),
      ),
    );

    if (!enableOnTap) return content;

    return InkWell(
      onTap: () {
        Singleton().cadastroCentroCustoController.setCenCus(cencus: centroCusto);
      },
      child: content,
    );
  }
}