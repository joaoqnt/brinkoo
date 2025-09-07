import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/events/image_preview_dialog.dart';
import 'package:brinquedoteca_flutter/model/parceiro.dart';
import 'package:brinquedoteca_flutter/view/cadastros/parceiro/cadastro_parceiro_view.dart';
import 'package:flutter/material.dart';

class CardParceiro extends StatelessWidget {
  final Parceiro parceiro;
  final bool enableOnTap;

  const CardParceiro({
    super.key,
    required this.parceiro,
    this.enableOnTap = true,
  });

  @override
  Widget build(BuildContext context) {
    final content = Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            InkWell(
              onTap: parceiro.urlImage != null && parceiro.urlImage!.isNotEmpty
                  ? () => ImagePreviewDialog.show(context, imageUrl: parceiro.urlImage!)
                  : null,
              child: CircleAvatar(
                radius: 30,
                backgroundImage: parceiro.urlImage != null && parceiro.urlImage!.isNotEmpty
                    ? NetworkImage(parceiro.urlImage!)
                    : null,
                child: parceiro.urlImage == null || parceiro.urlImage!.isEmpty
                    ? const Icon(Icons.person, size: 30)
                    : null,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    parceiro.nome!,
                    //style: const TextStyle(
                    //  fontWeight: FontWeight.bold,
                    //  fontSize: 16,
                    //),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.assignment_ind, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        parceiro.pessoaFisica == true
                            ? UtilBrasilFields.obterCpf(parceiro.cpfCnpj!)
                            : UtilBrasilFields.obterCnpj(parceiro.cpfCnpj!),
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
            builder: (context) => CadastroParceiroView(parceiro: parceiro),
          ),
        );
      },
      child: content,
    );
  }
}
