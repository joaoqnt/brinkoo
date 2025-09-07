import 'package:brinquedoteca_flutter/model/forma_pagamento.dart';
import 'package:brinquedoteca_flutter/view/cadastros/forma_pagamento/cadastro_forma_pagamento_view.dart';
import 'package:flutter/material.dart';

class CardFormaPagamento extends StatelessWidget {
  final FormaPagamento formaPagamento;
  final bool enableOnTap;

  CardFormaPagamento({super.key, required this.formaPagamento, this.enableOnTap = true});

  @override
  Widget build(BuildContext context) {
    final content = Card(
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            CircleAvatar(
              child: Icon(Icons.money)
            ),
            const SizedBox(width: 10),
            Text("${formaPagamento.descricao}"),
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
            builder: (context) => CadastroFormaPagamentoView(formaPagamento: formaPagamento),
          ),
        );
      },
      child: content,
    );
  }
}