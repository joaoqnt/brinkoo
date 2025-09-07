import 'package:brinquedoteca_flutter/model/atividade.dart';
import 'package:brinquedoteca_flutter/view/cadastros/atividades/cadastro_atividade_view.dart';
import 'package:flutter/material.dart';

class CardAtividade extends StatelessWidget {
  final Atividade atividade;
  final bool enableOnTap;

  CardAtividade({super.key, required this.atividade, this.enableOnTap = true});

  @override
  Widget build(BuildContext context) {
    final content = Card(
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            CircleAvatar(
              child: Icon(Icons.toys)
            ),
            const SizedBox(width: 10),
            Text("${atividade.descricao}"),
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
            builder: (context) => CadastroAtividadeView(atividade: atividade),
          ),
        );
      },
      child: content,
    );
  }
}