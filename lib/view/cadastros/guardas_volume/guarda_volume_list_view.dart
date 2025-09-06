import 'package:brinquedoteca_flutter/component/guarda_volume/card_guarda_volume.dart';
import 'package:brinquedoteca_flutter/component/row_search_textfield.dart';
import 'package:brinquedoteca_flutter/controller/guarda_volume/guarda_volume_list_controller.dart';
import 'package:flutter/material.dart';

import 'cadastro_guarda_volume_view.dart';

class GuardaVolumeListView extends StatefulWidget {
  GuardaVolumeListView({super.key});

  @override
  State<GuardaVolumeListView> createState() => _GuardaVolumeListViewState();
}

class _GuardaVolumeListViewState extends State<GuardaVolumeListView> {
  final _controller = GuardaVolumeListController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _controller.getGuardasVolumes(),
        builder: (context,snapshot) {
          return snapshot.hasData ? Column(
            spacing: 10,
            children: [
              RowSearchTextfield(
                  tecController: _controller.tecPesquisa,
                  widget: CadastroGuardasVolumeView(),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: _controller.guardasVoulme.length,
                      itemBuilder: (context, index) {
                        return CardGuardaVolume(guardaVolume: _controller.guardasVoulme[index]);
                      },
                  )
              )
            ],
          ) : Center(child: CircularProgressIndicator(),);
        }
      ),
    );
  }
}
