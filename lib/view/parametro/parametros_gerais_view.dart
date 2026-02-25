import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/parametro_geral/form/form_parametro_geral_component.dart';
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

          return Column(
            spacing: 10,
            children: [
              Expanded(child: FormParametroGeralComponent(controller: _controller)),
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
          );
        },
      ),
    );
  }
}
