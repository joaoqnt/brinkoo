import 'package:brinquedoteca_flutter/component/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/component/foto/foto_alter_component.dart';
import 'package:brinquedoteca_flutter/component/responsavel/dropdown_responsavel.dart';
import 'package:brinquedoteca_flutter/controller/crianca/cadastro_crianca_controller.dart';
import 'package:brinquedoteca_flutter/controller/responsavel/cadastro_responsavel_controller.dart';
import 'package:brinquedoteca_flutter/model/crianca.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../utils/responsive.dart';
import '../custom_textformfield.dart';

class FormCadastroResponsavelComponent extends StatelessWidget {
  final CadastroResponsavelController controller;
  final CadastroCriancaController? criancaController;
  final Responsavel? responsavel;
  final Crianca? crianca;

  const FormCadastroResponsavelComponent({
    super.key,
    required this.controller,
    this.responsavel,
    this.criancaController,
    this.crianca,
  });

  /// Helper para evitar erro de Expanded em Wrap
  Widget responsiveField({required bool isMobile, required Widget child}) {
    return isMobile
        ? SizedBox(width: double.infinity, child: child)
        : Expanded(child: child);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      bool isMobile = Responsive.isMobile(context);

      return Form(
        key: controller.formKeyResponsavel,
        child: isMobile
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: FotoAlterComponent(
                capturedImageBytes: controller.responsavelImage,
                onAdd: (p0) => controller.addFoto(p0),
                imageUrl: (responsavel?.urlImage) ??
                    controller.responsavelSelected?.urlImage,
              ),
            ),
            const SizedBox(height: 20),
            _buildFormFields(context, isMobile),
            if (criancaController != null)
              IconButton(
                onPressed: () {
                  criancaController!.removeResponsavel(
                      responsavel!, controller);
                },
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
          ],
        )
            : Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FotoAlterComponent(
              capturedImageBytes: controller.responsavelImage,
              onAdd: (p0) => controller.addFoto(p0),
              imageUrl: (responsavel?.urlImage) ??
                  controller.responsavelSelected?.urlImage,
            ),
            const SizedBox(width: 20),
            Expanded(child: _buildFormFields(context, isMobile)),
            if (criancaController != null)
              IconButton(
                onPressed: () {
                  criancaController!.removeResponsavel(
                      responsavel!, controller);
                },
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
          ],
        ),
      );
    });
  }

  Widget _buildFormFields(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (criancaController != null)
          DropdownResponsavel(
            responsaveis: crianca != null ? crianca!.responsaveis : null,
            onChanged: (p0) => controller.setResponsavel(responsavel: p0),
            title: "Selecione um responsável",
            required: false,
            responsavel: responsavel,
            enabled: (responsavel == null || responsavel?.nome == null),
          ),
        const SizedBox(height: 10),

        // Primeira linha
        isMobile
            ? Wrap(runSpacing: 10, spacing: 10, children: _buildPrimeiraLinhaCampos(isMobile))
            : Row(spacing: 10, children: _buildPrimeiraLinhaCampos(isMobile)),

        const SizedBox(height: 10),

        // Segunda linha
        isMobile
            ? Wrap(runSpacing: 10, spacing: 10, children: _buildSegundaLinhaCampos(isMobile,context))
            : Row(spacing: 10, children: _buildSegundaLinhaCampos(isMobile,context)),
      ],
    );
  }

  List<Widget> _buildPrimeiraLinhaCampos(bool isMobile) {
    return [
      responsiveField(
        isMobile: isMobile,
        child: CustomTextFormField(
          prefixIcon: const Icon(Icons.person),
          labelText: "Nome do responsável",
          controller: controller.tecNome,
          required: true,
        ),
      ),
      SizedBox(
        width: 180,
        child: CustomTextFormField(
          prefixIcon: const Icon(Icons.document_scanner),
          labelText: "Documento",
          controller: controller.tecDocumento,
          required: true,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CpfInputFormatter()
          ],
        ),
      ),
      SizedBox(
        width: 200,
        child: CustomTextFormField(
          prefixIcon: const Icon(Icons.phone_android),
          labelText: "Telefone",
          controller: controller.tecTelefone,
          required: true,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            TelefoneInputFormatter()
          ],
        ),
      ),
      responsiveField(
        isMobile: isMobile,
        child: CustomTextFormField(
          prefixIcon: const Icon(Icons.email),
          labelText: "Email",
          controller: controller.tecEmail,
          required: true,
        ),
      ),
      if (criancaController != null)
        SizedBox(
          width: 250,
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.person_outline),
              labelText: "Relacionamento",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              isDense: true,
            ),
            validator: (value) {
              if (value == null) return "Obrigatório";
              return null;
            },
            value: criancaController!.relacionamentoSelected[responsavel],
            items: criancaController!.tiposRelacionamento.map((entry) {
              return DropdownMenuItem<String>(
                value: entry,
                child: Text(entry),
              );
            }).toList(),
            onChanged: (value) {
              criancaController!.setRelacionamento(responsavel!, value!);
            },
          ),
        ),
    ];
  }

  List<Widget> _buildSegundaLinhaCampos(bool isMobile,BuildContext context) {
    return [
      SizedBox(
        width: 200,
        child: CustomTextFormField(
          prefixIcon: const Icon(Icons.reduce_capacity),
          labelText: "Cep",
          controller: controller.tecCep,
          required: true,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CepInputFormatter()
          ],
        ),
      ),
      FilledButton.tonal(
          onPressed: () async{
            if(controller.tecCep.text.isNotEmpty && UtilBrasilFields.removeCaracteres(controller.tecCep.text).length == 8) {
              controller.setEnderecoByCep();
            } else {
              CustomSnackBar.error(context, 'Cep inválido');
            }
          },
          child: Icon(Icons.search)
      ),
      SizedBox(
        width: 130,
        child: CustomTextFormField(
          prefixIcon: const Icon(Icons.map),
          labelText: "Estado",
          controller: controller.tecEstado,
          required: true,
        ),
      ),
      responsiveField(
        isMobile: isMobile,
        child: CustomTextFormField(
          prefixIcon: const Icon(Icons.location_city),
          labelText: "Cidade",
          controller: controller.tecCidade,
          required: true,
        ),
      ),
      responsiveField(
        isMobile: isMobile,
        child: CustomTextFormField(
          prefixIcon: const Icon(Icons.streetview),
          labelText: "Bairro",
          controller: controller.tecBairro,
          required: true,
        ),
      ),
      responsiveField(
        isMobile: isMobile,
        child: CustomTextFormField(
          prefixIcon: const Icon(Icons.add_location),
          labelText: "Endereço",
          controller: controller.tecEndereco,
          required: true,
        ),
      ),
    ];
  }
}
