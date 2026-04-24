import 'package:brinquedoteca_flutter/component/custom/custom_card_section.dart';
import 'package:brinquedoteca_flutter/component/empresa/form/form_cadastro_empresa.dart';
import 'package:brinquedoteca_flutter/component/empresa/list_empresa.dart';
import 'package:brinquedoteca_flutter/model/empresa.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../component/custom/custom_appbar.dart';

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
  final _controller = Singleton().cadastroEmpresaController;

  @override
  Widget build(BuildContext context) {
    _controller.setEmpresa(empresa: widget.empresa);
    return Scaffold(
      appBar: CustomAppBar(
        title: "Cadastro de Empresas",
      ),
      body: FutureBuilder(
        future: _controller.getEmpresas(),
        builder: (context,snapshot) {
          return Observer(builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 20,
                  children: [
                    CustomCardSection(child: FormCadastroEmpresa(controller: _controller)),
                    ListEmpresa(controller: _controller),
                    /// Código + Nome + CNPJ
                    // Row(
                    //   children: [
                    //     SizedBox(
                    //       width: 200,
                    //       child: CustomTextFormField(
                    //         labelText: "Código",
                    //         controller: _controller.tecCodigo,
                    //         readOnly: true,
                    //       ),
                    //     ),
                    //     SizedBox(width: 20),
                    //     Expanded(
                    //       child: CustomTextFormField(
                    //         labelText: "Descrição",
                    //         controller: _controller.tecNome,
                    //         required: true,
                    //       ),
                    //     ),
                    //     SizedBox(width: 20),
                    //     SizedBox(
                    //       width: 200,
                    //       child: CustomTextFormField(
                    //         labelText: "CNPJ",
                    //         controller: _controller.tecCnpj,
                    //         inputFormatters: [
                    //           FilteringTextInputFormatter.digitsOnly,
                    //           CnpjInputFormatter()
                    //         ],
                    //         validator: (p0) {
                    //           if (UtilBrasilFields.isCNPJValido(
                    //               _controller.tecCnpj.text)) {
                    //             return null;
                    //           } else {
                    //             return "CNPJ inválido";
                    //           }
                    //         },
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    //
                    // /// CEP + Bairro + Cidade + UF
                    // Row(
                    //   children: [
                    //     SizedBox(
                    //       width: 150,
                    //       child: CustomTextFormField(
                    //         labelText: "CEP",
                    //         controller: _controller.tecCep,
                    //         inputFormatters: [
                    //           FilteringTextInputFormatter.digitsOnly,
                    //           CepInputFormatter(),
                    //         ],
                    //       ),
                    //     ),
                    //     SizedBox(width: 20),
                    //     Expanded(
                    //       flex: 2,
                    //       child: CustomTextFormField(
                    //         labelText: "Bairro",
                    //         controller: _controller.tecBairro,
                    //       ),
                    //     ),
                    //     SizedBox(width: 20),
                    //     Expanded(
                    //       flex: 2,
                    //       child: CustomTextFormField(
                    //         labelText: "Cidade",
                    //         controller: _controller.tecCidade,
                    //       ),
                    //     ),
                    //     SizedBox(width: 20),
                    //     SizedBox(
                    //       width: 60,
                    //       child: CustomTextFormField(
                    //         labelText: "UF",
                    //         controller: _controller.tecUf,
                    //         maxLength: 2,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    //
                    // /// Logradouro + Número + Complemento
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       flex: 3,
                    //       child: CustomTextFormField(
                    //         labelText: "Logradouro",
                    //         controller: _controller.tecLogradouro,
                    //       ),
                    //     ),
                    //     SizedBox(width: 20),
                    //     SizedBox(
                    //       width: 100,
                    //       child: CustomTextFormField(
                    //         labelText: "Número",
                    //         controller: _controller.tecNumero,
                    //       ),
                    //     ),
                    //     SizedBox(width: 20),
                    //     Expanded(
                    //       flex: 2,
                    //       child: CustomTextFormField(
                    //         labelText: "Complemento",
                    //         controller: _controller.tecComplemento,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    //
                    // /// Telefone + Celular + Email
                    // Row(
                    //   children: [
                    //     SizedBox(
                    //       width: 200,
                    //       child: CustomTextFormField(
                    //         labelText: "Telefone",
                    //         controller: _controller.tecTelefone,
                    //         inputFormatters: [
                    //           FilteringTextInputFormatter.digitsOnly,
                    //           TelefoneInputFormatter(),
                    //         ],
                    //       ),
                    //     ),
                    //     SizedBox(width: 20),
                    //     SizedBox(
                    //       width: 200,
                    //       child: CustomTextFormField(
                    //         labelText: "Celular",
                    //         controller: _controller.tecCelular,
                    //         inputFormatters: [
                    //           FilteringTextInputFormatter.digitsOnly,
                    //           TelefoneInputFormatter(),
                    //         ],
                    //       ),
                    //     ),
                    //     SizedBox(width: 20),
                    //     Expanded(
                    //       child: CustomTextFormField(
                    //         labelText: "E-mail",
                    //         controller: _controller.tecEmail,
                    //         keyboardType: TextInputType.emailAddress,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    //
                    // /// Inscrição Estadual + CNAE
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: CustomTextFormField(
                    //         labelText: "Inscrição Estadual",
                    //         controller: _controller.tecInscEst,
                    //       ),
                    //     ),
                    //     SizedBox(width: 20),
                    //     Expanded(
                    //       child: CustomTextFormField(
                    //         labelText: "CNAE",
                    //         controller: _controller.tecCnae,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    //
                    // /// Botão de salvar
                    // FilledButton(
                    //   onPressed: () async {
                    //     if (_controller.formKeyEmpresa.currentState!.validate() &&
                    //         !_controller.isLoading) {
                    //       if (widget.empresa == null) {
                    //         await _controller.createEmpresa(context);
                    //       } else {
                    //         await _controller.updateEmpresa(
                    //             context, widget.empresa!);
                    //       }
                    //     }
                    //   },
                    //   child: _controller.isLoading
                    //       ? CircularProgressIndicator(
                    //     color: Colors.white,
                    //   )
                    //       : Text("Salvar alterações"),
                    // ),
                  ],
                ),
              ),
            );
          });
        }
      ),
    );
  }
}
