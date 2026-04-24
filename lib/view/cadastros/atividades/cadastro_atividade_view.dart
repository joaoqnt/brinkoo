import 'package:brinquedoteca_flutter/component/atividade/card_atividade.dart';
import 'package:brinquedoteca_flutter/component/atividade/form/form_cadastro_atividade.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_card_section.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_input_decoration.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_radio.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/drawer/custom_drawer.dart';
import 'package:brinquedoteca_flutter/component/util/responsive_field.dart';
import 'package:brinquedoteca_flutter/component/util/row_search_textfield.dart';
import 'package:brinquedoteca_flutter/component/util/section_title.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_atividade_controller.dart';
import 'package:brinquedoteca_flutter/model/atividade.dart';
import 'package:brinquedoteca_flutter/model/tmp/icone_atividade.dart';
import 'package:brinquedoteca_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../component/custom/custom_appbar.dart';

class CadastroAtividadeView extends StatefulWidget {
  final Atividade? atividade;
  CadastroAtividadeView({
    super.key,
    this.atividade,
  });

  @override
  State<CadastroAtividadeView> createState() => _CadastroAtividadeViewState();
}

class _CadastroAtividadeViewState extends State<CadastroAtividadeView> {
  final _controller = CadastroAtividadeController();

  @override
  Widget build(BuildContext context) {
    _controller.setAtividade(atividade: widget.atividade);
    return Scaffold(
      appBar: CustomAppBar(
        title: "Cadastro de Atividade",
      ),
      body: Observer(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              spacing: 20,
              children: [
                CustomCardSection(child: FormCadastroAtividade(controller: _controller)),
                Expanded(
                  child: CustomCardSection(
                    child: FutureBuilder(
                        future: _controller.getAtividades(),
                        builder: (context,snapshot) {
                          return snapshot.hasData ? Column(
                            spacing: 10,
                            children: [
                              SectionTitle(
                                  text: "Atividades já cadastradas"
                              ),
                              Expanded(
                                  child: ListView.builder(
                                    itemCount: _controller.atividades.length,
                                    itemBuilder: (context, index) {
                                      return CardAtividade(atividade: _controller.atividades[index],controller: _controller,);
                                    },
                                  )
                              )
                            ],
                          ) : Center(child: CircularProgressIndicator(),);
                        }
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
