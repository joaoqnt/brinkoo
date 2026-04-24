import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_guarda_volume_controller.dart';
import 'package:brinquedoteca_flutter/events/remove_dialog.dart';
import 'package:brinquedoteca_flutter/model/guarda_volume.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:brinquedoteca_flutter/view/cadastros/guardas_volume/cadastro_guarda_volume_view.dart';
import 'package:flutter/material.dart';

class CardGuardaVolume extends StatelessWidget {
  final GuardaVolume guardaVolume;
  final CadastroGuardaVolumeController? controller;
  final bool enableOnTap;

  CardGuardaVolume({
    super.key,
    required this.guardaVolume,
    this.enableOnTap = true,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final content = Card(
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            CircleAvatar(
              child: Icon(Icons.door_sliding)
            ),
            const SizedBox(width: 10),
            Expanded(child: Text("${guardaVolume.descricao}")),
            if(enableOnTap)
              IconButton(
                tooltip: "Excluir cadastro",
                onPressed: () {
                  final dialog = RemoveDialog<GuardaVolume>();
                  dialog.show(
                    context: context,
                    item: guardaVolume,
                    itemName: (item) => guardaVolume.descricao??"",
                    isLoading: () => controller?.isDeleting??false,
                    onDelete: controller!.deleteGuardaVolume,
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
        Singleton().cadastroGuardaVolumeController.setGuardaVolume(guardaVolume: guardaVolume);
      },
      child: content,
    );
  }
}