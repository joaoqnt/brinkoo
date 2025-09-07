import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/events/image_preview_dialog.dart';
import 'package:brinquedoteca_flutter/model/parceiro.dart';
import 'package:brinquedoteca_flutter/model/usuario.dart';
import 'package:brinquedoteca_flutter/view/cadastros/parceiro/cadastro_parceiro_view.dart';
import 'package:brinquedoteca_flutter/view/parametro/usuario/cadastro_usuario_view.dart';
import 'package:flutter/material.dart';

class CardUsuario extends StatelessWidget {
  final Usuario usuario;
  final bool enableOnTap;

  const CardUsuario({
    super.key,
    required this.usuario,
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
              onTap: usuario.urlFoto != null && usuario.urlFoto!.isNotEmpty
                  ? () => ImagePreviewDialog.show(context, imageUrl: usuario.urlFoto!)
                  : null,
              child: CircleAvatar(
                radius: 30,
                backgroundImage: usuario.urlFoto != null && usuario.urlFoto!.isNotEmpty
                    ? NetworkImage(usuario.urlFoto!)
                    : null,
                child: usuario.urlFoto == null || usuario.urlFoto!.isEmpty
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
                    usuario.nome!,
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
                        usuario.login!,
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
            builder: (context) => CadastroUsuarioView(usuario: usuario),
          ),
        );
      },
      child: content,
    );
  }
}
