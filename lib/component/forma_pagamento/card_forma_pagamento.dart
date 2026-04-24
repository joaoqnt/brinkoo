import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/model/forma_pagamento.dart';
import 'package:brinquedoteca_flutter/view/configuracao/forma_pagamento/cadastro_forma_pagamento_view.dart';
import 'package:flutter/material.dart';

class CardFormaPagamento extends StatelessWidget {
  final FormaPagamento formaPagamento;
  final bool enableOnTap;
  final bool showValue;

  CardFormaPagamento({
    super.key,
    required this.formaPagamento,
    this.enableOnTap = true,
    this.showValue = false,
  });

  @override
  Widget build(BuildContext context) {
    final content = Card(
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Row(
          spacing: 10,
          children: [
            CircleAvatar(
              child: Icon(Icons.money)
            ),
            Expanded(child: Text("${formaPagamento.descricao}")),
            if(showValue)
              Text(UtilBrasilFields.obterReal(formaPagamento.valor!),
                  style: TextStyle(fontWeight: FontWeight.bold)
              ),
            IconButton(
                onPressed: () {

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
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => CadastroFormaPagamentoView(formaPagamento: formaPagamento),
        //   ),
        // );
      },
      child: content,
    );
  }
}