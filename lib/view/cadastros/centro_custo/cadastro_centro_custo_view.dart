import 'package:brinquedoteca_flutter/component/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/drawer/custom_drawer.dart';
import 'package:brinquedoteca_flutter/controller/centro_custo/cadastro_centro_custo_controller.dart';
import 'package:brinquedoteca_flutter/model/centro_custo.dart';
import 'package:brinquedoteca_flutter/view/cadastros/cadastro_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../component/custom_appbar.dart';

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
  final _controller = CadastroCentroCustoController();

  @override
  Widget build(BuildContext context) {
    _controller.setCenCus(cencus: widget.centroCusto);
    return Scaffold(
      appBar: CustomAppBar(
        useDrawer: false,
        showBackButton: true,
        title: "Cadastro de Centros de Custo",
        pageBackButton: CadastroView(initialIndex: 1,),
      ),
      drawer: CustomDrawer(),
      body: Observer(
        builder: (context) {
          return Form(
            key: _controller.formKeyCenCus,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                spacing: 20,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 200,
                        child: CustomTextFormField(
                          labelText: "Código",
                          controller: _controller.tecCodigoCenCus,
                          readOnly: true,
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: CustomTextFormField(
                          labelText: "Descrição",
                          controller: _controller.tecNomeCenCus,
                          required: true,
                        ),
                      ),
                    ],
                  ),
                  FilledButton(
                    onPressed: () async {
                      if(_controller.formKeyCenCus.currentState!.validate() && !_controller.isLoading){
                        if(widget.centroCusto == null) {
                          await _controller.createCenCus(context);
                        } else {
                          await _controller.updateCenCus(context,widget.centroCusto!);
                        }
                      }
                    },
                    child: _controller.isLoading
                        ? CircularProgressIndicator(color: Colors.white,)
                        : Text("Salvar alterações"),
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
