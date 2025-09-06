import 'package:brinquedoteca_flutter/model/centro_custo.dart';
import 'package:brinquedoteca_flutter/view/cadastros/centro_custo/cadastro_centro_custo_view.dart';
import 'package:flutter/material.dart';

class CardCentroCusto extends StatelessWidget {
  final CentroCusto centroCusto;
  final bool enableOnTap;

  CardCentroCusto({super.key, required this.centroCusto, this.enableOnTap = true});

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
            Text("${centroCusto.descricao}"),
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
            builder: (context) => CadastroCentroCustoView(centroCusto: centroCusto),
          ),
              (Route<dynamic> route) => false,
        );
      },
      child: content,
    );
  }
}