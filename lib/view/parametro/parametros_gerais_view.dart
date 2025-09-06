import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/controller/parametro/parametro_geral_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ParametrosGeraisView extends StatefulWidget {
  const ParametrosGeraisView({super.key});

  @override
  State<ParametrosGeraisView> createState() => _ParametrosGeraisViewState();
}

class _ParametrosGeraisViewState extends State<ParametrosGeraisView> {
  final _controller = ParametroGeralController();

  @override
  void initState() {
    super.initState();
    _controller.carregarParametro();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) {
          if (_controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Form(
            key: _controller.formKeyParametro,
            child: Column(
              children: [
                SizedBox(height: 10,),
                Row(
                  spacing: 10,
                  children: [
                    _buildInputField(
                      label: 'Tolerância (minutos)',
                      controller: _controller.tecTolerancia,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    _buildInputField(
                      label: 'Minutos Mínimo',
                      controller: _controller.tecMinutosMinimo,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    _buildInputField(
                      label: 'Minutos Máximo',
                      controller: _controller.tecMinutosMaximo,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    _buildInputField(
                      label: 'Valor Hora Guarda-Volume',
                      controller: _controller.tecValorHoraGuardaVolume,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CentavosInputFormatter(moeda: true)
                      ],
                    ),
                    _buildInputField(
                      label: 'Valor Minuto Visita',
                      controller: _controller.tecValorMinutoVisita,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CentavosInputFormatter(moeda: true)
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                FilledButton(
                  onPressed: () async {
                    // Valida o form principal
                    if(_controller.formKeyParametro.currentState!.validate() && !_controller.isLoading){
                      _controller.salvarParametro(context);
                    }
                  },
                  child: _controller.isLoading
                      ? CircularProgressIndicator(color: Colors.white,)
                      : Text("Salvar alterações"),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required List<TextInputFormatter> inputFormatters,
  }) {
    return SizedBox(
      width: 250,
      child: CustomTextFormField(
        labelText: label,
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: inputFormatters,
        required: true,
      ),
    );
  }
}
