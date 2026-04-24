import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/atividade/dropdown_atividade.dart';
import 'package:brinquedoteca_flutter/component/atividade/wrap_atividade.dart';
import 'package:brinquedoteca_flutter/component/crianca/card_crianca.dart';
import 'package:brinquedoteca_flutter/component/crianca/dropdown_crianca.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_appbar.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_card_section.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_form_action.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_tab_bar.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/forma_pagamento/dropdown_forma_pagamento.dart';
import 'package:brinquedoteca_flutter/component/guarda_volume/dropdown_guarda_volume.dart';
import 'package:brinquedoteca_flutter/component/responsavel/dropdown_multiselection_responsavel.dart';
import 'package:brinquedoteca_flutter/component/responsavel/dropdown_responsavel.dart';
import 'package:brinquedoteca_flutter/component/util/section_title.dart';
import 'package:brinquedoteca_flutter/component/usuario/dropdown_usuario.dart';
import 'package:brinquedoteca_flutter/controller/navigation_controller.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:brinquedoteca_flutter/view/checkin/entrada_checkin.dart';
import 'package:brinquedoteca_flutter/view/checkin/saida_checkin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CadastroCheckinView extends StatefulWidget {

  CadastroCheckinView({
    super.key,
  });

  @override
  State<CadastroCheckinView> createState() => _CadastroCheckinViewState();
}

class _CadastroCheckinViewState extends State<CadastroCheckinView> with TickerProviderStateMixin{
  final _controller = Singleton().cadastroCheckinController;

  @override
  void initState() {
    _controller.initTabController(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    _controller.setParametro();
    return Scaffold(
      appBar: CustomAppBar(
        title: "Cadastro de Check-in",
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Observer(
            builder: (context) {
              return Form(
                key: _controller.formKey,
                child: Column(
                  spacing: 20,
                  children: [
                    CustomTabBar(
                      controller: _controller.tabController,
                      tabs: _controller.tabs,
                      onTap: (value) {
                        _controller.setIndexPage(value);
                      },
                      rightAction: CustomFormAction(
                        onClear: () => _controller.setCheckin(checkin: null),
                        onSave: () async {
                          if(!_controller.isLoading &&
                              _controller.validate(context, checkin: _controller.checkinSelected)) {

                            if(_controller.checkinSelected == null) {
                              await _controller.createCheckin(context);
                            } else {
                              await _controller.updateCheckin(context);
                            }
                            await Singleton().checkinListController.getCheckins(refresh: true);
                            await Singleton().inicioController.initAll();
                            _controller.setCheckin(checkin: null);

                            if(_controller.isFromHome){
                              Singleton().navigationController.setIndex(Singleton().navigationController.indexHomeView);
                              _controller.setIsFromHome(false);
                            } else if(_controller.isFromCheckinList){
                              Singleton().navigationController.setIndex(Singleton().navigationController.indexCheckinListView);
                              _controller.setIsFromCheckinList(false);
                            }
                          }
                        },
                        isLoading: _controller.isLoading,
                      ),
                    ),
                    if(_controller.indexPage == 0)
                      EntradaCheckin(controller: _controller),
                    if(_controller.indexPage == 1)
                      SaidaCheckin(controller: _controller),
                  ],
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}