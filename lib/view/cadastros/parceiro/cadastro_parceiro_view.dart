import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_card_section.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_radio.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/drawer/custom_drawer.dart';
import 'package:brinquedoteca_flutter/component/foto/foto_alter_component.dart';
import 'package:brinquedoteca_flutter/component/parceiro/card_parceiro.dart';
import 'package:brinquedoteca_flutter/component/parceiro/form/form_cadastro_parceiro_component.dart';
import 'package:brinquedoteca_flutter/component/parceiro/form/fifty_row_cadastro_parceiro.dart';
import 'package:brinquedoteca_flutter/component/util/responsive_field.dart';
import 'package:brinquedoteca_flutter/component/util/row_search_textfield.dart';
import 'package:brinquedoteca_flutter/component/util/section_title.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_parceiro_controller.dart';
import 'package:brinquedoteca_flutter/model/parceiro.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../component/custom/custom_appbar.dart';

class CadastroParceiroView extends StatefulWidget {
  final Parceiro? parceiro;
  CadastroParceiroView({super.key, this.parceiro});

  @override
  State<CadastroParceiroView> createState() => _CadastroParceiroViewState();
}

class _CadastroParceiroViewState extends State<CadastroParceiroView> {
  final _controller = CadastroParceiroController();

  @override
  Widget build(BuildContext context) {
    _controller.setParceiro(parceiro: widget.parceiro);
    return Scaffold(
      appBar: CustomAppBar(
        title: "Cadastro de Parceiro",
      ),
      body: FutureBuilder(
        future: _controller.getParceiros(),
        builder: (context,snapshot) {
          return Observer(
            builder: (context) {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    spacing: 20,
                    children: [
                      CustomCardSection(child: FormCadastroParceiroComponent(controller: _controller)),
                      Container(
                        height: 600,
                        child: CustomCardSection(
                          child: SingleChildScrollView(
                            child: Column(
                              spacing: 10,
                              children: [
                                SectionTitle(text: "Parceiros já cadastrado"),
                                RowSearchTextfield(
                                  tecController: _controller.tecPesquisa,
                                  onChanged: (p0) => _controller.getParceiros(reset: true),
                                ),
                                for(int i = 0; i < _controller.parceiros.length; i++)
                                  CardParceiro(parceiro: _controller.parceiros[i],controller: _controller,)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      ),
    );
  }
}
