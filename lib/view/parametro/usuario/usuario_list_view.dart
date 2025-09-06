import 'package:brinquedoteca_flutter/component/crianca/card_crianca.dart';
import 'package:brinquedoteca_flutter/component/custom_appbar.dart';
import 'package:brinquedoteca_flutter/component/drawer/custom_drawer.dart';
import 'package:brinquedoteca_flutter/component/row_search_textfield.dart';
import 'package:brinquedoteca_flutter/component/usuario/card_usuario.dart';
import 'package:brinquedoteca_flutter/controller/parametro/usuario/usuario_list_controller.dart';
import 'package:brinquedoteca_flutter/view/parametro/usuario/cadastro_usuario_view.dart';
import 'package:flutter/material.dart';

class UsuarioListView extends StatefulWidget {
  UsuarioListView({super.key});

  @override
  State<UsuarioListView> createState() => _UsuarioListViewState();
}

class _UsuarioListViewState extends State<UsuarioListView> {
  final _controller = UsuarioListController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _controller.getUsuarios(),
          builder: (context,snapshot) {
            return snapshot.hasData ? Column(
              spacing: 10,
              children: [
                RowSearchTextfield(
                  tecController: _controller.tecPesquisa,
                  widget: CadastroUsuarioView(),
                ),
                Expanded(
                    child: ListView.builder(
                      itemCount: _controller.usuarios.length,
                      itemBuilder: (context, index) {
                        return CardUsuario(usuario: _controller.usuarios[index]);
                      },
                    )
                )
              ],
            ) : Center(child: CircularProgressIndicator(),);
          }
      ),
    );
  }
}
