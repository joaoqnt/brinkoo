import 'package:brinquedoteca_flutter/component/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/drawer/custom_drawer.dart';
import 'package:brinquedoteca_flutter/controller/natureza/cadastro_natureza_controller.dart';
import 'package:brinquedoteca_flutter/model/natureza.dart';
import 'package:brinquedoteca_flutter/view/cadastros/cadastro_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../component/custom_appbar.dart';

class CadastroNaturezaView extends StatefulWidget {
  final Natureza? natureza;
  CadastroNaturezaView({
    super.key,
    this.natureza,
  });

  @override
  State<CadastroNaturezaView> createState() => _CadastroNaturezaViewState();
}

class _CadastroNaturezaViewState extends State<CadastroNaturezaView> {
  final _controller = CadastroNaturezaController();

  @override
  Widget build(BuildContext context) {
    _controller.setNatureza(natureza: widget.natureza);
    return Scaffold(
      appBar: CustomAppBar(
        useDrawer: false,
        showBackButton: true,
        title: "Cadastro de Naturezas",
        pageBackButton: CadastroView(initialIndex: 5,),
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
                          controller: _controller.tecCodigoNatureza,
                          readOnly: true,
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: CustomTextFormField(
                          labelText: "Descrição",
                          controller: _controller.tecNomeNatureza,
                          required: true,
                        ),
                      ),
                    ],
                  ),
                  FilledButton(
                    onPressed: () async {
                      if(_controller.formKeyCenCus.currentState!.validate() && !_controller.isLoading){
                        if(widget.natureza == null) {
                          await _controller.createNatureza(context);
                        } else {
                          await _controller.updateNatureza(context,widget.natureza!);
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
