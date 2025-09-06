import 'package:brinquedoteca_flutter/component/crianca/card_crianca.dart';
import 'package:brinquedoteca_flutter/component/custom_appbar.dart';
import 'package:brinquedoteca_flutter/component/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/drawer/custom_drawer.dart';
import 'package:brinquedoteca_flutter/component/row_search_textfield.dart';
import 'package:brinquedoteca_flutter/controller/crianca/crianca_list_controller.dart';
import 'package:brinquedoteca_flutter/view/crianca/cadastro_crianca_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CriancaListView extends StatefulWidget {
  const CriancaListView({super.key});

  @override
  State<CriancaListView> createState() => _CriancaListViewState();
}

class _CriancaListViewState extends State<CriancaListView> {
  final _controller = CriancaListController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.getCriancas(reset: true);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        _controller.getCriancas();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Crianças",
        useDrawer: true,
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 10,
          children: [
            RowSearchTextfield(
              tecController: _controller.tecPesquisa,
              widget: CadastroCriancaView(),
              onChanged: (p0) async => await _controller.getCriancas(reset: true),
            ),
            Expanded(
              child: Observer(
                builder: (_) {
                  if (_controller.isLoading && _controller.criancas.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: _controller.criancas.length +
                        (_controller.hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < _controller.criancas.length) {
                        return CardCrianca(
                          crianca: _controller.criancas[index],
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
