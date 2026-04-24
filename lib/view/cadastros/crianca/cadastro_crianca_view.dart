import 'package:brinquedoteca_flutter/component/atividade/wrap_atividade.dart';
import 'package:brinquedoteca_flutter/component/crianca/card_crianca.dart';
import 'package:brinquedoteca_flutter/component/crianca/form/form_cadastro_crianca_component.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_appbar.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_card_section.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_input_decoration.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_tab_bar.dart';
import 'package:brinquedoteca_flutter/component/responsavel/card_responsavel.dart';
import 'package:brinquedoteca_flutter/component/responsavel/list_responsavel.dart';
import 'package:brinquedoteca_flutter/component/util/responsive_field.dart';
import 'package:brinquedoteca_flutter/component/util/row_search_textfield.dart';
import 'package:brinquedoteca_flutter/component/util/section_title.dart';
import 'package:brinquedoteca_flutter/controller/checkin/cadastro_checkin_controller.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_crianca_controller.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_responsavel_controller.dart';
import 'package:brinquedoteca_flutter/events/crianca/filter_crianca_dialog.dart';
import 'package:brinquedoteca_flutter/model/crianca.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CadastroCriancaView extends StatefulWidget {
  final CadastroCheckinController? checkinController;
  final bool fromCheckin;

  CadastroCriancaView({
    super.key,
    this.checkinController,
    this.fromCheckin = false,
  });

  @override
  State<CadastroCriancaView> createState() => _CadastroCriancaViewState();
}

class _CadastroCriancaViewState extends State<CadastroCriancaView> with TickerProviderStateMixin{
  final _controller = Singleton().cadastroCriancaController;

  @override
  void initState() {
    _controller.initTabController(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Cadastro de Criança",
      ),
      body: FutureBuilder(
        future: _controller.getCriancas(),
        builder: (context,snapshot) {
          return Container(
            padding: EdgeInsets.all(20),
            child: Observer(
              builder: (context) {
                return _controller.indexPage == 0 ? SingleChildScrollView(
                  child: Form(
                    key: _controller.formKeyCrianca,
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
                        CustomCardSection(child: FormCadastroCriancaComponent(controller: _controller)),
                        CustomCardSection(
                            child: ListResponsavel(
                              responsaveis: _controller.responsaveis,
                              controller: Singleton().cadastroResponsavelController,
                              title: "Responsáveis da criança",
                              undefinedHeight: true,
                              fromCrianca: true,
                              cadastroCriancaController: _controller,
                            )
                        ),
                        CustomCardSection(
                            child: Column(
                              spacing: 10,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SectionTitle(text: "Atividades"),
                                ListAtividade(
                                  atividades: _controller.atividades,
                                  atividadesSelected: _controller.atividadesSelected,
                                  onSelected: (atividade, selected) {
                                    _controller.toggleAtividade(atividade);
                                  },
                                )
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                ) : Column(
                  spacing: 20,
                  children: [
                    CustomTabBar(
                      controller: _controller.tabController,
                      tabs: _controller.tabs,
                      onTap: (value) {
                        _controller.setIndexPage(value);
                      },
                    ),
                    Expanded(
                      child: CustomCardSection(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 10,
                          children: [
                            SectionTitle(
                              text: "Crianças já cadastradas",
                            ),
                            RowSearchTextfield(
                              tecController: _controller.tecPesquisa,
                              filter: true,
                              onFilterPressed: () {
                                FilterCriancaDialog().show(context, _controller);
                              },
                              onChanged: (p0) async => await _controller.getCriancas(reset: true),
                            ),
                            Expanded(
                              child: ListView.builder(
                                controller: _controller.scrollController,
                                itemCount: _controller.criancas.length +
                                    (_controller.hasMore ? 1 : 0),
                                itemBuilder: (context, index) {
                                  if (index < _controller.criancas.length) {
                                    return CardCrianca(
                                      crianca: _controller.criancas[index],
                                      controller: _controller,
                                    );
                                  } else {
                                    // indicador de carregando na última linha
                                    return const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 16),
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            ),
          );
        }
      ),
    );
  }
}
