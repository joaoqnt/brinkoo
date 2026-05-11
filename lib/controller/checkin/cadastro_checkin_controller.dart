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
import 'package:brinquedoteca_flutter/services/checkin/cadastro/checkin_persistence_service.dart';
import 'package:brinquedoteca_flutter/services/checkin/cadastro/checkin_validation_service.dart';
import 'package:brinquedoteca_flutter/services/checkin/cadastro/checkin_value_service.dart';
import 'package:brinquedoteca_flutter/services/convenio/convenio_service.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'cadastro_checkin_controller.g.dart';

class CadastroCheckinController = _CadastroCheckinController with _$CadastroCheckinController;

abstract class _CadastroCheckinController with Store {
  final formKey = GlobalKey<FormState>();
  final formKeyDialog = GlobalKey<FormState>();
  final formKeyFormaPgto = GlobalKey<FormState>();
  late final CheckinPersistenceService _checkinPersistenceService;
  final _validationService = CheckinValidationService();
  final _convenioService = ConvenioService();
  final _valueService = CheckinValueService();
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
  @observable
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
  List<Checkin>? checkinsSelected;
  bool isFromHome = false;
  bool isFromCheckinList = false;
  @observable
  int indexPage = 0;
  @observable
  List<FormaPagamento> formas = ObservableList.of([]);
  Map<Checkin, Map<String, double>> valoresPorCheckin = {};
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

  _setValorBruto({bool isList = false}) {
    if (!isList) {
      if (checkinSelected == null) return;

      tempoDecorrido = DateTime.now().difference(
        checkinSelected!.dataEntrada!,
      );

      valorFinal = _valueService.getValorBrutoCheckin(
        checkin: checkinSelected!,
        parametro: parametro,
      );
    } else {
      if ((checkinsSelected ?? []).isEmpty) return;

      valorFinal = _valueService.getValorBrutoTotalCheckins(
        checkins: checkinsSelected!,
        parametro: parametro,
        valoresPorCheckin: valoresPorCheckin,
      );
    }

    tecValorBruto.text = _valueService.formatCurrency(valorFinal);
  }

  _reset({Checkin? checkin}){
    criancaImage = null;
    responsavelEntradaImage = null;
    formas.clear();
    checkinSelected = checkin;
    atividadesSelected.clear();
    _clearFormaTec();
    valoresPorCheckin.clear();
  }

  setCheckins({List<Checkin>? checkins,List<Responsavel>? responsaveis}){
    _reset(checkin: null);
    checkinsSelected = checkins;
    try{
      setResponsaveisPossiveisCheckout(responsaveis!);
      _setValorBruto(isList: true);
      // _setValorDesconto(isList: true);
      setValorLiquido();
      _recalcularValorRestante();
    } catch(e){

    }
  }

  @action
  setCheckin({Checkin? checkin}){
    _reset(checkin: checkin);
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
      setIndexPage(0);
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
      // _setValorDesconto();
      setValorLiquido();
      _recalcularValorRestante();
      setIndexPage(1);
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

  @action
  setFormaPagamento(FormaPagamento? formaPagamento){
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
      _recalcularValorRestante();
      _clearFormaTec();
    } catch(e){

    }
  }

  @action
  removeFormaPagamento(FormaPagamento formapagamento){
    try{
      formas.remove(formapagamento);
      _recalcularValorRestante();
    } catch(e){

    }
  }

  _clearFormaTec(){
    setFormaPagamento(null);
    tecValorForma.clear();
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
      valorTotal: checkinSelected == null
          ? null
          : checkinSelected?.dataSaida == null
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

  bool validate(BuildContext context,{Checkin? checkin, bool useFormKeyDialog = false}){
    return _validationService.validate(
        context: context,
        formKey: formKey,
        formKeyDialog: formKeyDialog,
        useFormKeyDialog: useFormKeyDialog,
        checkin: checkin,
        criancaSelected: criancaSelected,
        responsavelEntradaSelected: responsavelEntradaSelected,
        responsavelSaidaSelected: responsavelSaidaSelected,
        responsaveisPossiveisCheckout: responsaveisPossiveisCheckout,
        formas: formas,
        valorLiquidoText: tecValorLiquido.text,
        hasCriancaImage: checkin == null && criancaImage == null && criancaSelected?.urlImage == null,
        hasResponsavelEntradaImage: checkin == null && responsavelEntradaImage == null && responsavelEntradaSelected?.urlImage == null,
        hasResponsavelSaidaImage: checkin == null && responsavelSaidaImage == null && responsavelSaidaSelected?.urlImage == null,
    );
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
    _calcularDescontoConvenio();

    // _setValorBruto();
    // _setValorDesconto();
    // setValorLiquido();
    // _recalcularValorRestante();
  }

  double _calcularDescontoConvenio() {
    if (convenioSelected == null) return 0;

    if ((checkinsSelected ?? []).isNotEmpty) {
      return _convenioService.calcularDescontoConvenioTotalCheckins(
        checkins: checkinsSelected!,
        convenio: convenioSelected!,
        getValorBase: (_) => _valueService.parseCurrency(tecValorBruto.text),
        valoresPorCheckin: valoresPorCheckin,
      );
    }

    if (checkinSelected == null) return 0;

    return _convenioService.calcularDescontoConvenioCheckin(
      checkin: checkinSelected!,
      valorBase: _valueService.parseCurrency(tecValorBruto.text),
      convenio: convenioSelected!,
    ) ??
        0;
  }

  setIsFromHome(bool value) => isFromHome = value;

  setIsFromCheckinList(bool value) => isFromCheckinList = value;

  @action
  setIndexPage(int value) {
    indexPage = value;
    tabController.animateTo(value);
    //
  }

  double _getValorBrutoCheckin(Checkin checkin) {
    return _valueService.getValorBrutoCheckin(checkin: checkin, parametro: parametro);
  }


  void setValorLiquido() {
    double value = _valueService.getLiquidValue(
        grossValue: _valueService.parseCurrency(tecValorBruto.text),
        convenioDiscount: _valueService.parseCurrency(tecDescontoConvenio.text),
        manualDiscount: _valueService.parseCurrency(tecDesconto.text)
    );

    tecValorLiquido.text = _valueService.formatCurrency(value);
  }

  double? getValorDefaultFormaPgto(){
    return _valueService.getDefaultPaymentValue(
        formas: formas,
        valorLiquidoText: tecValorLiquido.text,
        valorRestante: valorRestante
    );
  }

  void _recalcularValorRestante() {
    valorRestante = _valueService.getRemainingValue(
        formas: formas,
        valorLiquidoText: tecValorLiquido.text,
    );
  }
}
