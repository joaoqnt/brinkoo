import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/centro_custo/dropdown_centro_custo.dart';
import 'package:brinquedoteca_flutter/component/convenio/card_convenio.dart';
import 'package:brinquedoteca_flutter/component/convenio/form/form_cadastro_convenio.dart';
import 'package:brinquedoteca_flutter/component/convenio/list_convenio.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_card_section.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_tab_bar.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/drawer/custom_drawer.dart';
import 'package:brinquedoteca_flutter/component/empresa/dropdown_empresa.dart';
import 'package:brinquedoteca_flutter/component/generic/text_form_field/codigo.dart';
import 'package:brinquedoteca_flutter/component/natureza/dropdown_natureza.dart';
import 'package:brinquedoteca_flutter/component/util/row_search_textfield.dart';
import 'package:brinquedoteca_flutter/component/util/section_title.dart';
import 'package:brinquedoteca_flutter/controller/configuracao/cadastro_convenio_controller.dart';
import 'package:brinquedoteca_flutter/model/convenio/convenio.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../component/custom/custom_appbar.dart';

class CadastroConvenioView extends StatefulWidget {
  final Convenio? convenio;

  CadastroConvenioView({
    super.key,
    this.convenio,
  });

  @override
  State<CadastroConvenioView> createState() => _CadastroConvenioViewState();
}

class _CadastroConvenioViewState extends State<CadastroConvenioView> with TickerProviderStateMixin {
  final _controller = Singleton().cadastroConvenioController;

  @override
  void initState() {
    _controller.initTabController(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Cadastro de Convênios",
      ),
      body: Observer(builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              spacing: 20,
              children: [
                CustomTabBar(
                  controller: _controller.tabController,
                  tabs: _controller.tabs,
                  onTap: (value) {
                    _controller.setIndexPage(value);
                  },
                ),
                if(_controller.indexPage == 0)
                  FormCadastroConvenio(controller: _controller),
                if(_controller.indexPage == 1)
                  CustomCardSection(
                    child: Column(
                      spacing: 10,
                      children: [
                        SectionTitle(text: "Convênios já cadastrados"),
                        ListConvenio(controller: _controller),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
