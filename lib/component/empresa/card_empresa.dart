import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/model/empresa.dart';
import 'package:brinquedoteca_flutter/view/cadastros/empresa/cadastro_empresa_view.dart';
import 'package:flutter/material.dart';

class CardEmpresa extends StatelessWidget {
  final Empresa empresa;
  final bool enableOnTap;

  CardEmpresa({super.key, required this.empresa, this.enableOnTap = true});

  @override
  Widget build(BuildContext context) {
    final content = Card(
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            CircleAvatar(
              child: Icon(Icons.home)
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${empresa.descricao}"),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.assignment_ind, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      UtilBrasilFields.obterCnpj(empresa.cnpj!),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
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
            builder: (context) => CadastroEmpresaView(empresa: empresa),
          ),
              (Route<dynamic> route) => false,
        );
      },
      child: content,
    );
  }
}