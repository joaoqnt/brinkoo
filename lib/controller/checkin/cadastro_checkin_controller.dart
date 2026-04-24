import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/model/atividade.dart';
import 'package:brinquedoteca_flutter/model/checkin.dart';
import 'package:brinquedoteca_flutter/model/convenio/convenio.dart';
import 'package:brinquedoteca_flutter/model/convenio/convenio_dia.dart';
import 'package:brinquedoteca_flutter/model/crianca.dart';
import 'package:brinquedoteca_flutter/model/forma_pagamento.dart';
import 'package:brinquedoteca_flutter/model/guarda_volume.dart';
import 'package:brinquedoteca_flutter/model/parametro.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/model/usuario.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'cadastro_checkin_controller.g.dart';

class CadastroCheckinController = _CadastroCheckinController with _$CadastroCheckinController;

abstract class _CadastroCheckinController with Store {
  final formKey = GlobalKey<FormState>();
  final formKeyFormaPgto = GlobalKey<FormState>();
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
  final _atividadeRepository = GenericRepository(
    endpoint: "atividades",
    fromJson:(p0) => Atividade.fromJson(p0),
  );
  TextEditingController tecPesquisa = TextEditingController();
  TextEditingController tecValorBruto = TextEditingController();
  TextEditingController tecValorLiquido = TextEditingController();
  TextEditingController tecDescontoConvenio = TextEditingController();
  TextEditingController tecDesconto = TextEditingController();
  TextEditingController tecValorForma = TextEditingController();
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
  @observable
  Responsavel? responsavelEntradaSelected;
  @observable
  Responsavel? responsavelSaidaSelected;
  @observable
  Convenio? convenioSelected;
  GuardaVolume? guardaVolumeSelected;
  FormaPagamento? formaPagamentoSelected;
  @observable
  ObservableList<Atividade> atividades = ObservableList.of([]);
  @observable
  ObservableList<Atividade> atividadesSelected = ObservableList.of([]);
  @observable
  ObservableList<Responsavel> responsaveisPossiveisCheckout = ObservableList.of([]);
  Parametro? parametro;
  Timer? _timer;
  @observable
  double valorFinal = 0;
  @observable
  double valorRestante = 0.0;
  @observable
  Duration tempoDecorrido = Duration.zero;
  @observable
  Usuario? usuarioEntrada;
  @observable
  Usuario? usuarioSaida;
  Checkin? checkinSelected;
  bool isFromHome = false;
  bool isFromCheckinList = false;
  @observable
  int indexPage = 0;
  @observable
  List<FormaPagamento> formas = ObservableList.of([]);
  late TabController tabController;

  final List<Tab> tabs = const [
    Tab(text: 'Entrada'),
    Tab(text: 'Saida'),
  ];

  initTabController(TickerProvider vsync){
    tabController = TabController(length: tabs.length, vsync: vsync,initialIndex: indexPage);
  }

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

  _setValorBruto(){
    if(checkinSelected == null) return;
    final agora = DateTime.now();
    tempoDecorrido = agora.difference(checkinSelected!.dataEntrada!);

    final minutos = tempoDecorrido.inMinutes;
    double precoMinuto = (parametro?.valorMinutoVisita ?? 1);

    if (checkinSelected?.valorTotal == null) {
      valorFinal = minutos * precoMinuto;
    } else {
      valorFinal = checkinSelected!.valorBruto!;
    }

    tecValorBruto.text = UtilBrasilFields.obterReal(valorFinal);
  }

  _setValorDesconto(){
    final desconto = getValorDescontoConvenio() ?? 0;

    tecDescontoConvenio.text =
        UtilBrasilFields.obterReal(desconto);
  }

  @action
  setCheckin({Checkin? checkin}){
    criancaImage = null;
    responsavelEntradaImage = null;
    formas.clear();
    checkinSelected = checkin;
    if(checkin != null){
      criancaSelected = checkin.crianca;
      responsavelEntradaSelected = checkin.responsavelEntrada;
      responsavelSaidaSelected = checkin.responsavelSaida;
      try{
        setAtividades(checkin.crianca!,checkin: checkin);
      } catch(e){

      }
      setResponsaveisPossiveisCheckout(checkin.responsaveisPossiveisCheckout??[]);
      tecMinutosDesejados.text = checkin.minutosDesejados.toString();
      guardaVolumeSelected = checkin.guardaVolume;

      try{
        tecDesconto.text = UtilBrasilFields.obterReal(checkin.desconto!);
      } catch(e){

      }

      try{
        tecDescontoConvenio.text = UtilBrasilFields.obterReal(checkin.descontoConvenio!);
      } catch(e){

      }
      // formaPagamentoSelected = checkin.formaPagamento;

      print(checkin.guardaVolume);
      print(responsaveisPossiveisCheckout.length);

      try{
        setUsuarioEntrada(checkin.usuarioEntrada!);
      } catch(e){
        setUsuarioEntrada(Singleton().usuario!);
      }

      try{
        setUsuarioSaida(checkin.usuarioSaida!);
      } catch(e){
        setUsuarioSaida(Singleton().usuario!);
      }

      checkin.formaPagamento?.forEach((element) {
        formas.add(element);
      });

      setConvenio(convenio: checkin.convenio);

      if(checkin.guardaVolume != null) {
        setGuardaVolume(checkin.guardaVolume!);
      }

    } else {
      criancaSelected = null;
      responsavelEntradaSelected = null;
      responsavelSaidaSelected = null;
      setConvenio(convenio: null);
      atividades.clear();
      responsaveisPossiveisCheckout.clear();
      checkinSelected = null;
      setUsuarioEntrada(Singleton().usuario!);
      setUsuarioSaida(Singleton().usuario!);
      tecValorForma.clear();
      guardaVolumeSelected = null;
    }

    if(checkin?.dataEntrada != null) {
      _setValorBruto();
      _setValorDesconto();
      setValorLiquido();
      recalcularValorRestante();
    }
  }

  @action
  setCrianca(Crianca crianca){
    criancaSelected = crianca;
    responsavelEntradaSelected = null;
    setAtividades(crianca);
  }

  @action
  alterCrianca(Crianca crianca){
    criancaSelected = crianca;
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
    try{
      tecValorForma.text = UtilBrasilFields.obterReal(getValorDefaultFormaPgto()!);
    } catch(e){
      tecValorForma.text = '';
    }

  }

  @action
  addFormaPagamento(){
    try{
      formaPagamentoSelected?.valor = UtilBrasilFields.converterMoedaParaDouble(tecValorForma.text);
      formas.add(formaPagamentoSelected!);
      recalcularValorRestante();
    } catch(e){

    }
  }

  @action
  setAtividades(Crianca crianca,{Checkin? checkin}) async{
    List<Atividade> atividades = await _atividadeRepository.getAll();
    this.atividades = ObservableList.of(atividades);
    if(checkin != null){
      checkin.atividades?.forEach((atividade) {
        toggleAtividade(atividade);
      });
    } else {
      crianca.atividades?.forEach((atividade) {
        toggleAtividade(atividade);
      });
    }
  }

  @action
  setResponsaveisPossiveisCheckout(List<Responsavel> responsaveis){
    responsaveisPossiveisCheckout = ObservableList.of(responsaveis);
  }

  _buildCheckin({Checkin? checkin,DateTime? dataSaida}){
    return Checkin(
      crianca: criancaSelected,
      responsavelEntrada: responsavelEntradaSelected,
      dataEntrada: checkin?.dataEntrada??DateTime.now(),
      atividades: atividadesSelected,
      usuarioEntrada: checkin?.usuarioEntrada??Singleton.instance.usuario,
      usuarioSaida: dataSaida != null ? checkin?.usuarioSaida??Singleton.instance.usuario : checkin?.usuarioSaida,
      id: checkin?.id,
      convenio: convenioSelected,
      urlImageCrianca: checkin?.urlImageCrianca,
      urlImageResponsavelEntrada: checkin?.urlImageResponsavelEntrada,
      responsavelSaida: responsavelSaidaSelected,
      guardaVolume: guardaVolumeSelected,
      formaPagamento: formas,
      valorTotal: checkinSelected == null ? null : checkinSelected?.dataSaida == null
          ? UtilBrasilFields.converterMoedaParaDouble(tecValorLiquido.text)
          : checkinSelected?.valorTotal,
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
      dataSaida: checkin?.dataSaida??dataSaida,
      responsaveisPossiveisCheckout: responsaveisPossiveisCheckout,
      minutosDesejados: int.tryParse(tecMinutosDesejados.text)??60,
      empresa: Singleton.instance.usuario?.empresa,
      valorBruto: tecValorBruto.text.isEmpty ? 0 : UtilBrasilFields.converterMoedaParaDouble(tecValorBruto.text),
      desconto: tecDesconto.text.isEmpty ? 0 : UtilBrasilFields.converterMoedaParaDouble(tecDesconto.text),
      descontoConvenio: tecDescontoConvenio.text.isEmpty ? 0 :UtilBrasilFields.converterMoedaParaDouble(tecDescontoConvenio.text),
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
  updateCheckin(BuildContext context) async{
    isLoading = true;
    Checkin checkin = _buildCheckin(dataSaida: DateTime.now(),checkin: checkinSelected);
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
    if(!formKey.currentState!.validate()) {
      return false;
    }
    if(criancaSelected == null){
      CustomSnackBar.warning(context, "Selecione uma criança");
      return false;
    }
    if(responsavelEntradaSelected == null){
      CustomSnackBar.warning(context, "Selecione um responsável pelo check-in");
      return false;
    }
    if(checkin == null){
      if(responsaveisPossiveisCheckout.isEmpty) {
        CustomSnackBar.warning(context, "Adicione ao menos um responsável pelo check-out");
        return false;
      }
      if(criancaImage == null && criancaSelected?.urlImage == null){
       CustomSnackBar.warning(context, "Adicione uma foto da criança");
       return false;
      }
      if(responsavelEntradaImage == null && responsavelEntradaSelected?.urlImage == null){
        CustomSnackBar.warning(context, "Adicione uma foto do responsável pelo check-in");
        return false;
      }
    } else {
      if(checkin.dataSaida == null){
        if(responsavelSaidaSelected == null) {
          CustomSnackBar.warning(context, "Selecione um responsável pelo check-out");
          return false;
        }
        if(responsavelSaidaImage == null && responsavelSaidaSelected?.urlImage == null) {
         CustomSnackBar.warning(context, "Adicione uma foto do responsável pelo check-out");
         return false;
        }
        double valorLiquido = 0;
        try {
          valorLiquido = UtilBrasilFields.converterMoedaParaDouble(tecValorLiquido.text);
        } catch (e) {
          valorLiquido = 0;
        }

        double totalFormas = 0;

        for (var forma in formas) {
          try {
            totalFormas += forma.valor ?? 0;
          } catch (e) {}
        }

// 🔥 Validação
        if (totalFormas < valorLiquido) {
          CustomSnackBar.warning(
              context,
              "O total das formas de pagamento é menor que o valor líquido"
          );
          return false;
        }

        if (totalFormas > valorLiquido) {
          CustomSnackBar.warning(
              context,
              "O total das formas de pagamento é maior que o valor líquido"
          );
          return false;
        }
      }
    }
    return true;
  }

  @action
  void toggleAtividade(Atividade atividade) {
    if (atividadesSelected.any((a) => a.id == atividade.id)) {
      atividadesSelected.remove(atividadesSelected.where((element) => element.id == atividade.id).first);
    } else {
      atividadesSelected.add(atividade);
    }
  }

  @action
  setUsuarioEntrada(Usuario usuario) => usuarioEntrada = usuario;

  @action
  setUsuarioSaida(Usuario usuario) => usuarioSaida = usuario;

  @action
  setConvenio({Convenio? convenio}) {
    convenioSelected = convenio;
    // _setValorBruto();
    _setValorDesconto();
    setValorLiquido();
    recalcularValorRestante();
  }

  setIsFromHome(bool value) => isFromHome = value;

  setIsFromCheckinList(bool value) => isFromCheckinList = value;

  @action
  setIndexPage(int value) {
    indexPage = value;
    tabController.animateTo(value);
    //
  }

  double? getValorDescontoConvenio() {
    if (convenioSelected == null || checkinSelected == null) return null;

    if(checkinSelected?.dataSaida != null) return checkinSelected?.descontoConvenio;

    final dias = convenioSelected!.convenioDias;
    if (dias == null || dias.isEmpty) return null;

    final diaSemana = checkinSelected!.dataEntrada!.weekday;

    ConvenioDia diaValido = dias.firstWhere(
          (e) =>
      e.dia == diaSemana &&
          ((e.percConvenio ?? 0) != 0 || (e.percEmpresa ?? 0) != 0),
      orElse: () => dias.first,
    );

    final percentual =
        (diaValido.percConvenio ?? 0) + (diaValido.percEmpresa ?? 0);

    final valorDesconto = valorFinal * (percentual / 100);

    return valorDesconto;
  }

  double getValorComDesconto() {
    final valorBase =
    (checkinSelected?.valorTotal ?? valorFinal);

    if (convenioSelected == null || checkinSelected == null) {
      return valorBase;
    }

    final dias = convenioSelected!.convenioDias;
    if (dias == null || dias.isEmpty) {
      return valorBase;
    }

    final diaSemana = checkinSelected!.dataEntrada!.weekday;

    ConvenioDia diaValido = dias.firstWhere(
          (e) =>
      e.dia == diaSemana &&
          ((e.percConvenio ?? 0) != 0 || (e.percEmpresa ?? 0) != 0),
      orElse: () => dias.first,
    );

    final percentual =
        (diaValido.percConvenio ?? 0) + (diaValido.percEmpresa ?? 0);

    final valorDesconto = valorBase * (percentual / 100);

    final valorLiquido = valorBase - valorDesconto;

    return valorLiquido;
  }

  void setValorLiquido() {
    double parseValor(String? value) {
      if (value == null || value.isEmpty) return 0;

      return UtilBrasilFields.converterMoedaParaDouble(value);
    }

    final valorBruto = parseValor(tecValorBruto.text);
    final descontoConvenio = parseValor(tecDescontoConvenio.text);
    final descontoManual = parseValor(tecDesconto.text);

    final totalDescontos = descontoConvenio + descontoManual;

    final valorLiquido = valorBruto - totalDescontos;

    tecValorLiquido.text =
        UtilBrasilFields.obterReal(valorLiquido < 0 ? 0 : valorLiquido);
  }

  double? getValorDefaultFormaPgto(){
    if(formas.isEmpty){
      return UtilBrasilFields.converterMoedaParaDouble(tecValorLiquido.text);
    } else {
      return null;
    }
  }

  void recalcularValorRestante() {
    double totalPago = formas.fold(0.0, (sum, f) => sum + (f.valor ?? 0));
    double valorLiquido =
    UtilBrasilFields.converterMoedaParaDouble(tecValorLiquido.text);

    valorRestante = valorLiquido - totalPago;

    if (valorRestante < 0) valorRestante = 0;
  }
}
