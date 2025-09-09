import 'package:brinquedoteca_flutter/component/convenio/card_convenio.dart';
import 'package:brinquedoteca_flutter/component/row_search_textfield.dart';
import 'package:brinquedoteca_flutter/controller/convenio/convenio_list_controller.dart';
import 'package:brinquedoteca_flutter/view/cadastros/convenio/cadastro_convenio_view.dart';
import 'package:flutter/material.dart';


class ConvenioListView extends StatefulWidget {
  ConvenioListView({super.key});

  @override
  State<ConvenioListView> createState() => _NaturezaListViewState();
}

class _NaturezaListViewState extends State<ConvenioListView> {
  final _controller = ConvenioListController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _controller.getConvenios(),
        builder: (context,snapshot) {
          return snapshot.hasData ? Column(
            spacing: 10,
            children: [
              RowSearchTextfield(
                  tecController: _controller.tecPesquisa,
                  widget: CadastroConvenioView(),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: _controller.convenios.length,
                      itemBuilder: (context, index) {
                        return CardConvenio(convenio: _controller.convenios[index]);
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
