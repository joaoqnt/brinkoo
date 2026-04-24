import 'package:brinquedoteca_flutter/component/centro_custo/card_centro_custo.dart';
import 'package:brinquedoteca_flutter/component/util/row_search_textfield.dart';
import 'package:brinquedoteca_flutter/controller/configuracao/cadastro_centro_custo_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ListCentroCusto extends StatelessWidget {
  final CadastroCentroCustoController controller;
  const ListCentroCusto({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: controller.getCentros(),
        builder: (context,snapshot) {
          return snapshot.hasData ? Observer(
            builder: (context) {
              return Column(
                spacing: 10,
                children: [
                  RowSearchTextfield(
                    tecController: controller.tecPesquisa,
                  ),
                  Expanded(
                      child: ListView.builder(
                        itemCount: controller.centros.length,
                        itemBuilder: (context, index) {
                          return CardCentroCusto(centroCusto: controller.centros[index],controller: controller,);
                        },
                      )
                  )
                ],
              );
            }
          ) : Center(child: CircularProgressIndicator(),);
        }
    );
  }
}
