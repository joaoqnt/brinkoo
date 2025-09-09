import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/atividade/dropdown_atividade.dart';
import 'package:brinquedoteca_flutter/component/crianca/card_crianca.dart';
import 'package:brinquedoteca_flutter/component/crianca/dropdown_crianca.dart';
import 'package:brinquedoteca_flutter/component/custom_appbar.dart';
import 'package:brinquedoteca_flutter/component/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/forma_pagamento/dropdown_forma_pagamento.dart';
import 'package:brinquedoteca_flutter/component/foto/foto_alter_component.dart';
import 'package:brinquedoteca_flutter/component/guarda_volume/dropdown_guarda_volume.dart';
import 'package:brinquedoteca_flutter/component/responsavel/dropdown_multiselection_responsavel.dart';
import 'package:brinquedoteca_flutter/component/responsavel/dropdown_responsavel.dart';
import 'package:brinquedoteca_flutter/component/row_search_textfield.dart';
import 'package:brinquedoteca_flutter/component/section_title.dart';
import 'package:brinquedoteca_flutter/controller/checkin/cadastro_checkin_controller.dart';
import 'package:brinquedoteca_flutter/controller/checkin/checkin_list_controller.dart';
import 'package:brinquedoteca_flutter/model/checkin.dart';
import 'package:brinquedoteca_flutter/model/crianca.dart';
import 'package:brinquedoteca_flutter/view/checkin/checkin_list_view.dart';
import 'package:brinquedoteca_flutter/view/crianca/cadastro_crianca_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CadastroCheckinView extends StatelessWidget {
  final _controller = CadastroCheckinController();
  Checkin? checkin;
  CadastroCheckinView({
    super.key,
    this.checkin,
  });

  @override
  Widget build(BuildContext context) {
    _controller.setCheckin(checkin: checkin);
    _controller.setParametro();
    return Scaffold(
      appBar: CustomAppBar(
        title: "Cadastro de Check-in",
        showBackButton: true,
        pageBackButton: CheckinListView(),
      ),
      body: Observer(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    SectionTitle(text: "Selecione uma criança"),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownCrianca(
                            onChanged: (p0) => _controller.setCrianca(p0!),
                            crianca: _controller.criancaSelected,
                            enabled: checkin == null,
                          ),
                        ),
                        SizedBox(width: 10),
                        FilledButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => CadastroCriancaView(fromCheckin: true))
                              );
                            },
                            child: Icon(Icons.add)
                        ),
                      ],
                    ),

                    // Seção de responsável (aparece apenas quando uma criança está selecionada)
                    if (_controller.criancaSelected != null) ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10,
                        children: [
                          SectionTitle(text: "Selecione um responsável pelo check-in"),
                          Row(
                            children: [
                              Expanded(
                                child: DropdownResponsavel(
                                  responsaveis: _controller.criancaSelected!.responsaveis??[],
                                  onChanged: (p0) => _controller.setResponsavel(p0!, true),
                                  responsavel: _controller.responsavelEntradaSelected,
                                  enabled: checkin == null,
                                ),
                              ),
                              SizedBox(width: 10),
                              FilledButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => CadastroCriancaView(fromCheckin: true))
                                    );
                                  },
                                  child: Icon(Icons.add)
                              ),
                            ],
                          ),
                          if (checkin == null) ...[

                          ],
                          SectionTitle(text: "Selecione quem pode ser responsável pelo check-out"),
                          DropdownMultiselectionResponsavel(
                            responsaveis: _controller.criancaSelected!.responsaveis??[],
                            checkin: false,
                            required: true,
                            enabled: checkin == null,
                            onChanged: (p0) => _controller.setResponsaveisPossiveisCheckout(p0!),
                            responsaveisSelected: _controller.responsaveisPossiveisCheckout,
                          ),
                          SectionTitle(text: "Selecione um Guarda Volume"),
                          DropdownGuardaVolume(
                            guardaVolume: _controller.guardaVolumeSelected,
                            required: false,
                            onChanged: (p0) => _controller.setGuardaVolume(p0!),
                          ),
                          if (checkin != null) ...[
                            const Text(
                              "Selecione um responsável pelo check-out",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            DropdownResponsavel(
                              responsaveis: _controller.responsaveisPossiveisCheckout,
                              onChanged: (p0) => _controller.setResponsavel(p0!, false),
                              responsavel: _controller.responsavelSaidaSelected,
                              enabled: checkin?.dataSaida == null,
                              checkin: false,
                            ),
                            SizedBox(height: 10),
                            const Text(
                              "Selecione uma Forma de Pagamento",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            DropdownFormaPagamento(
                              formaPagamento: _controller.formaPagamentoSelected,
                              onChanged: (p0) => _controller.setFormaPagamento(p0!),
                              enabled: checkin?.dataSaida == null
                            ),
                            Row(
                              children: [
                                Text('Valor Total: ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  )
                                ),
                                Text("${UtilBrasilFields.obterReal((checkin?.valorTotal??_controller.valorFinal))}")
                              ],
                            )
                          ],
                          Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            alignment: WrapAlignment.center,
                            children: [
                              Column(
                                spacing: 20,
                                children: [
                                  FotoAlterComponent(
                                    onAdd: (p0) => _controller.takePhoto(p0,0),
                                      capturedImageBytes: _controller.criancaImage,
                                      imageUrl: checkin?.urlImageCrianca,
                                  ),
                                  Text("Foto de Check-in da criança")
                                ],
                              ),
                              Column(
                                spacing: 20,
                                children: [
                                  FotoAlterComponent(
                                      onAdd: (p0) => _controller.takePhoto(p0,1),
                                      onEdit: (p0) => _controller.takePhoto(p0,1),
                                      capturedImageBytes: _controller.responsavelEntradaImage,
                                      imageUrl: checkin?.urlImageResponsavelEntrada
                                  ),
                                  Text("Foto de Check-in do responsável")
                                ],
                              ),
                              if(checkin != null)
                                Column(
                                  spacing: 20,
                                  children: [
                                    FotoAlterComponent(
                                        onAdd: (p0) => _controller.takePhoto(p0,2),
                                        onEdit: (p0) => _controller.takePhoto(p0,2),
                                        capturedImageBytes: _controller.responsavelSaidaImage,
                                        imageUrl: checkin?.urlImageResponsavelSaida
                                    ),
                                    Text("Foto de Check-out do responsável")
                                  ],
                                ),
                              SizedBox(
                                width: 200,
                                child: CustomTextFormField(
                                  controller: _controller.tecMinutosDesejados,
                                  labelText: "Minutos desejados",
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  suffixIcon: Tooltip(
                                    message: "Tempo em que deseja manter a criança no estabelecimento.\n"
                                        "Será utilizado para colorir o tempo de permanência "
                                        "e alertar o responsável",
                                    child: Icon(
                                        Icons.info
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: FilledButton(
                                onPressed: () async{
                                  if(!_controller.isLoading && _controller.validate(context,checkin: checkin)) {
                                    if(checkin == null)
                                      await _controller.createCheckin(context);
                                    else
                                      await _controller.updateCheckin(checkin!,context);
                                  }
                                },
                                child: _controller.isLoading
                                    ? CircularProgressIndicator(color: Colors.white,)
                                    : Text("Realizar ${checkin == null ? "check-in" : "check-out"}")
                            ),
                          )
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}