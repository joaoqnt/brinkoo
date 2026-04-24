import 'package:brinquedoteca_flutter/component/convenio/card_convenio.dart';
import 'package:brinquedoteca_flutter/component/util/row_search_textfield.dart';
import 'package:brinquedoteca_flutter/controller/configuracao/cadastro_convenio_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ListConvenio extends StatelessWidget {
  final CadastroConvenioController controller;
  const ListConvenio({super.key,required this.controller});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: controller.getConvenios(),
        builder: (context,snapshot) {
          return snapshot.hasData ? Observer(
            builder: (context) {
              return Column(
                spacing: 10,
                children: [
                  RowSearchTextfield(
                    tecController: controller.tecPesquisa,
                  ),
                  for(int i = 0; i < controller.convenios.length; i++)
                    CardConvenio(convenio: controller.convenios[i])
                ],
              );
            }
          ) : Center(child: CircularProgressIndicator(),);
        }
    );
  }
}
