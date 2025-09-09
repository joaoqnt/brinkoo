import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/centro_custo/dropdown_centro_custo.dart';
import 'package:brinquedoteca_flutter/component/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/drawer/custom_drawer.dart';
import 'package:brinquedoteca_flutter/component/empresa/dropdown_empresa.dart';
import 'package:brinquedoteca_flutter/component/natureza/dropdown_natureza.dart';
import 'package:brinquedoteca_flutter/controller/convenio/cadastro_convenio_controller.dart';
import 'package:brinquedoteca_flutter/model/convenio.dart';
import 'package:brinquedoteca_flutter/view/cadastros/cadastro_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../component/custom_appbar.dart';

class CadastroConvenioView extends StatefulWidget {
  final Convenio? convenio;

  CadastroConvenioView({
    super.key,
    this.convenio,
  });

  @override
  State<CadastroConvenioView> createState() => _CadastroConvenioViewState();
}

class _CadastroConvenioViewState extends State<CadastroConvenioView> {
  final _controller = CadastroConvenioController();

  @override
  void initState() {
    super.initState();
    _controller.setConvenio(convenio: widget.convenio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        useDrawer: false,
        showBackButton: true,
        title: "Cadastro de Convênios",
        pageBackButton: CadastroView(initialIndex: 2),
      ),
      drawer: CustomDrawer(),
      body: Observer(builder: (context) {
        return Form(
          key: _controller.formKeyConvenio,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Linha Código + Nome
                Row(
                  children: [
                    SizedBox(
                      width: 150,
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
                  ],
                ),
                /// Linha centro de custo, natureza
                Row(
                  children: [
                    Expanded(
                        child: DropdownCentroCusto(
                          required: true,
                          centroCusto: _controller.centroCustoSelected,
                          onChanged: (p0) => _controller.setCentroCusto(centrocusto: p0),
                        )
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                        child: DropdownNatureza(
                          required: true,
                          natureza: _controller.naturezaSelected,
                          onChanged: (p0) => _controller.setNatureza(natureza: p0),
                        )
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                        child: DropdownEmpresa(
                          required: true,
                          empresaSelected: _controller.empresaSelected,
                          onChanged: (p0) => _controller.setEmpresa(empresa: p0),
                        )
                    ),
                  ],
                ),
                /// Datas
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        labelText: "Data Expiração",
                        controller: _controller.tecDataExpiracao,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          DataInputFormatter(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: CustomTextFormField(
                        labelText: "Dia Vencimento",
                        controller: _controller.tecDiaVencimento,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                  ],
                ),

                /// Valores percentuais e monetários
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        labelText: "Perc. Convênio",
                        controller: _controller.tecPercConvenio,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CentavosInputFormatter(moeda: false),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: CustomTextFormField(
                        labelText: "Perc. Empresa",
                        controller: _controller.tecPercEmpresa,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CentavosInputFormatter(moeda: false),
                        ],
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        labelText: "Valor Convênio",
                        controller: _controller.tecValorConvenio,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CentavosInputFormatter(moeda: true),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: CustomTextFormField(
                        labelText: "Valor Empresa",
                        controller: _controller.tecValorEmpresa,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CentavosInputFormatter(moeda: true),
                        ],
                      ),
                    ),
                  ],
                ),

                /// Quantidades
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        labelText: "Qtd Visita",
                        controller: _controller.tecQtdVisita,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: CustomTextFormField(
                        labelText: "Max. Visita",
                        controller: _controller.tecMaxVisita,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: CustomTextFormField(
                        labelText: "Min. Dia Vencimento",
                        controller: _controller.tecMinDiaVencimento,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      ),
                    ),
                  ],
                ),

                /// Observação
                CustomTextFormField(
                  labelText: "Observação",
                  controller: _controller.tecObservacao,
                  maxLines: 3,
                ),

                /// Ativo
                SwitchListTile(
                  title: const Text("Ativo"),
                  value: _controller.isAtivo,
                  onChanged: (v) => setState(() {
                    _controller.isAtivo = v;
                  }),
                ),

                /// Botão Salvar
                Center(
                  child: FilledButton(
                    onPressed: () async {
                      if (_controller.formKeyConvenio.currentState!.validate() &&
                          !_controller.isLoading) {
                        if (widget.convenio == null) {
                          await _controller.createConvenio(context);
                        } else {
                          await _controller.updateConvenio(context, widget.convenio!);
                        }
                      }
                    },
                    child: _controller.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Salvar alterações"),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
