import 'package:brinquedoteca_flutter/component/centro_custo/form/form_centro_custo.dart';
import 'package:brinquedoteca_flutter/component/centro_custo/list_centro_custo.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_card_section.dart';
import 'package:brinquedoteca_flutter/component/util/section_title.dart';
import 'package:brinquedoteca_flutter/model/centro_custo.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../component/custom/custom_appbar.dart';

class CadastroCentroCustoView extends StatefulWidget {
  final CentroCusto? centroCusto;
  CadastroCentroCustoView({
    super.key,
    this.centroCusto,
  });

  @override
  State<CadastroCentroCustoView> createState() => _CadastroCentroCustoViewState();
}

class _CadastroCentroCustoViewState extends State<CadastroCentroCustoView> {
  final _controller = Singleton().cadastroCentroCustoController;

  @override
  Widget build(BuildContext context) {
    _controller.setCenCus(cencus: widget.centroCusto);
    return Scaffold(
      appBar: CustomAppBar(
        title: "Cadastro de Centros de Custo",
      ),
      body: Observer(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              spacing: 20,
              children: [
                FormCentroCusto(controller: _controller),
                Expanded(
                    child: CustomCardSection(
                        child: Column(
                          spacing: 10,
                          children: [
                            SectionTitle(text: "Centros de Custo já cadastrados"),
                            Expanded(child: ListCentroCusto(controller: _controller)),
                          ],
                        )
                    )
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
