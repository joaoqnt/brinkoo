import 'package:brinquedoteca_flutter/component/custom/custom_input_decoration.dart';
import 'package:brinquedoteca_flutter/component/responsavel/card_responsavel.dart';
import 'package:brinquedoteca_flutter/component/responsavel/dropdown_responsavel.dart';
import 'package:brinquedoteca_flutter/component/util/row_search_textfield.dart';
import 'package:brinquedoteca_flutter/component/util/section_title.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_crianca_controller.dart';
import 'package:brinquedoteca_flutter/controller/navigation_controller.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_responsavel_controller.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../util/responsive_field.dart';

class ListResponsavel extends StatelessWidget {
  final ScrollController? scrollController;
  final CadastroResponsavelController? controller;
  final List<Responsavel> responsaveis;
  final String title;
  final bool undefinedHeight;
  final bool fromCrianca;
  final CadastroCriancaController? cadastroCriancaController;

  const ListResponsavel({
    super.key,
    required this.responsaveis,
    this.scrollController,
    this.controller,
    this.title = "Responsáveis ja cadastrados",
    this.undefinedHeight = false,
    this.fromCrianca = false,
    this.cadastroCriancaController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: undefinedHeight ? null : 600,
      child: SingleChildScrollView(
        controller: scrollController,
        child: Observer(
          builder: (context) {
            return Column(
              spacing: 10,
              children: [
                SectionTitle(text: title),
                if(controller != null && !fromCrianca)
                  RowSearchTextfield(
                    tecController: controller!.tecPesquisa,
                    onChanged: (p0) async => await controller!.getResponsaveis(refresh: true),
                  ),
                if(fromCrianca )
                  Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: DropdownResponsavel(
                          onChanged: (p0) => cadastroCriancaController!.addResponsavel(responsavel: p0),
                          title: "Selecionar um responsável",
                          responsavel: null,
                          required: false,
                        ),
                      ),
                      FilledButton(
                          onPressed: () {
                            Singleton().cadastroResponsavelController.setResponsavel(responsavel: null);
                            Singleton().cadastroResponsavelController.setFromCrianca(true);
                            Singleton.instance.navigationController.setIndex(NavigationController().indexCadastroResponsavelView);
                          },
                          child: Icon(Icons.add)
                      )
                    ],
                  ),
                for(int i = 0; i < responsaveis.length; i++)
                  CardResponsavel(
                    responsavel: responsaveis[i],
                    controller: controller,
                    enableOnTap: cadastroCriancaController == null,
                    widget: fromCrianca ? Row(
                      spacing: 10,
                      children: [
                        ResponsiveField(
                          width: 220,
                          child: DropdownButtonFormField<String>(
                            // Ativa o preenchimento e define a cor de fundo idêntica ao TextField
                            decoration: CustomInputDecoration.build(
                                context: context,
                                required: true,
                                prefixIcon: Icon(Icons.person),
                                isDense: true,
                                labelText: "Relacionamento"
                            ),

                            // Ícone do Dropdown mais sutil
                            icon: Icon(Icons.arrow_drop_down, color: Colors.grey.shade600),

                            validator: (value) {
                              if (value == null) return "Campo obrigatório";
                              return null;
                            },
                            value: responsaveis[i].parentesco,
                            items: cadastroCriancaController!.tiposRelacionamento.map((tipo) {
                              return DropdownMenuItem<String>(
                                value: tipo,
                                child: Text(
                                  tipo,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              cadastroCriancaController?.setRelacionamento(responsaveis[i], value!);
                            },
                          ),
                        ),
                        IconButton(
                            tooltip: "Editar responsável",
                            onPressed: () {
                              Singleton().cadastroResponsavelController.setResponsavel(responsavel: responsaveis[i]);
                              Singleton().cadastroResponsavelController.setFromCrianca(true);
                              Singleton.instance.navigationController.setIndex(NavigationController().indexCadastroResponsavelView);                            },
                            icon: Icon(Icons.edit,color: Colors.blue)
                        ),
                        IconButton(
                            tooltip: "Remover relacionamento",
                            onPressed: () {
                              cadastroCriancaController?.removeResponsavel(responsaveis[i]);
                            },
                            icon: Icon(Icons.delete,color: Colors.red)
                        ),
                      ],
                    ) : null,
                  )
              ],
            );
          }
        ),
      ),
    );
  }
}
