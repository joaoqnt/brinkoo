import 'package:brinquedoteca_flutter/component/custom/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/controller/inicio_controller.dart';
import 'package:brinquedoteca_flutter/events/checkin/dialog_checkout.dart';
import 'package:brinquedoteca_flutter/model/checkin.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../component/checkin/card_checkin_timer.dart';
import '../component/custom/custom_appbar.dart';
import '../component/drawer/custom_drawer.dart';
import '../component/util/row_search_textfield.dart';
import 'checkin/cadastro_checkin_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _controller = Singleton().inicioController;
  final _checkinController = Singleton().checkinListController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Painel de Check-in",
      ),
      body: FutureBuilder(
        future: _controller.initAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              spacing: 10,
              children: [
                Observer(
                  builder: (context) {
                    return Row(
                      children: [
                        if(Singleton.instance.usuario?.empresa != null)...[
                          Expanded(child: Text("${Singleton.instance.usuario?.empresa?.descricao}")),
                        ],
                        FilledButton(
                            onPressed: () {
                              if(!_checkinController.hasAnySelected()) {
                                CustomSnackBar.error(context, "Favor selecionar ao menos um atendimento.");
                              } else {
                                List<Responsavel> responsaveis = _checkinController.getCommonResponsaveis();
                                List<Checkin> checkins = _checkinController.getCheckinsSelected();
                                if(responsaveis.isEmpty){
                                  CustomSnackBar.error(context, "As crianças não possuem nenhum responsável pela saida em comum.");
                                } else {
                                  DialogCheckout().show(context, checkins, responsaveis);
                                }
                              }
                            },
                            child: Text("Fechar um ou mais")
                        )

                      ],
                    );
                  }
                ),
                Observer(
                  builder: (context) {
                    return Expanded(
                      child: GridView.builder(
                        itemCount: _controller.checkins.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4, // ou ajuste conforme necessário
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (context, index) {
                          final checkin = _controller.checkins[index];
                          return CardCheckinTimer(checkin: checkin,controller: _checkinController);
                        },
                      ),
                    );
                  }
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
