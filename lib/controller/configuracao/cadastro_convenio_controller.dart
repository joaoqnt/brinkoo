import 'dart:convert';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/model/centro_custo.dart';
import 'package:brinquedoteca_flutter/model/convenio/convenio.dart';
import 'package:brinquedoteca_flutter/model/convenio/convenio_dia.dart';
import 'package:brinquedoteca_flutter/model/empresa.dart';
import 'package:brinquedoteca_flutter/model/natureza.dart';
import 'package:brinquedoteca_flutter/model/parceiro.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:brinquedoteca_flutter/utils/date_helper_util.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'cadastro_convenio_controller.g.dart';

class CadastroConvenioController = _CadastroConvenioController with _$CadastroConvenioController;

abstract class _CadastroConvenioController with Store {
  TextEditingController tecDescricao = TextEditingController();
  TextEditingController tecCodigo = TextEditingController();
  TextEditingController tecDataExpiracao = TextEditingController();
  TextEditingController tecDiaVencimento = TextEditingController();
  TextEditingController tecMaxVisita = TextEditingController();
  TextEditingController tecMinDiaVencimento = TextEditingController();
  TextEditingController tecObservacao = TextEditingController();
  TextEditingController tecPercConvenio = TextEditingController();
  TextEditingController tecPercEmpresa = TextEditingController();
  TextEditingController tecPercTotal = TextEditingController();
  TextEditingController tecValorConvenio = TextEditingController();
  TextEditingController tecValorEmpresa = TextEditingController();
  TextEditingController tecQtdVisita = TextEditingController();
  TextEditingController tecPesquisa = TextEditingController();
  final formKeyConvenio = GlobalKey<FormState>();
  final _convenioRepository = GenericRepository(
      endpoint: "convenios",
      fromJson:(p0) => Convenio.fromJson(p0),
  );
  @observable
  Parceiro? parceiroSelected;
  @observable
  Empresa? empresaSelected;
  @observable
  Natureza? naturezaSelected;
  @observable
  CentroCusto? centroCustoSelected;
  Convenio? convenioSelected;
  @observable
  bool isLoading = false;
  @observable
  bool isAltering = false;
  @observable
  bool isAtivo = true;
  @observable
  List<Convenio> convenios = ObservableList.of([]);
  List<String> convenioDayName = [
    "Geral",
    "Segunda",
    "Terça",
    "Quarta",
    "Quinta",
    "Sexta",
    "Sábado",
    "Domingo",
  ];
  @observable
  String daySelected = "Geral";
  @observable
  int indexPage = 0;
  late TabController tabController;
  final List<Tab> tabs = const [
    Tab(text: 'Novo cadastro'),
    Tab(text: 'Convênios já cadastrados'),
  ];
  List<ConvenioDia> diasConvenio = [];

  initTabController(TickerProvider vsync){
    tabController = TabController(length: tabs.length, vsync: vsync,initialIndex: indexPage);
  }

  @action
  Future<List<Convenio>> getConvenios() async{
    try{
      convenios = await _convenioRepository.getAll();
    } catch(e){
      print(e);
    }
    return convenios;
  }

  @action
  Future createConvenio(BuildContext context) async{
    isAltering = true;
    try{
      print(jsonEncode(_buildConvenio().toJson()));
      await _convenioRepository.create(_buildConvenio().toJson());
      CustomSnackBar.success(context, "Cadastrado com sucesso");
    } catch(e){
      print(e);
      CustomSnackBar.error(context, "Erro ao cadastrar");
    }
    await getConvenios();
    isAltering = false;
  }

  @action
  Future updateConvenio(BuildContext context) async{
    isAltering = true;
    try{
      print(jsonEncode(_buildConvenio(convenio:convenioSelected).toJson()));
      await _convenioRepository.update(convenioSelected?.id,_buildConvenio(convenio:convenioSelected).toJson());
      CustomSnackBar.success(context, "Atualizado com sucesso");
    } catch(e){
      print(e);
      CustomSnackBar.error(context, "Erro ao atualizar");
    }
    await getConvenios();
    isAltering = false;
  }

  Convenio _buildConvenio({Convenio? convenio}){
    Convenio convenioTmp = Convenio(
      id: convenio?.id,
      descricao: tecDescricao.text,
      parceiro: parceiroSelected,
      empresa: empresaSelected,
      natureza: naturezaSelected,
      centroCusto: centroCustoSelected,
      ativo: isAtivo,
      dataExpiracao: DateHelperUtil.parseBrDateToDateTime(tecDataExpiracao.text),
      diaVencimento: int.tryParse(tecDiaVencimento.text),
      maxVisita: int.tryParse(tecMaxVisita.text),
      minDiaVencimento: int.tryParse(tecMinDiaVencimento.text),
      observacao: tecObservacao.text,
      percConvenio: diasConvenio.firstOrNull?.percConvenio,//UtilBrasilFields.converterMoedaParaDouble(tecPercConvenio.text),
      percEmpresa: diasConvenio.firstOrNull?.percEmpresa,//UtilBrasilFields.converterMoedaParaDouble(tecPercConvenio.text),
      // valorConvenio: UtilBrasilFields.converterMoedaParaDouble(tecValorConvenio.text),
      // valorEmpresa: UtilBrasilFields.converterMoedaParaDouble(tecValorEmpresa.text),
      qtdVisita: int.tryParse(tecQtdVisita.text),
      convenioDias: diasConvenio,
    );
    return convenioTmp;
  }

  @action
  void setConvenio({Convenio? convenio}) {
    convenioSelected = convenio;
    _addDiasConvenio();
    if (convenio != null) {
      tecCodigo.text = convenio.id?.toString() ?? '';
      tecDescricao.text = convenio.descricao ?? '';
      tecDataExpiracao.text = convenio.dataExpiracao != null
          ? DateHelperUtil.formatDate(convenio.dataExpiracao!)
          : '';
      tecDiaVencimento.text = convenio.diaVencimento?.toString() ?? '';
      tecMaxVisita.text = convenio.maxVisita?.toString() ?? '';
      tecMinDiaVencimento.text = convenio.minDiaVencimento?.toString() ?? '';
      tecObservacao.text = convenio.observacao ?? '';
      tecPercConvenio.text = convenio.percConvenio != null
          ? UtilBrasilFields.obterReal(convenio.percConvenio!,moeda: false)
          : '';
      tecPercEmpresa.text = convenio.percEmpresa != null
          ? UtilBrasilFields.obterReal(convenio.percEmpresa!,moeda: false)
          : '';
      tecValorConvenio.text = convenio.valorConvenio != null
          ? UtilBrasilFields.obterReal(convenio.valorConvenio!)
          : '';
      tecValorEmpresa.text = convenio.valorEmpresa != null
          ? UtilBrasilFields.obterReal(convenio.valorEmpresa!)
          : '';
      tecQtdVisita.text = convenio.qtdVisita?.toString() ?? '';
      setEmpresa(empresa: convenio.empresa);
      setCentroCusto(centrocusto: convenio.centroCusto);
      setNatureza(natureza: convenio.natureza);
      setParceiro(parceiro: convenio.parceiro);
      setAtivo(convenio.ativo ?? true);
      _setPercTotal();
    } else {
      clearAll();
    }
    setIndexPage(0);
  }

  void clearAll() {
    convenioSelected = null;
    tecCodigo.clear();
    tecDescricao.clear();
    tecDataExpiracao.clear();
    tecDiaVencimento.clear();
    tecMaxVisita.clear();
    tecMinDiaVencimento.clear();
    tecObservacao.clear();
    tecPercConvenio.clear();
    tecPercEmpresa.clear();
    tecPercTotal.clear();
    tecValorConvenio.clear();
    tecValorEmpresa.clear();
    tecQtdVisita.clear();

    setParceiro(parceiro: null);
    setEmpresa(empresa: null);
    setNatureza(natureza: null);
    setCentroCusto(centrocusto: null);

    diasConvenio.clear();


    setAtivo(true);
  }

  setEmpresa({Empresa? empresa}){
    empresaSelected = empresa;
  }

  setParceiro({Parceiro? parceiro}){
    parceiroSelected = parceiro;
  }

  setNatureza({Natureza? natureza}){
    naturezaSelected = natureza;
  }

  setCentroCusto({CentroCusto? centrocusto}){
    centroCustoSelected = centrocusto;
  }

  @action
  setAtivo(bool value) => isAtivo = value;

  @action
  setDay(String value) {
    daySelected = value;
    _setDataDayConvenio();
    _setPercTotal();
  }

  @action
  setIndexPage(int value) {
    indexPage = value;
    tabController.animateTo(value);
    //
  }

  void _setPercTotal() {
    double percConvenio = 0;
    double percEmpresa = 0;

    if (tecPercConvenio.text.isNotEmpty) {
      percConvenio =
          UtilBrasilFields.converterMoedaParaDouble(tecPercConvenio.text);
    }

    if (tecPercEmpresa.text.isNotEmpty) {
      percEmpresa =
          UtilBrasilFields.converterMoedaParaDouble(tecPercEmpresa.text);
    }

    double total = percConvenio + percEmpresa;

    tecPercTotal.text =
        UtilBrasilFields.obterReal(total, moeda: false);
  }

  _addDiasConvenio(){
    diasConvenio.clear();
    for(int i = 0; i < convenioDayName.length; i++){
      diasConvenio.add(
        ConvenioDia(
          convenio: convenioSelected?.id,
          dia: i,
          percConvenio: convenioSelected?.convenioDias?.where((element) => element.dia == i,).firstOrNull?.percConvenio,
          percEmpresa: convenioSelected?.convenioDias?.where((element) => element.dia == i,).firstOrNull?.percEmpresa,
        )
      );
    }
  }

  void _setDataDayConvenio() {
    try {
      int index = convenioDayName.indexOf(daySelected);

      // Garante que o índice existe na lista
      if (index < 0 || index >= diasConvenio.length) {
        throw Exception("Dia não encontrado em diasConvenio");
      }

      final dia = diasConvenio[index];

      tecPercConvenio.text = dia.percConvenio != null
          ? UtilBrasilFields.obterReal(dia.percConvenio!, moeda: false)
          : '';

      tecPercEmpresa.text = dia.percEmpresa != null
          ? UtilBrasilFields.obterReal(dia.percEmpresa!, moeda: false)
          : '';

    } catch (e) {
      print("Erro ao buscar dia: $e");

      int index = convenioDayName.indexOf(daySelected);

      if (index >= 0) {
        // Cria novo objeto (ajusta conforme seu model)
        final novoDia = ConvenioDia(
          dia: index,
          percConvenio: null,
          percEmpresa: null,
        );

        if (index < diasConvenio.length) {
          diasConvenio[index] = novoDia;
        } else {
          diasConvenio.add(novoDia);
        }
        tecPercConvenio.text = '';
        tecPercEmpresa.text = '';
      }
    }
  }

  void setDataDayConvenio() {
    int index = convenioDayName.indexOf(daySelected);

    double? percConvenio = tecPercConvenio.text.isNotEmpty
        ? UtilBrasilFields.converterMoedaParaDouble(tecPercConvenio.text)
        : null;

    double? percEmpresa = tecPercEmpresa.text.isNotEmpty
        ? UtilBrasilFields.converterMoedaParaDouble(tecPercEmpresa.text)
        : null;

    if (index < diasConvenio.length) {
      diasConvenio[index].percConvenio = percConvenio;
      diasConvenio[index].percEmpresa = percEmpresa;
    } else {
      diasConvenio.add(
        ConvenioDia(
          convenio: convenioSelected?.id,
          dia: index,
          percConvenio: percConvenio,
          percEmpresa: percEmpresa,
        ),
      );
    }
    _setPercTotal();
  }
}
