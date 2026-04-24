import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_radio.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/util/responsive_field.dart';
import 'package:brinquedoteca_flutter/controller/parametro/parametro_geral_controller.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FirstRowParametroGeral extends StatelessWidget {
  final ParametroGeralController controller;

  const FirstRowParametroGeral({
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
          width: 230,
          child: CustomTextFormField(
            prefixIcon: const Icon(Icons.timer),
            labelText: "Tolerância (minutos)",
            controller: controller.tecTolerancia,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            required: true,
          ),
        ),
        ResponsiveField(
          width: 200,
          child: CustomTextFormField(
            prefixIcon: const Icon(Icons.watch_later),
            labelText: 'Minutos Mínimo',
            controller: controller.tecMinutosMinimo,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            required: true,
          ),
        ),
        ResponsiveField(
          width: 200,
          child: CustomTextFormField(
            prefixIcon: const Icon(Icons.watch_later),
            labelText: 'Minutos Máximo',
            controller: controller.tecMinutosMaximo,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            required: true,
          ),
        ),
        ResponsiveField(
          width: 220,
          child: CustomTextFormField(
            prefixIcon: const Icon(Icons.attach_money),
            labelText: 'Valor Hr. Guarda Vol',
            controller: controller.tecValorHoraGuardaVolume,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CentavosInputFormatter(),
            ],
            required: true,
          ),
        ),
        ResponsiveField(
          width: 220,
          child: CustomTextFormField(
            prefixIcon: const Icon(Icons.attach_money),
            labelText: 'Valor Hr. Minuto Visita',
            controller: controller.tecValorMinutoVisita,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CentavosInputFormatter(),
            ],
            required: true,
          ),
        ),
        ResponsiveField(
          width: 200,
          child: CustomTextFormField(
            prefixIcon: const Icon(Icons.percent),
            labelText: 'Perc. mín. Fidel.',
            controller: controller.tecPercMinFildelidade,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CentavosInputFormatter(moeda: false),
            ],
            required: true,
          ),
        ),
      ],
    );
  }
}
