import 'package:brinquedoteca_flutter/component/empresa/card_empresa.dart';
import 'package:brinquedoteca_flutter/component/row_search_textfield.dart';
import 'package:brinquedoteca_flutter/controller/empresa/empresa_list_controller.dart';
import 'package:brinquedoteca_flutter/view/cadastros/empresa/cadastro_empresa_view.dart';
import 'package:flutter/material.dart';


class EmpresaListView extends StatefulWidget {
  EmpresaListView({super.key});

  @override
  State<EmpresaListView> createState() => _EmpresaListViewState();
}

class _EmpresaListViewState extends State<EmpresaListView> {
  final _controller = EmpresaListController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _controller.getEmpresas(),
        builder: (context,snapshot) {
          return snapshot.hasData ? Column(
            spacing: 10,
            children: [
              RowSearchTextfield(
                  tecController: _controller.tecPesquisa,
                  widget: CadastroEmpresaView(),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: _controller.empresas.length,
                      itemBuilder: (context, index) {
                        return CardEmpresa(empresa: _controller.empresas[index]);
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
