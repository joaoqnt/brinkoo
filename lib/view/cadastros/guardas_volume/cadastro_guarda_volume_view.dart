import 'package:brinquedoteca_flutter/component/custom/custom_card_section.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/drawer/custom_drawer.dart';
import 'package:brinquedoteca_flutter/component/generic/text_form_field/codigo.dart';
import 'package:brinquedoteca_flutter/component/guarda_volume/card_guarda_volume.dart';
import 'package:brinquedoteca_flutter/component/guarda_volume/form/form_guarda_volume.dart';
import 'package:brinquedoteca_flutter/component/util/row_search_textfield.dart';
import 'package:brinquedoteca_flutter/component/util/section_title.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_guarda_volume_controller.dart';
import 'package:brinquedoteca_flutter/model/guarda_volume.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../component/custom/custom_appbar.dart';

class CadastroGuardasVolumeView extends StatefulWidget {
  final GuardaVolume? guardaVolume;
  CadastroGuardasVolumeView({
    super.key,
    this.guardaVolume,
  });

  @override
  State<CadastroGuardasVolumeView> createState() => _CadastroGuardasVolumeViewState();
}

class _CadastroGuardasVolumeViewState extends State<CadastroGuardasVolumeView> {
  final _controller = Singleton().cadastroGuardaVolumeController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Cadastro de Guardas Volume",
      ),
      body: FutureBuilder(
        future: _controller.getGuardasVolumes(),
        builder: (context,snapshot) {
          return Observer(
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  spacing: 20,
                  children: [
                    CustomCardSection(child: FormGuardaVolume(controller: _controller)),
                    Expanded(
                      child: CustomCardSection(
                        child: Column(
                          spacing: 10,
                          children: [
                            SectionTitle(text: "Guardas Volume já cadastrados"),
                            RowSearchTextfield(
                              tecController: _controller.tecPesquisa,
                              onChanged: (p0) async => await _controller.getGuardasVolumes(descricao: _controller.tecPesquisa.text),
                            ),
                            Expanded(
                                child: !snapshot.hasData ? Center(child: CircularProgressIndicator()) : ListView.builder(
                                  itemCount: _controller.guardasVoulme.length,
                                  itemBuilder: (context, index) {
                                    return CardGuardaVolume(
                                      guardaVolume: _controller.guardasVoulme[index],
                                      controller: _controller,
                                    );
                                  },
                                )
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          );
        }
      ),
    );
  }
}
