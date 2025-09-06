import 'package:brinquedoteca_flutter/component/custom_appbar.dart';
import 'package:brinquedoteca_flutter/component/drawer/custom_drawer.dart';
import 'package:brinquedoteca_flutter/component/foto/foto_alter_component.dart';
import 'package:brinquedoteca_flutter/component/responsavel/form_cadastro_responsavel_component.dart';
import 'package:brinquedoteca_flutter/controller/responsavel/cadastro_responsavel_controller.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/view/responsavel/responsavel_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CadastroResponsavelView extends StatefulWidget {
  Responsavel? responsavel;
  CadastroResponsavelView({
    super.key,
    this.responsavel,
  });

  @override
  State<CadastroResponsavelView> createState() => _CadastroResponsavelViewState();
}

class _CadastroResponsavelViewState extends State<CadastroResponsavelView> {
  final _controller = CadastroResponsavelController();

  @override
  Widget build(BuildContext context) {
    _controller.setResponsavel(responsavel: widget.responsavel);
    return Scaffold(
      appBar: CustomAppBar(
        useDrawer: false,
        showBackButton: true,
        title: "Cadastro de Responsável",
        pageBackButton: ResponsavelListView(),
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Observer(
          builder: (context) {
            return SingleChildScrollView(
              child: Column(
                spacing: 20,
                children: [
                  FormCadastroResponsavelComponent(
                      controller: _controller,
                      responsavel: widget.responsavel,
                  ),
                  FilledButton(
                    onPressed: () async {
                      // Valida o form principal
                      if(_controller.validate(context) && !_controller.isLoading){
                        if(widget.responsavel == null) {
                          await _controller.createResponsavel(context,true);
                        } else {
                          await _controller.updateResponsavel(context,widget.responsavel!);
                        }
                      }
                    },
                    child: _controller.isLoading
                        ? CircularProgressIndicator(color: Colors.white,)
                        : Text("Salvar alterações"),
                  )
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
