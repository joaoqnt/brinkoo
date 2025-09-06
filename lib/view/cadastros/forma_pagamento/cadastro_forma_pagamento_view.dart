import 'package:brinquedoteca_flutter/component/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/drawer/custom_drawer.dart';
import 'package:brinquedoteca_flutter/component/custom_appbar.dart';
import 'package:brinquedoteca_flutter/controller/forma_pagamento/cadastro_forma_pagamento_controller.dart';
import 'package:brinquedoteca_flutter/model/forma_pagamento.dart';
import 'package:brinquedoteca_flutter/view/cadastros/cadastro_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CadastroFormaPagamentoView extends StatefulWidget {
  final FormaPagamento? formaPagamento;
  const CadastroFormaPagamentoView({super.key, this.formaPagamento});

  @override
  State<CadastroFormaPagamentoView> createState() => _CadastroFormaPagamentoViewState();
}

class _CadastroFormaPagamentoViewState extends State<CadastroFormaPagamentoView> {
  final _controller = CadastroFormaPagamentoController();

  @override
  void initState() {
    super.initState();
    _controller.setFormaPagamento(formaPagamento: widget.formaPagamento);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        useDrawer: false,
        showBackButton: true,
        title: "Cadastro de Forma de Pagamento",
        pageBackButton: CadastroView(initialIndex: 3),
      ),
      drawer: CustomDrawer(),
      body: Observer(
        builder: (context) {
          return Form(
            key: _controller.formKeyFormaPagamento,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: CustomTextFormField(
                          labelText: "Código",
                          controller: _controller.tecCodigo,
                          readOnly: true,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: CustomTextFormField(
                          labelText: "Descrição",
                          controller: _controller.tecDescricao,
                          required: true,
                        ),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: 150,
                        child: CustomTextFormField(
                          labelText: "Parcelas",
                          controller: _controller.tecNumeroParcelas,
                          keyboardType: TextInputType.number,
                          required: true,
                          validator: (value) {
                            final numParcelas = int.tryParse(value ?? '');
                            if (numParcelas == null || numParcelas <= 0) {
                              return "Informe um número válido";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        children: [
                          const Text("Ativo"),
                          Observer(
                            builder: (_) => Switch(
                              value: _controller.isAtivo,
                              onChanged: (val) => _controller.setAtivo(val),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  FilledButton(
                    onPressed: () async {
                      if (_controller.formKeyFormaPagamento.currentState!.validate() && !_controller.isLoading) {
                        if (widget.formaPagamento == null) {
                          await _controller.createFormaPagamento(context);
                        } else {
                          await _controller.updateFormaPagamento(context, widget.formaPagamento!);
                        }
                      }
                    },
                    child: _controller.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Salvar alterações"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
