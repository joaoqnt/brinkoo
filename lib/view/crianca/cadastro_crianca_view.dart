import 'package:brinquedoteca_flutter/component/crianca/form/form_cadastro_crianca_component.dart';
import 'package:brinquedoteca_flutter/component/custom_appbar.dart';
import 'package:brinquedoteca_flutter/component/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/drawer/custom_drawer.dart';
import 'package:brinquedoteca_flutter/component/foto/foto_alter_component.dart';
import 'package:brinquedoteca_flutter/component/responsavel/form/form_cadastro_responsavel_component.dart';
import 'package:brinquedoteca_flutter/controller/checkin/cadastro_checkin_controller.dart';
import 'package:brinquedoteca_flutter/controller/crianca/cadastro_crianca_controller.dart';
import 'package:brinquedoteca_flutter/model/crianca.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:brinquedoteca_flutter/view/crianca/crianca_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CadastroCriancaView extends StatefulWidget {
  final Crianca? crianca;
  final CadastroCheckinController? checkinController;
  final bool fromCheckin;

  CadastroCriancaView({
    super.key,
    this.crianca,
    this.checkinController,
    this.fromCheckin = false,
  });

  @override
  State<CadastroCriancaView> createState() => _CadastroCriancaViewState();
}

class _CadastroCriancaViewState extends State<CadastroCriancaView> {
  final _controller = CadastroCriancaController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.fromCheckin == false ? CustomAppBar(
        useDrawer: false,
        showBackButton: true,
        title: "Cadastro de Criança",
        pageBackButton: CriancaListView(),
      ) : AppBar(
        title: Text('Cadastro de Criança'),
      ),
      body: FutureBuilder(
        future: _controller.setCrianca(crianca: widget.crianca),
        builder: (context,snapshot) {
          return Container(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Observer(
                builder: (context) {
                  return Column(
                    spacing: 20,
                    children: [
                      Observer(
                        builder: (context) {
                          return FormCadastroCriancaComponent(controller: _controller);
                        },
                      ),
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
                            if(!widget.fromCheckin) {
                              Navigator.of(context).pushNamed('/crianca');
                            } else {
                              try{
                                widget.checkinController!.alterCrianca(_controller.buildCrianca(crianca: widget.crianca));
                              } catch(e){

                              }
                              Navigator.pop(context);
                            }
                          }
                        },
                        child: _controller.isLoading
                            ? CircularProgressIndicator(color: Colors.white,)
                            : Text("Salvar alterações"),
                      )
                    ],
                  );
                }
              ),
            ),
          );
        }
      ),
    );
  }
}
