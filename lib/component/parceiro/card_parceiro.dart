import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_circle_avatar.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_parceiro_controller.dart';
import 'package:brinquedoteca_flutter/events/image_preview_dialog.dart';
import 'package:brinquedoteca_flutter/model/parceiro.dart';
import 'package:brinquedoteca_flutter/view/cadastros/parceiro/cadastro_parceiro_view.dart';
import 'package:flutter/material.dart';

class CardParceiro extends StatelessWidget {
  final Parceiro parceiro;
  final CadastroParceiroController controller;
  final bool enableOnTap;

  const CardParceiro({
    super.key,
    required this.parceiro,
    required this.controller,
    this.enableOnTap = true,
  });

  @override
  Widget build(BuildContext context) {
    final content = Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            CustomCircleAvatar(
              urlImage: parceiro.urlImage,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    parceiro.nome!,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.assignment_ind, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                            () {
                          try {
                            return parceiro.pessoaFisica == true
                                ? UtilBrasilFields.obterCpf(parceiro.cpfCnpj ?? "")
                                : UtilBrasilFields.obterCnpj(parceiro.cpfCnpj ?? "");
                          } catch (e) {
                            return parceiro.cpfCnpj ?? ""; // fallback sem máscara
                          }
                        }(),
                        style: const TextStyle(fontSize: 13),
                      )

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
        controller.setParceiro(parceiro: parceiro);
      },
      child: content,
    );
  }
}
