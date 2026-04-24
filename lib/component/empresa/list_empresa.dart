import 'package:brinquedoteca_flutter/component/custom/custom_card_section.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_input_decoration.dart';
import 'package:brinquedoteca_flutter/component/empresa/card_empresa.dart';
import 'package:brinquedoteca_flutter/component/responsavel/card_responsavel.dart';
import 'package:brinquedoteca_flutter/component/responsavel/dropdown_responsavel.dart';
import 'package:brinquedoteca_flutter/component/util/row_search_textfield.dart';
import 'package:brinquedoteca_flutter/component/util/section_title.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_crianca_controller.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_empresa_controller.dart';
import 'package:brinquedoteca_flutter/controller/navigation_controller.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_responsavel_controller.dart';
import 'package:brinquedoteca_flutter/model/empresa.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../util/responsive_field.dart';

class ListEmpresa extends StatelessWidget {
  final ScrollController? scrollController;
  final CadastroEmpresaController controller;
  final String title;

  const ListEmpresa({
    super.key,
    required this.controller,
    this.scrollController,
    this.title = "Empresas ja cadastradas",
  });

  @override
  Widget build(BuildContext context) {
    return CustomCardSection(
      child: SingleChildScrollView(
        controller: scrollController,
        child: Observer(
            builder: (context) {
              return Column(
                spacing: 10,
                children: [
                  SectionTitle(text: title),
                  for(int i = 0; i < controller.empresas.length; i++)
                    CardEmpresa(
                      empresa: controller.empresas[i],
                    )
                ],
              );
            }
        ),
      ),
    );
  }
}
