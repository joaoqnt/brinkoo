import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/responsive_field.dart';
import 'package:brinquedoteca_flutter/controller/crianca/cadastro_crianca_controller.dart';
import 'package:brinquedoteca_flutter/controller/responsavel/cadastro_responsavel_controller.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SecondRowCadastroCrianca extends StatelessWidget {
  final CadastroCriancaController controller;

  const SecondRowCadastroCrianca({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Responsive.isDesktop(context) ? Axis.horizontal : Axis.vertical,
      spacing: 10,
      children: [
        ResponsiveField(
          child: CustomTextFormField(
            prefixIcon: const Icon(Icons.calendar_month),
            labelText: "Data de nasc.",
            controller: controller.tecDataCrianca,
            required: true,
            onChanged: (p0) {
              controller.setIdadeCrianca();
            },
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              DataInputFormatter()
            ],
          ),
        ),
        ResponsiveField(
          child: CustomTextFormField(
            prefixIcon: const Icon(Icons.cake),
            labelText: "Idade",
            controller: controller.tecIdadeCrianca,
            enabled: false,
          ),
        ),
        ResponsiveField(
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.person_outline),
              labelText: "Sexo",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              isDense: true,
            ),
            validator: (value) {
              if (value == null) {
                return "Obrigatório";
              }
              return null;
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
        ResponsiveField(
          child: CustomTextFormField(
            prefixIcon: const Icon(Icons.local_pharmacy),
            labelText: "Alergias",
            controller: controller.tecAlergiaCrianca,
          ),
        ),
        ResponsiveField(
          width: 160,
          child: CustomTextFormField(
            prefixIcon: const Icon(Icons.bloodtype),
            labelText: "Grupo sang.",
            controller: controller.tecGrupoSanguineoCrianca,
          ),
        ),
      ],
    );
  }
}
