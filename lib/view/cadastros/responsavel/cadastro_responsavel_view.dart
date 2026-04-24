import 'package:brinquedoteca_flutter/component/custom/custom_appbar.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_card_section.dart';
import 'package:brinquedoteca_flutter/component/responsavel/card_responsavel.dart';
import 'package:brinquedoteca_flutter/component/responsavel/form/form_cadastro_responsavel_component.dart';
import 'package:brinquedoteca_flutter/component/responsavel/list_responsavel.dart';
import 'package:brinquedoteca_flutter/component/util/row_search_textfield.dart';
import 'package:brinquedoteca_flutter/component/util/section_title.dart';
import 'package:brinquedoteca_flutter/controller/navigation_controller.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_responsavel_controller.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CadastroResponsavelView extends StatefulWidget {
  CadastroResponsavelView({
    super.key,
  });

  @override
  State<CadastroResponsavelView> createState() => _CadastroResponsavelViewState();
}

class _CadastroResponsavelViewState extends State<CadastroResponsavelView> {
  final _controller = Singleton().cadastroResponsavelController;


  @override
  Widget build(BuildContext context) {
    _controller.initializeScroll();
    return Scaffold(
      appBar: CustomAppBar(
        title: "Cadastro de Responsável",
      ),
      body: FutureBuilder(
        future: _controller.getResponsaveis(),
        builder: (context,snapshot) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Observer(
                builder: (context) {
                  return Column(
                    spacing: 20,
                    children: [
                      CustomCardSection(
                        child: FormCadastroResponsavelComponent(
                            controller: _controller,
                        ),
                      ),
                      CustomCardSection(
                        child: ListResponsavel(
                          controller: _controller,
                          responsaveis: _controller.responsaveis,
                          scrollController: _controller.scrollController,

                        )
                      ),
                    ],
                  );
                }
              ),
            ),
          );
        }
      ),
    );
  }
}
