import 'package:brinquedoteca_flutter/component/crianca/form_cadastro_crianca_component.dart';
import 'package:brinquedoteca_flutter/component/custom_appbar.dart';
import 'package:brinquedoteca_flutter/component/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/drawer/custom_drawer.dart';
import 'package:brinquedoteca_flutter/component/foto/foto_alter_component.dart';
import 'package:brinquedoteca_flutter/component/responsavel/form_cadastro_responsavel_component.dart';
import 'package:brinquedoteca_flutter/controller/crianca/cadastro_crianca_controller.dart';
import 'package:brinquedoteca_flutter/model/crianca.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:brinquedoteca_flutter/view/crianca/crianca_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CadastroCriancaView extends StatefulWidget {
  final Crianca? crianca;
  final bool fromCheckin;

  CadastroCriancaView({
    super.key,
    this.crianca,
    this.fromCheckin = false,
  });

  @override
  State<CadastroCriancaView> createState() => _CadastroCriancaViewState();
}

class _CadastroCriancaViewState extends State<CadastroCriancaView> {
  final _controller = CadastroCriancaController();

  @override
  Widget build(BuildContext context) {
    _controller.setCrianca(crianca: widget.crianca);
    return Scaffold(
      appBar: widget.fromCheckin == false ? CustomAppBar(
        useDrawer: false,
        showBackButton: true,
        title: "Cadastro de Criança",
        pageBackButton: CriancaListView(),
      ) : AppBar(
        title: Text('Cadastro de Criança'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            spacing: 20,
            children: [
              Observer(
                builder: (context) {
                  bool isMobile = Responsive.isMobile(context);
                  return isMobile ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: FotoAlterComponent(
                          onAdd: (p0) => _controller.addFoto(p0),
                          capturedImageBytes: _controller.criancaImage,
                          imageUrl: _controller.criancaSelected?.urlImage,
                        ),
                      ),
                      SizedBox(height: 20),
                      FormCadastroCriancaComponent(controller: _controller),
                    ],
                  ) : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FotoAlterComponent(
                        onAdd: (p0) => _controller.addFoto(p0),
                        capturedImageBytes: _controller.criancaImage,
                        imageUrl: _controller.criancaSelected?.urlImage,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: FormCadastroCriancaComponent(controller: _controller),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 10),
              Row(
                spacing: 10,
                children: [
                  Text("Responsáveis",
                      style: TextStyle(fontSize: 20)
                  ),
                  IconButton.filledTonal(
                      tooltip: "Adicionar responsável",
                      onPressed: () {
                        _controller.addResponsavel();
                      },
                      icon: Icon(Icons.add)
                  )
                ],
              ),
              for(int i = 0; i < _controller.responsaveis.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: FormCadastroResponsavelComponent(
                    controller: _controller.responsaveisController[i],
                    responsavel: _controller.responsaveis[i],
                    criancaController: _controller,
                  ),
                ),
              FilledButton(
                onPressed: () async {
                  // Valida o form principal
                  if(_controller.validate(context) && !_controller.isLoading){
                    if(widget.crianca == null) {
                      await _controller.createCrianca(context);
                    } else {
                      await _controller.updateCrianca(context,widget.crianca!);
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
      ),
    );
  }
}
