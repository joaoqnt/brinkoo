import 'package:brinquedoteca_flutter/model/guarda_volume.dart';
import 'package:brinquedoteca_flutter/view/cadastros/guardas_volume/cadastro_guarda_volume_view.dart';
import 'package:flutter/material.dart';

class CardGuardaVolume extends StatelessWidget {
  final GuardaVolume guardaVolume;
  final bool enableOnTap;

  CardGuardaVolume({super.key, required this.guardaVolume, this.enableOnTap = true});

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
            Text("${guardaVolume.descricao}"),
          ],
        ),
      ),
    );

    if (!enableOnTap) return content;

    return InkWell(
      onTap: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => CadastroGuardasVolumeView(guardaVolume: guardaVolume),
          ),
              (Route<dynamic> route) => false,
        );
      },
      child: content,
    );
  }
}