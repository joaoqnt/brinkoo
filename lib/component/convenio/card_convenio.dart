import 'package:brinquedoteca_flutter/model/convenio.dart';
import 'package:brinquedoteca_flutter/view/cadastros/convenio/cadastro_convenio_view.dart';
import 'package:flutter/material.dart';

class CardConvenio extends StatelessWidget {
  final Convenio convenio;
  final bool enableOnTap;

  CardConvenio({super.key, required this.convenio, this.enableOnTap = true});

  @override
  Widget build(BuildContext context) {
    final content = Card(
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            const CircleAvatar(
              child: Icon(Icons.sell),
            ),
            const SizedBox(width: 10),
            // Aqui, envolvemos a coluna com Expanded para limitar a largura
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${convenio.descricao}",
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(
                        Icons.description,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      // Aqui, o Text também precisa estar dentro de Expanded
                      Expanded(
                        child: Text(
                          "${convenio.observacao}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(color: Colors.grey),
                        ),
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
          MaterialPageRoute(builder: (context) => CadastroConvenioView(convenio: convenio)),
        );
      },
      child: content,
    );
  }
}
