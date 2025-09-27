import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/model/atividade.dart';
import 'package:brinquedoteca_flutter/model/checkin.dart';
import 'package:brinquedoteca_flutter/model/crianca.dart';
import 'package:brinquedoteca_flutter/model/forma_pagamento.dart';
import 'package:brinquedoteca_flutter/model/guarda_volume.dart';
import 'package:brinquedoteca_flutter/model/parametro.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'cadastro_checkin_controller.g.dart';

class CadastroCheckinController = _CadastroCheckinController with _$CadastroCheckinController;

abstract class _CadastroCheckinController with Store {
  final _checkinRepository = GenericRepository(
    endpoint: "checkins",
    fromJson:(p0) => Checkin.fromJson(p0),
  );
  final _criancaRepository = GenericRepository(
    endpoint: "criancas",
    fromJson:(p0) => Crianca.fromJson(p0),
  );
  final _parametroRepository = GenericRepository(
    endpoint: "parametro",
    fromJson:(p0) => Parametro.fromJson(p0),
  );
  TextEditingController tecPesquisa = TextEditingController();
  TextEditingController tecMinutosDesejados = TextEditingController(text: "60");
  @observable
  bool isLoading = false;
  @observable
  List<Crianca> criancas = ObservableList.of([]);
  @observable
  Crianca? criancaSelected;
  @observable
  Uint8List? criancaImage;
  @observable
  Uint8List? responsavelEntradaImage;
  @observable
  Uint8List? responsavelSaidaImage;
  Responsavel? responsavelEntradaSelected;
  Responsavel? responsavelSaidaSelected;
  GuardaVolume? guardaVolumeSelected;
  FormaPagamento? formaPagamentoSelected;
  List<Atividade> atividades = [];
  List<Responsavel> responsaveisPossiveisCheckout = [];
  Parametro? parametro;
  Timer? _timer;
  @observable
  double valorFinal = 0;
  @observable
  Duration tempoDecorrido = Duration.zero;

  @action
  Future<List<Crianca>> getCriancas() async{
    isLoading = true;
    criancaSelected = null;
    try{
      criancas = await _criancaRepository.getAll(filters: {"nome_crianca":tecPesquisa.text});
    } catch(e){
      print(e);
    }
    isLoading = false;
    return criancas;
  }

  setParametro() async{
    parametro = await _parametroRepository.get();
  }

  @action
  void _startTimer({required DateTime dataEntrada}) {
    _timer?.cancel(); // cancela qualquer timer anterior

    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      final agora = DateTime.now();
      tempoDecorrido = agora.difference(dataEntrada);

      final minutos = tempoDecorrido.inMinutes;
      double precoMinuto = (parametro?.valorMinutoVisita ?? 1);
      valorFinal = minutos * precoMinuto;
    });
  }


  setCheckin({Checkin? checkin}){
    criancaImage = null;
    responsavelEntradaImage = null;
    if(checkin != null){
      criancaSelected = checkin.crianca;
      responsavelEntradaSelected = checkin.responsavelEntrada;
      responsavelSaidaSelected = checkin.responsavelSaida;
      atividades = checkin.atividades??[];
      responsaveisPossiveisCheckout = checkin.responsaveisPossiveisCheckout??[];
      tecMinutosDesejados.text = checkin.minutosDesejados.toString();
      guardaVolumeSelected = checkin.guardaVolume;
      formaPagamentoSelected = checkin.formaPagamento;
      print(checkin.guardaVolume);
      print(responsaveisPossiveisCheckout.length);
    } else {
      criancaSelected = null;
      responsavelEntradaSelected = null;
      responsavelSaidaSelected = null;
      atividades = [];
      responsaveisPossiveisCheckout = [];
    }

    if(checkin?.dataEntrada != null)
      _startTimer(dataEntrada: checkin!.dataEntrada!);
  }

  @action
  setCrianca(Crianca crianca){
    criancaSelected = crianca;
    responsavelEntradaSelected = null;
  }

  @action
  takePhoto(Uint8List imageData,int type) async{
    if(type == 0){
      criancaImage =  imageData;
    } else {
      if(type == 1) {
        responsavelEntradaImage = imageData;
      } else{
        responsavelSaidaImage = imageData;
      }
    }
  }

  setResponsavel(Responsavel responsavel,bool entrada){
    if(entrada) {
      responsavelEntradaSelected = responsavel;
    } else {
      responsavelSaidaSelected = responsavel;
    }
  }

  setGuardaVolume(GuardaVolume guardaVolume){
    guardaVolumeSelected = guardaVolume;
  }

  setFormaPagamento(FormaPagamento formaPagamento){
    formaPagamentoSelected = formaPagamento;
  }

  setAtividades(List<Atividade> atividades){
    this.atividades = atividades;
  }

  setResponsaveisPossiveisCheckout(List<Responsavel> responsaveis){
    responsaveisPossiveisCheckout = responsaveis;
  }

  _buildCheckin({Checkin? checkin,DateTime? dataSaida}){
    return Checkin(
      crianca: criancaSelected,
      responsavelEntrada: responsavelEntradaSelected,
      dataEntrada: checkin?.dataEntrada??DateTime.now(),
      atividades: atividades,
      id: checkin?.id,
      urlImageCrianca: checkin?.urlImageCrianca,
      urlImageResponsavelEntrada: checkin?.urlImageResponsavelEntrada,
      responsavelSaida: responsavelSaidaSelected,
      guardaVolume: guardaVolumeSelected,
      formaPagamento: formaPagamentoSelected,
      valorTotal: checkin?.valorTotal??(valorFinal == 0 ? null : valorFinal),
      urlImageResponsavelSaida: (checkin?.urlImageResponsavelSaida) ??
          ((checkin == null || responsavelSaidaImage == null)
              ? null
              :  "https://brinkoo.com.br/images/${Singleton.instance.tenant}/checkout_responsavel/"
              "${responsavelSaidaSelected?.id}_${checkin.id}.png"),
      useUrlImageCrianca: checkin?.useUrlImageCrianca ??
          ((checkin == null || criancaImage == null)
              ? false
              : true),
      useUrlImageResponsavelSaida: checkin?.useUrlImageResponsavelSaida ??
          ((checkin == null || responsavelSaidaImage == null)
              ? false
              : true),
      useUrlImageResponsavelEntrada: checkin?.useUrlImageResponsavelEntrada ??
          ((checkin == null || responsavelEntradaImage == null)
              ? false
              : true),
      dataSaida: dataSaida,
      responsaveisPossiveisCheckout: responsaveisPossiveisCheckout,
      minutosDesejados: int.tryParse(tecMinutosDesejados.text)??60,
      empresa: Singleton.instance.usuario?.empresa
    );
  }

  @action
  createCheckin(BuildContext context) async{
    isLoading = true;
    Checkin checkin = _buildCheckin();
    print(jsonEncode(checkin.toJson()));
    try{
      Checkin checkinTmp =  await _checkinRepository.create(checkin.toJson());
      //subir images
      if(responsavelEntradaImage != null) {
        await _checkinRepository.uploadFile(
            pathField: "checkin_responsavel",
            filename: "${checkin.responsavelEntrada?.id}_${checkinTmp.id}.png",
            fileBytes: responsavelEntradaImage!
        );
      }
      if(criancaImage != null) {
        await _checkinRepository.uploadFile(
            pathField: "checkin_crianca",
            filename: "${checkin.crianca?.id}_${checkinTmp.id}.png",
            fileBytes: criancaImage!
        );
      }
      CustomSnackBar.success(context, "Criado com sucesso");
    } catch(e){
      CustomSnackBar.error(context, "Erro ao criar $e");
    }
    isLoading = false;
  }

  @action
  updateCheckin(Checkin checkinCreated,BuildContext context) async{
    isLoading = true;
    Checkin checkin = _buildCheckin(dataSaida: DateTime.now(),checkin: checkinCreated);
    print(jsonEncode(checkin.toJson()));
    try{
      await _checkinRepository.update(checkin.id,checkin.toJson());
      if(responsavelSaidaImage != null) {
        await _checkinRepository.uploadFile(
            pathField: "checkout_responsavel",
            filename: "${checkin.responsavelSaida?.id}_${checkin.id}.png",
            fileBytes: responsavelSaidaImage!
        );
      }
      CustomSnackBar.success(context, "Atualizado com sucesso");
    } catch(e){
      CustomSnackBar.error(context, "Erro ao atualizar");
    }
    isLoading = false;
  }

  bool validate(BuildContext context,{Checkin? checkin}){
    // if(criancaSelected == null){
    //   CustomSnackBar.warning(context, "Selecione uma criança");
    //   return false;
    // }
    // if(responsavelEntradaSelected == null){
    //   CustomSnackBar.warning(context, "Selecione um responsável pelo check-in");
    //   return false;
    // }
    // if(checkin == null){
    //   if(responsaveisPossiveisCheckout.isEmpty) {
    //     CustomSnackBar.warning(context, "Adicione ao menos um responsável pelo check-out");
    //     return false;
    //   }
    //   if(criancaImage == null && criancaSelected?.urlImage == null){
    //    CustomSnackBar.warning(context, "Adicione uma foto da criança");
    //    return false;
    //   }
    //   if(responsavelEntradaImage == null && responsavelEntradaSelected?.urlImage == null){
    //     CustomSnackBar.warning(context, "Adicione uma foto do responsável pelo check-in");
    //     return false;
    //   }
    // } else {
    //   if(checkin.dataSaida == null){
    //     if(responsavelSaidaSelected == null) {
    //       CustomSnackBar.warning(context, "Selecione um responsável pelo check-out");
    //       return false;
    //     }
    //     if(responsavelSaidaImage == null && responsavelSaidaSelected?.urlImage == null) {
    //      CustomSnackBar.warning(context, "Adicione uma foto do responsável pelo check-out");
    //      return false;
    //     }
    //   }
    // }
    return true;
  }
}
