import 'package:brinquedoteca_flutter/component/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/drawer/custom_drawer.dart';
import 'package:brinquedoteca_flutter/controller/guarda_volume/cadastro_guarda_volume_controller.dart';
import 'package:brinquedoteca_flutter/model/guarda_volume.dart';
import 'package:brinquedoteca_flutter/view/cadastros/cadastro_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../component/custom_appbar.dart';

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
  final _controller = CadastroGuardaVolumeController();

  @override
  Widget build(BuildContext context) {
    _controller.setGuardaVolume(guardaVolume: widget.guardaVolume);
    return Scaffold(
      appBar: CustomAppBar(
        useDrawer: false,
        showBackButton: true,
        title: "Cadastro de Guardas Volume",
        pageBackButton: CadastroView(initialIndex: 4,),
      ),
      drawer: CustomDrawer(),
      body: Observer(
        builder: (context) {
          return Form(
            key: _controller.formKeyCenCus,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                spacing: 20,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 200,
                        child: CustomTextFormField(
                          labelText: "Código",
                          controller: _controller.tecCodigo,
                          readOnly: true,
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: CustomTextFormField(
                          labelText: "Descrição",
                          controller: _controller.tecNome,
                          required: true,
                        ),
                      ),
                    ],
                  ),
                  FilledButton(
                    onPressed: () async {
                      if(_controller.formKeyCenCus.currentState!.validate() && !_controller.isLoading){
                        if(widget.guardaVolume == null) {
                          await _controller.createGuardaVolume(context);
                        } else {
                          await _controller.updateGuardaVolume(context,widget.guardaVolume!);
                        }
                      }
                    },
                    child: _controller.isLoading
                        ? CircularProgressIndicator(color: Colors.white,)
                        : Text("Salvar alterações"),
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
