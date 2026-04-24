import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_circle_avatar.dart';
import 'package:brinquedoteca_flutter/events/image_preview_dialog.dart';
import 'package:brinquedoteca_flutter/model/parceiro.dart';
import 'package:brinquedoteca_flutter/model/usuario.dart';
import 'package:brinquedoteca_flutter/style.dart';
import 'package:brinquedoteca_flutter/view/cadastros/parceiro/cadastro_parceiro_view.dart';
import 'package:brinquedoteca_flutter/view/parametro/usuario/cadastro_usuario_view.dart';
import 'package:flutter/material.dart';

class CardUsuario extends StatelessWidget {
  final Usuario usuario;
  final bool enableOnTap;
  final double elevation;

  const CardUsuario({
    super.key,
    required this.usuario,
    this.enableOnTap = true,
    this.elevation = 2,
  });

  @override
  Widget build(BuildContext context) {
    final content = Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: elevation == 0 ? BorderSide.none : BorderSide(color: pkLight),
      ),
      child: Padding(
        padding: elevation == 0 ? EdgeInsets.symmetric(horizontal: 10,vertical: 0) : EdgeInsets.all(10),
        child: Row(
          children: [
            CustomCircleAvatar(
              urlImage: usuario.urlFoto,
              icon: Icons.person_pin,
              radius: elevation == 0 ? 25 : 30,
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
