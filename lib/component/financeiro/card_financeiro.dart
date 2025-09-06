import 'package:brinquedoteca_flutter/model/financeiro.dart';
import 'package:brinquedoteca_flutter/utils/date_helper_util.dart';
//import 'package:brinquedoteca_flutter/view/financeiro/cadastro_financeiro_view.dart';
import 'package:flutter/material.dart';

class CardFinanceiro extends StatelessWidget {
  final Financeiro financeiro;
  final bool enableOnTap;

  const CardFinanceiro({
    super.key,
    required this.financeiro,
    this.enableOnTap = true,
  });

  @override
  Widget build(BuildContext context) {
    final content = Card(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            CircleAvatar(
              child: Icon(
                financeiro.receitaDespesa == 'r'
                    ? Icons.arrow_downward
                    : Icons.arrow_upward,
                color: financeiro.receitaDespesa == 'r'
                    ? Colors.green
                    : Colors.red,
              ),
              backgroundColor: Colors.grey.shade200,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    financeiro.descricao ?? 'Sem descrição',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Parceiro: ${financeiro.parceiro?.nome ?? 'Não informado'}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    'Data: ${DateHelperUtil.formatDateTime(financeiro.dataNegociacao!)}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Text(
              'R\$ ${financeiro.valorTotal ?? '0,00'}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: financeiro.receitaDespesa == 'r'
                    ? Colors.green
                    : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );

    if (!enableOnTap) return content;

    return InkWell(
      onTap: () {
        //Navigator.pushAndRemoveUntil(
        //  context,
        //  MaterialPageRoute(
        //    builder: (context) =>
        //        CadastroFinanceiroView(financeiro: financeiro),
        //  ),
        //      (Route<dynamic> route) => false,
        //);
      },
      child: content,
    );
  }
}
