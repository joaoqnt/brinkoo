import 'package:brinquedoteca_flutter/component/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/drawer/custom_drawer.dart';
import 'package:brinquedoteca_flutter/controller/atividades/cadastro_atividade_controller.dart';
import 'package:brinquedoteca_flutter/model/atividade.dart';
import 'package:brinquedoteca_flutter/view/cadastros/cadastro_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../component/custom_appbar.dart';

class CadastroAtividadeView extends StatefulWidget {
  final Atividade? atividade;
  CadastroAtividadeView({
    super.key,
    this.atividade,
  });

  @override
  State<CadastroAtividadeView> createState() => _CadastroAtividadeViewState();
}

class _CadastroAtividadeViewState extends State<CadastroAtividadeView> {
  final _controller = CadastroAtividadeController();

  @override
  Widget build(BuildContext context) {
    _controller.setAtividade(atividade: widget.atividade);
    return Scaffold(
      appBar: CustomAppBar(
        useDrawer: false,
        showBackButton: true,
        title: "Cadastro de Atividade",
        pageBackButton: CadastroView(initialIndex: 0,),
      ),
      drawer: CustomDrawer(),
      body: Observer(
        builder: (context) {
          return Form(
            key: _controller.formKeyAtividade,
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
                          controller: _controller.tecCodigoAtividade,
                          readOnly: true,
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: CustomTextFormField(
                          labelText: "Descrição",
                          controller: _controller.tecNomeAtividade,
                          required: true,
                        ),
                      ),
                    ],
                  ),
                  FilledButton(
                    onPressed: () async {
                      if(_controller.formKeyAtividade.currentState!.validate() && !_controller.isLoading){
                        if(widget.atividade == null) {
                          await _controller.createAtividade(context);
                        } else {
                          await _controller.updateAtividade(context,widget.atividade!);
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
