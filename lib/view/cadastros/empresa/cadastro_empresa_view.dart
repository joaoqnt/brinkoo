import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/drawer/custom_drawer.dart';
import 'package:brinquedoteca_flutter/controller/empresa/cadastro_empresa_controller.dart';
import 'package:brinquedoteca_flutter/model/empresa.dart';
import 'package:brinquedoteca_flutter/view/cadastros/cadastro_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../component/custom_appbar.dart';

class CadastroEmpresaView extends StatefulWidget {
  final Empresa? empresa;
  CadastroEmpresaView({
    super.key,
    this.empresa,
  });

  @override
  State<CadastroEmpresaView> createState() => _CadastroEmpresaViewState();
}

class _CadastroEmpresaViewState extends State<CadastroEmpresaView> {
  final _controller = CadastroEmpresaController();

  @override
  Widget build(BuildContext context) {
    _controller.setEmpresa(emprsa: widget.empresa);
    return Scaffold(
      appBar: CustomAppBar(
        useDrawer: false,
        showBackButton: true,
        title: "Cadastro de Empresas",
        pageBackButton: CadastroView(initialIndex: 2,),
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
                          controller: _controller.tecCodigo,
                          readOnly: true,
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: CustomTextFormField(
                          labelText: "Descrição",
                          controller: _controller.tecNome,
                          required: true,
                        ),
                      ),
                      SizedBox(width: 20),
                      SizedBox(
                        width: 200,
                        child: CustomTextFormField(
                          labelText: "Cnpj",
                          controller: _controller.tecCnpj,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CnpjInputFormatter()
                          ],
                          validator: (p0) {
                            if(UtilBrasilFields.isCNPJValido(_controller.tecCnpj.text)){
                              return null;
                            } else{
                              return "Cnpj inválido";
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  FilledButton(
                    onPressed: () async {
                      if(_controller.formKeyCenCus.currentState!.validate() && !_controller.isLoading){
                        if(widget.empresa == null) {
                          await _controller.createEmpresa(context);
                        } else {
                          await _controller.updateEmpresa(context,widget.empresa!);
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
