import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/component/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/drawer/custom_drawer.dart';
import 'package:brinquedoteca_flutter/component/foto/foto_alter_component.dart';
import 'package:brinquedoteca_flutter/controller/parceiro/cadastro_parceiro_controller.dart';
import 'package:brinquedoteca_flutter/model/parceiro.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:brinquedoteca_flutter/view/cadastros/cadastro_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../component/custom_appbar.dart';

class CadastroParceiroView extends StatefulWidget {
  final Parceiro? parceiro;
  CadastroParceiroView({super.key, this.parceiro});

  @override
  State<CadastroParceiroView> createState() => _CadastroParceiroViewState();
}

class _CadastroParceiroViewState extends State<CadastroParceiroView> {
  final _controller = CadastroParceiroController();

  @override
  Widget build(BuildContext context) {
    _controller.setParceiro(parceiro: widget.parceiro);
    return Scaffold(
      appBar: CustomAppBar(
        useDrawer: false,
        showBackButton: true,
        title: "Cadastro de Parceiro",
        pageBackButton: CadastroView(initialIndex: 6),
      ),
      drawer: CustomDrawer(),
      body: Observer(
        builder: (context) {
          return Form(
            key: _controller.formKeyParceiro,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 20,
                  children: [
                    Row(
                      children: [
                        FotoAlterComponent(
                          capturedImageBytes: _controller.parceiroImage,
                          height: 100,
                          width: 100,
                          onAdd: (p0) => _controller.addFoto(p0),
                          imageUrl: (widget.parceiro?.urlImage),
                        ),
                        SizedBox(width: 20),
                        SizedBox(
                          width: Responsive.isMobile(context) ? 100 : 200,
                          child: CustomTextFormField(
                            labelText: "Código",
                            controller: _controller.tecCodigo,
                            readOnly: true,
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: CustomTextFormField(
                            labelText: "Nome",
                            controller: _controller.tecDescricao,
                            required: true,
                          ),
                        ),
                      ],
                    ),
                    SwitchListTile(
                      title: Text("Pessoa Física"),
                      value: _controller.pessoaFisica,
                      onChanged: _controller.setPessoaFisica,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            labelText: "CPF / CNPJ",
                            controller: _controller.tecCpfCnpj,
                            validator: (p0) {
                              if(!_controller.pessoaFisica){
                                if(!UtilBrasilFields.isCNPJValido(_controller.tecCpfCnpj.text)){
                                  return "Cnpj inválido" ;
                                }
                              } else {
                                if(!UtilBrasilFields.isCPFValido(_controller.tecCpfCnpj.text)){
                                  return "CPF inválido" ;
                                }
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              !_controller.pessoaFisica ? CnpjInputFormatter() : CpfInputFormatter()
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: CustomTextFormField(
                            labelText: "Telefone",
                            controller: _controller.tecTelefone,
                            required: true,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              TelefoneInputFormatter()
                            ],
                          )
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: CustomTextFormField(
                            labelText: "Inscrição Estadual",
                            controller: _controller.tecInscricaoEstadual
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            labelText: "Email",
                            controller: _controller.tecEmail,
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: CustomTextFormField(
                            labelText: "CEP",
                            controller: _controller.tecCep,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CepInputFormatter()
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        FilledButton(
                            onPressed: () async{
                              if(_controller.tecCep.text.isNotEmpty
                                  && UtilBrasilFields.removeCaracteres(_controller.tecCep.text).length == 8) {
                                _controller.setEnderecoByCep();
                              } else {
                                CustomSnackBar.error(context, 'Cep inválido');
                              }
                            },
                            child: Icon(Icons.search)
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            labelText: "Cidade",
                            controller: _controller.tecCidade,
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: CustomTextFormField(
                            labelText: "Estado",
                            controller: _controller.tecEstado,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            labelText: "Bairro",
                            controller: _controller.tecBairro,
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: CustomTextFormField(
                            labelText: "Endereço",
                            controller: _controller.tecEndereco,
                          ),
                        ),
                      ],
                    ),
                    Wrap(
                      spacing: 20,
                      runSpacing: 10,
                      children: [
                        _buildBooleanTile("Cliente", _controller.cliente, _controller.setCliente),
                        _buildBooleanTile("Fornecedor", _controller.fornecedor, _controller.setFornecedor),
                        _buildBooleanTile("Funcionário", _controller.funcionario, _controller.setFuncionario),
                        _buildBooleanTile("Transportador", _controller.transportador, _controller.setTransportador),
                        _buildBooleanTile("Agência Bancária", _controller.agenciaBancaria, _controller.setAgenciaBancaria),
                      ],
                    ),
                    FilledButton(
                      onPressed: () async {
                        if (_controller.formKeyParceiro.currentState!.validate() && !_controller.isLoading) {
                          if (widget.parceiro == null) {
                            await _controller.createParceiro(context);
                          } else {
                            await _controller.updateParceiro(context, widget.parceiro!);
                          }
                        }
                      },
                      child: _controller.isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text("Salvar alterações"),
                    )
                  ],
                )
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBooleanTile(String title, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(value: value, onChanged: (value) => onChanged(value!)),
        Text(title),
      ],
    );
  }
}
