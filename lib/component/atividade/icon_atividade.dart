import 'package:brinquedoteca_flutter/model/atividade.dart';
import 'package:brinquedoteca_flutter/utils/utils.dart';
import 'package:flutter/material.dart';

class IconAtividade extends StatelessWidget {
  final Atividade atividade;
  const IconAtividade({super.key, required this.atividade});

  @override
  Widget build(BuildContext context) {
    final iconeData = Utils().getIconeAtividadeByName(atividade.icone ?? "");
    return SizedBox(
      width: 50,
      height: 50,
      child: iconeData != null
          ? Image.asset("assets/${iconeData.pathImage}", fit: BoxFit.contain)
          : const Icon(Icons.toys, color: Colors.grey),
    );
  }
}
