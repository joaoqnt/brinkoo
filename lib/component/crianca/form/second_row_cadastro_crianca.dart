import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_border.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_input_decoration.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/util/responsive_field.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_crianca_controller.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_responsavel_controller.dart';
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
          width: 170,
          child: CustomTextFormField(
            prefixIcon: const Icon(Icons.calendar_month),
            labelText: "Data nasc.",
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
          width: 110,
          child: CustomTextFormField(
            prefixIcon: const Icon(Icons.cake),
            labelText: "Idade",
            controller: controller.tecIdadeCrianca,
            enabled: false,
          ),
        ),
        ResponsiveField(
          width: 180,
          child: DropdownButtonFormField<String>(
            // Ativa o preenchimento e define a cor de fundo idêntica ao TextField
            decoration: CustomInputDecoration.build(
                context: context,
              required: true,
              prefixIcon: Icon(Icons.person),
              isDense: true,
              labelText: "Sexo"
            ),

            // Ícone do Dropdown mais sutil
            icon: Icon(Icons.arrow_drop_down, color: Colors.grey.shade600),

            validator: (value) {
              if (value == null) return "Campo obrigatório";
              return null;
            },
            value: controller.sexoCrianca.keys.firstOrNull,
            items: controller.sexos.entries.map((entry) {
              return DropdownMenuItem<String>(
                value: entry.key,
                child: Text(entry.value, style: const TextStyle(fontSize: 14)),
              );
            }).toList(),
            onChanged: (value) => controller.setSexoCrianca(value),
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
