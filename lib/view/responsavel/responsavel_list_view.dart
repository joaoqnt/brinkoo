import 'package:brinquedoteca_flutter/component/custom_appbar.dart';
import 'package:brinquedoteca_flutter/component/drawer/custom_drawer.dart';
import 'package:brinquedoteca_flutter/component/responsavel/card_responsavel.dart';
import 'package:brinquedoteca_flutter/component/row_search_textfield.dart';
import 'package:brinquedoteca_flutter/controller/responsavel/responsavel_list_controller.dart';
import 'package:brinquedoteca_flutter/view/responsavel/cadastro_responsavel_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ResponsavelListView extends StatefulWidget {
  const ResponsavelListView({super.key});

  @override
  State<ResponsavelListView> createState() => _ResponsavelListViewState();
}

class _ResponsavelListViewState extends State<ResponsavelListView> {
  final _controller = ResponsavelListController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.getResponsaveis(refresh: true);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        _controller.getResponsaveis();
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
        title: "Responsáveis",
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
              widget: CadastroResponsavelView(),
            ),
            Expanded(
              child: Observer(
                builder: (_) {
                  if (_controller.isLoading && _controller.responsaveis.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: _controller.responsaveis.length + 1,
                    itemBuilder: (context, index) {
                      if (index < _controller.responsaveis.length) {
                        return CardResponsavel(
                          responsavel: _controller.responsaveis[index],
                        );
                      } else {
                        // mostra loading só se ainda estiver buscando mais
                        return _controller.isLoading
                            ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                            : const SizedBox.shrink();
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

