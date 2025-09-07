import 'package:brinquedoteca_flutter/model/natureza.dart';
import 'package:brinquedoteca_flutter/view/cadastros/natureza/cadastro_natureza_view.dart';
import 'package:flutter/material.dart';

class CardNatureza extends StatelessWidget {
  final Natureza natureza;
  final bool enableOnTap;

  CardNatureza({super.key, required this.natureza, this.enableOnTap = true});

  @override
  Widget build(BuildContext context) {
    final content = Card(
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            CircleAvatar(
              child: Icon(Icons.category)
            ),
            const SizedBox(width: 10),
            Text("${natureza.descricao}"),
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
            builder: (context) => CadastroNaturezaView(natureza: natureza),
          ),
        );
      },
      child: content,
    );
  }
}