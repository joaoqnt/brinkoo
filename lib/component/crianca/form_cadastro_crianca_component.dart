import 'package:brinquedoteca_flutter/controller/crianca/cadastro_crianca_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';

import '../custom_textformfield.dart';

class FormCadastroCriancaComponent extends StatelessWidget {
  final CadastroCriancaController controller;
  const FormCadastroCriancaComponent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKeyCrianca,
      child: Column(
        spacing: 10,
        children: [
          Row(
            spacing: 10,
            children: [
              Expanded(
                child: CustomTextFormField(
                  prefixIcon: Icon(Icons.person),
                  labelText: "Nome da criança",
                  controller: controller.tecNomeCrianca,
                  required: true,
                ),
              ),
              Expanded(
                child: CustomTextFormField(
                  prefixIcon: Icon(Icons.calendar_month),
                  labelText: "Data de nascimento",
                  controller: controller.tecDataCrianca,
                  required: true,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    DataInputFormatter()
                  ],
                ),
              ),
            ],
          ),
          Row(
            spacing: 10,
            children: [
              SizedBox(
                width: 200,
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_outline),
                    labelText: "Sexo",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    isDense: true,
                  ),
                  validator: (value) {
                    if(value == null)
                      return "Obrigatório";
                  },
                  value: controller.sexoCrianca.keys.firstOrNull,
                  items: controller.sexos.entries.map((entry) {
                    return DropdownMenuItem<String>(
                      value: entry.key,
                      child: Text(entry.value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    controller.setSexoCrianca(value);
                  },
                ),
              ),
              Expanded(
                child: CustomTextFormField(
                  prefixIcon: Icon(Icons.bloodtype),
                  labelText: "Grupo sanguíneo",
                  controller: controller.tecGrupoSanguineoCrianca,
                ),
              ),
              Expanded(
                child: CustomTextFormField(
                  prefixIcon: Icon(Icons.local_pharmacy),
                  labelText: "Alergias",
                  controller: controller.tecAlergiaCrianca,
                ),
              ),
            ],
          ),
          Row(
            spacing: 10,
            children: [
              Expanded(
                child: CustomTextFormField(
                  prefixIcon: Icon(Icons.description),
                  labelText: "Observações",
                  controller: controller.tecObservacaoCrianca,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
