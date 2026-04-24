import 'dart:convert';
import 'dart:typed_data';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_responsavel_controller.dart';
import 'package:brinquedoteca_flutter/model/atividade.dart';
import 'package:brinquedoteca_flutter/model/crianca.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:brinquedoteca_flutter/utils/date_helper_util.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:brinquedoteca_flutter/utils/take_photo.dart';
import 'package:brinquedoteca_flutter/utils/utils.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';

part 'cadastro_crianca_controller.g.dart';

class CadastroCriancaController = _CadastroCriancaController with _$CadastroCriancaController;

abstract class _CadastroCriancaController with Store {
  TextEditingController tecNomeCrianca = TextEditingController();
  TextEditingController tecCpfCrianca = TextEditingController();
  TextEditingController tecDataCrianca = TextEditingController();
  TextEditingController tecIdadeCrianca = TextEditingController();
  TextEditingController tecGrupoSanguineoCrianca = TextEditingController();
  TextEditingController tecAlergiaCrianca = TextEditingController();
  TextEditingController tecObservacaoCrianca = TextEditingController();
  final formKeyCrianca = GlobalKey<FormState>();
  final _criancaRepository = GenericRepository(
      endpoint: "criancas",
      fromJson:(p0) => Crianca.fromJson(p0),
  );
  Map<String,String> sexos = {
    "M":"Masculino",
    "F":"Feminino",
    "O":"Outros",
  };

  List<String> tiposRelacionamento = [
    'Mae',
    'Pai',
    'Avó',
    'Avô',
    'Bisavó',
    'Bisavô',
    'Madrasta',
    'Padrasto',
    'Irmã',
    'Irmão',
    'Tia',
    'Tio',
    'Prima',
    'Baba',
    'Professora',
    'Outro'
  ];

  Map<Responsavel,String?> relacionamentoSelected = {};

  @observable
  Uint8List? criancaImage;

  @observable
  List<Responsavel> responsaveis = ObservableList.of([]);
  @observable
  bool isLoading = false;
  @observable
  Crianca? criancaSelected;
  @observable
  ObservableList<Atividade> atividadesSelected = ObservableList.of([]);
  @observable
  ObservableList<Atividade> atividades = ObservableList.of([]);
  @observable
  int radioAtivo = 0;
  Map<String,String>  sexoCrianca = {"M":"Masculino"};

  TextEditingController tecPesquisa = TextEditingController();

  @observable
  bool isDeleting = false;

  @observable
  bool isAltering = false;

  @observable
  bool hasMore = true; // controla se ainda tem mais registros

  @observable
  List<Crianca> criancas = ObservableList.of([]);

  @observable
  int indexPage = 0;

  bool fromCheckin = false;

  final Map<String, Map<String, TextEditingController>> filtersConfig = {
    "Nome da Criança": {
      "unaccent(LOWER(c.nome))": TextEditingController()
    },
    "Responsável": {
      "unaccent(LOWER(rf.nome))": TextEditingController()
    }
  };

  int _offset = 0;
  final int _limit = 50;

  final scrollController = ScrollController();

  late TabController tabController;
  final List<Tab> tabs = const [
    Tab(text: 'Novo cadastro'),
    Tab(text: 'Crianças já cadastradas'),
  ];

  initTabController(TickerProvider vsync){
    tabController = TabController(length: tabs.length, vsync: vsync,initialIndex: indexPage);
  }

  @action
  Future<void> getCriancas({bool reset = false}) async {
    if(atividades.isEmpty)
      _getAtividades();
    try {
      if (isLoading) return;
      isLoading = true;

      if (reset) {
        _offset = 0;
        hasMore = true;
        criancas.clear();
      }

      if (!hasMore) return;

      Map<String, dynamic> filters = {
        'limit': _limit,
        'offset': _offset,
      };

      // Filtro principal de pesquisa
      if (tecPesquisa.text.isNotEmpty) {
        filters['unaccent(LOWER(c.nome))'] =
            Utils.removerAcentosEMinusculo(tecPesquisa.text);
      }

      // 🔥 Aqui adiciona dinamicamente os filtros do dialog
      filtersConfig.forEach((label, mapInterno) {
        mapInterno.forEach((campo, controller) {
          if (controller.text.isNotEmpty) {
            filters[campo] =
                Utils.removerAcentosEMinusculo(controller.text);
          }
        });
      });

      final novaLista = await _criancaRepository.getAll(
        filters: filters,
      );

      if (novaLista.isEmpty || novaLista.length < _limit) {
        hasMore = false;
      }

      criancas.addAll(novaLista);
      _offset += _limit;

    } catch (e) {
      print("Erro ao carregar crianças: $e");
    } finally {
      isLoading = false;
    }
    _initializeScrollController();
  }

  _initializeScrollController(){
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        getCriancas();
      }
    });
  }

  @action
  Future<void> resetarFiltros() async {
    // Limpa campo de pesquisa principal
    tecPesquisa.clear();

    // Limpa todos os filtros do dialog
    filtersConfig.forEach((_, mapInterno) {
      mapInterno.forEach((_, controller) {
        controller.clear();
      });
    });

    // Recarrega lista do zero
    await getCriancas(reset: true);
  }

  @action
  Future<void> deleteCrianca(BuildContext context, Crianca crianca) async{
    isDeleting = true;
    try{
      await _criancaRepository.delete(crianca.id);
      await getCriancas(reset: true);
      CustomSnackBar.success(context, "Removido com sucesso");
    } catch(e){
      print(e);
      CustomSnackBar.error(context, "Erro ao remover.\nSe a criança já tiver alguma movimentação, favor apenas inativar o cadastro.");
    }
    isDeleting = false;
  }

  @action
  Future<void> addFoto(Uint8List imageBytes) async {
    criancaImage = imageBytes;
  }

  @action
  addResponsavel({Responsavel? responsavel}){
    Responsavel responsavelTmp = responsavel??Responsavel();
    if(responsaveis.where((element) => element.id == responsavel?.id,).firstOrNull == null) {
      responsaveis.add(responsavelTmp);
    }
  }

  @action
  void alterResponsavel(Responsavel responsavel) {
    final index = responsaveis.indexWhere((r) => r.id == responsavel.id);

    if (index != -1) {
      responsaveis[index] = responsavel;
    }
  }

  @action
  removeResponsavel(Responsavel? responsavel){
    responsaveis.remove(responsavel);
  }

  bool validate(BuildContext context) {
    // 1. Verifica se há ao menos um responsável
    if (responsaveis.isEmpty) {
      CustomSnackBar.warning(context, "Obrigatório ao menos um responsável da criança");
      return false;
    }

    // 2. Verifica se a imagem da criança está presente
    if (criancaImage == null && criancaSelected?.urlImage == null) {
      CustomSnackBar.warning(context, "Imagem da criança é obrigatória");
      return false;
    }

    // 3. Valida o saida da criança
    final isFormCriancaValid = formKeyCrianca.currentState?.validate() ?? false;

    // 4. Valida os formKeys dos responsáveis contidos em responsaveisController
    bool areResponsaveisControllerFormsValid = true;



    // 6. Retorna resultado final
    return isFormCriancaValid && areResponsaveisControllerFormsValid;
  }



  @action
  Future createCrianca(BuildContext context) async{
    isAltering = true;
    Crianca? crianca;
    try{
      crianca = buildCrianca();
      print(jsonEncode(crianca.toJson()));
      Crianca criancaTmp = await _criancaRepository.create(crianca.toJson());
      crianca.id = criancaTmp.id;
      await _uploadImages(crianca);
      CustomSnackBar.success(context, "Cadastrado com sucesso");
    } catch(e){
      print(e);
      CustomSnackBar.error(context, "Erro ao cadastrar");
    }
    isAltering = false;
    if(fromCheckin){
      final checkinController = Singleton().cadastroCheckinController;
      checkinController.setCrianca(crianca!);
      Singleton().navigationController.setIndex(Singleton().navigationController.indexCadastroCheckinView);
    } else {
      setCrianca(crianca: null);
    }
  }

  @action
  Future updateCrianca(BuildContext context) async{
    isAltering = true;
    try{
      Crianca criancaTmp = await _criancaRepository.update( criancaSelected?.id,buildCrianca(crianca:criancaSelected).toJson());
      await _uploadImages(criancaSelected!);
      CustomSnackBar.success(context, "Atualizado com sucesso");
    } catch(e){
      print(e);
      CustomSnackBar.error(context, "Erro ao atualizar");
    }
    isAltering = false;

    if(fromCheckin){
      final checkinController = Singleton().cadastroCheckinController;
      Crianca crianca = buildCrianca(crianca:criancaSelected);
      print("responsaveis: ${crianca.responsaveis?.length}");
      checkinController.alterCrianca(crianca);
      Singleton().navigationController.setIndex(Singleton().navigationController.indexCadastroCheckinView);
      // setResponsavel(responsavel: null);
    } else {
      await getCriancas(reset: true);
      setCrianca(crianca: null);
    }
  }

  _uploadImages(Crianca crianca) async{
    if(criancaImage != null){
      await _criancaRepository.uploadFile(
        pathField: "criança",
        filename: '${crianca.id}.png',
        fileBytes: criancaImage!,
      );
    }
  }



  Crianca buildCrianca({Crianca? crianca}){
    Crianca criancaTmp = Crianca(
      id: crianca?.id,
      nome: tecNomeCrianca.text,
      alergias: tecAlergiaCrianca.text,
      dataCadastro: DateTime.now(),
      dataImagem: DateTime.now(),
      dataNascimento: DateHelperUtil.parseBrDateToDateTime(tecDataCrianca.text),
      grupoSanguineo: tecGrupoSanguineoCrianca.text,
      sexo: sexoCrianca.keys.firstOrNull,
      observacoes: tecObservacaoCrianca.text,
      responsaveis: responsaveis,
      urlImage: "https://brinkoo.com.br/images/${Singleton.instance.tenant}/criança/${crianca?.id}.png",
      atividades: atividadesSelected,
      ativo: radioAtivo == 0,
      cpf: tecCpfCrianca.text.isNotEmpty ? UtilBrasilFields.removeCaracteres(tecCpfCrianca.text) : ""
    );
    return criancaTmp;
  }

  void setSexoCrianca(String? value) {
    if (value != null && sexos.containsKey(value)) {
      sexoCrianca.clear(); // limpa valores anteriores
      sexoCrianca[value] = sexos[value]!; // adiciona o novo
    }
  }

  void setRelacionamento(Responsavel responsavel,String relacionamento){
    responsavel.parentesco = relacionamento;
    // relacionamentoSelected[responsavel] = relacionamento;
  }

  @action
  Future<void> setCrianca({Crianca? crianca}) async{
    await _getAtividades();
    if(!fromCheckin)
      responsaveis.clear();
    if(crianca != null){
      criancaSelected = crianca;
      tecNomeCrianca.text = crianca.nome??'';
      if(crianca.dataNascimento != null)
        tecDataCrianca.text = DateHelperUtil.formatDate(crianca.dataNascimento!);
      tecGrupoSanguineoCrianca.text = crianca.grupoSanguineo??'';
      tecAlergiaCrianca.text = crianca.alergias??'';
      tecObservacaoCrianca.text = crianca.observacoes??'';
      try{
        tecCpfCrianca.text = UtilBrasilFields.obterCpf(crianca.cpf!);
      } catch(e){
        tecCpfCrianca.text = crianca.cpf??'';
      }
      if(fromCheckin){

      }
      crianca.responsaveis?.forEach((element) {
        addResponsavel(responsavel: element);
      });
      atividadesSelected.clear();
      crianca.atividades?.forEach((element) {
        atividadesSelected.add(element);
      });
      setRadioAtivo(crianca.ativo == true ? 0 : 1);
    } else {
      clearAll();
    }
    setIdadeCrianca();
  }

  void clearAll() {
    tecNomeCrianca.clear();
    tecDataCrianca.clear();
    tecGrupoSanguineoCrianca.clear();
    tecAlergiaCrianca.clear();
    tecObservacaoCrianca.clear();
    tecCpfCrianca.clear();

    criancaSelected = null;

    responsaveis.clear();
    atividadesSelected.clear();
    criancaImage = null;

    setRadioAtivo(0);
  }

  void setIdadeCrianca(){
    try{
      DateTime? dataNascimento = DateHelperUtil.parseBrDateToDateTime(tecDataCrianca.text);
      tecIdadeCrianca.text = Utils.calcularIdade(dataNascimento!).toString();
    } catch(e){
      tecIdadeCrianca.clear();
    }
  }

  @action
  Future<List<Atividade>> _getAtividades() async {
    this.atividades = ObservableList.of(await Singleton().cadastroAtividadeController.getAtividades());
    return atividades;
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
  setRadioAtivo(int value) => radioAtivo = value;

  @action
  setIndexPage(int value) {
    indexPage = value;
    tabController.animateTo(value);
  }

  setFromCheckin(bool value) => fromCheckin = value;
}
