import 'dart:convert';
import 'dart:typed_data';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/model/endereco_via_cep.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'cadastro_responsavel_controller.g.dart';

class CadastroResponsavelController = _CadastroResponsavelController with _$CadastroResponsavelController;

abstract class _CadastroResponsavelController with Store {
  @observable
  bool isLoading = false;
  @observable
  bool isAltering = false;
  @observable
  bool isDeleting = false;
  @observable
  Uint8List? responsavelImage;
  final formKeyResponsavel = GlobalKey<FormState>();
  final tecNome = TextEditingController();
  final tecDocumento = TextEditingController();
  final tecTelefone = TextEditingController();
  final tecEmail = TextEditingController();
  final tecEndereco = TextEditingController();
  final tecCidade = TextEditingController();
  final tecBairro = TextEditingController();
  final tecEstado = TextEditingController();
  final tecCep = TextEditingController();
  final tecNumero = TextEditingController();
  TextEditingController tecPesquisa = TextEditingController();
  final _responsavelRepository = GenericRepository(
    endpoint: "responsaveis",
    fromJson:(p0) => Responsavel.fromJson(p0),
  );
  @observable
  Responsavel? responsavelSelected;
  @observable
  List<Responsavel> responsaveis = ObservableList.of([]);
  @observable
  int page = 0;
  bool fromCrianca = false;
  final scrollController = ScrollController();


  bool validate(BuildContext context,{Responsavel? responsavel}) {
    if(formKeyResponsavel.currentState!.validate()){
      if(responsavelImage == null && responsavelSelected?.urlImage == null){
        CustomSnackBar.warning(context, "Obrigatório uma foto no cadastro de responsável");
        return false;
      }
      return true;
    }
    return false;
  }

  initializeScroll(){
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        getResponsaveis();
      }
    });
  }

  @action
  Future<void> getResponsaveis({bool refresh = false}) async {
    try {
      if (isLoading) return; // evita chamadas duplicadas
      isLoading = true;

      if (refresh) {
        page = 0;
        responsaveis.clear();
      }

      final novosResponsaveis = await _responsavelRepository.getAll(
        filters: {
          'limit': 50,
          'offset': page * 50,
          if (tecPesquisa.text.isNotEmpty) 'nome': tecPesquisa.text,
        },
      );

      responsaveis.addAll(novosResponsaveis);
      page++;
    } catch (e) {
      print("Erro ao carregar responsáveis: $e");
    } finally {
      isLoading = false;
    }
  }

  @action
  Future createResponsavel(BuildContext context, bool hideParentesco) async{
    isAltering = true;
    Responsavel responsavel = buildResponsavel();
    try{
      print(jsonEncode(buildResponsavel().toJson()));
       Responsavel responsavelTmp = await _responsavelRepository.create(
           responsavel.toJson(hideParentesco: hideParentesco)
      );
      responsavel.id = responsavelTmp.id;
      await uploadImages(responsavel);
      CustomSnackBar.success(context, "Cadastrado com sucesso");
    } catch(e){
      print(e);
      CustomSnackBar.error(context, "Erro ao cadastrar");
    }
    isAltering = false;
    if(fromCrianca){
      final criancaController = Singleton().cadastroCriancaController;
      criancaController.addResponsavel(responsavel: buildResponsavel(responsavelTmp: responsavel));
      Singleton().navigationController.setIndex(Singleton().navigationController.indexCadastroCriancaView);
    }
  }

  @action
  Future updateResponsavel(BuildContext context) async{
    isAltering = true;
    try{
      print(jsonEncode(buildResponsavel(responsavelTmp: responsavelSelected).toJson(hideParentesco: true)));
      await _responsavelRepository.update(
          responsavelSelected?.id,
          buildResponsavel(responsavelTmp: responsavelSelected).toJson(hideParentesco: true)
      );
      if(responsavelImage != null) {
        await uploadImages(responsavelSelected!);
      }
      CustomSnackBar.success(context, "Atualizado com sucesso");
    } catch(e){
      print(e);
      CustomSnackBar.error(context, "Erro ao atualizar");
    }
    isAltering = false;
    if(fromCrianca){
      final criancaController = Singleton().cadastroCriancaController;
      criancaController.alterResponsavel(buildResponsavel(responsavelTmp: responsavelSelected, parentesco: responsavelSelected?.parentesco));
      Singleton().navigationController.setIndex(Singleton().navigationController.indexCadastroCriancaView);
      // setResponsavel(responsavel: null);
    }
  }

  @action
  Future deleteResponsavel(BuildContext context,Responsavel responsavel) async{
    isDeleting = true;
    try{
      await _responsavelRepository.delete(responsavel.id,);
      CustomSnackBar.success(context, "Removido com sucesso");
    } catch(e){
      print(e);
      CustomSnackBar.error(
          context,
          "Erro ao remover, verifique se não existe nenhum vínculo com alguma criança ou algum atendimento com esse responsável"
      );
    }
    await getResponsaveis(refresh: true);
    isDeleting = false;
  }

  uploadImages(Responsavel responsavel) async{
    if(responsavelImage != null) {
      await _responsavelRepository.uploadFile(
        pathField: "responsavel",
        filename: '${UtilBrasilFields.removeCaracteres(tecDocumento.text)}.png',
        fileBytes: responsavelImage!,
      );
    }
  }

  Responsavel buildResponsavel({Responsavel? responsavelTmp,String? parentesco}){
    Responsavel responsavel = Responsavel(
      id: responsavelTmp?.id,
      nome: tecNome.text,
      urlImage: "https://brinkoo.com.br/images/${Singleton.instance.tenant}/responsavel/${UtilBrasilFields.removeCaracteres(tecDocumento.text)}.png",
      email: tecEmail.text,
      bairro: tecBairro.text,
      cidade: tecCidade.text,
      documento: UtilBrasilFields.removeCaracteres(tecDocumento.text),
      endereco: tecEndereco.text,
      estado: tecEstado.text,
      celular: UtilBrasilFields.removeCaracteres(tecTelefone.text),
      cep: UtilBrasilFields.removeCaracteres(tecCep.text),
      numero: tecNumero.text,
      parentesco: parentesco
    );
    return responsavel;
  }

  @action
  addFoto(Uint8List p0){
    responsavelImage = p0;
  }

  @action
  setResponsavel({Responsavel? responsavel}){
    if(responsavel != null){
      responsavelSelected = responsavel;
      try{
        tecDocumento.text = UtilBrasilFields.obterCpf(responsavel.documento!,);
      } catch(e){
        tecDocumento.text = responsavel.documento??'';
      }
      tecEstado.text = responsavel.estado??'';
      tecEndereco.text = responsavel.endereco??'';
      tecBairro.text = responsavel.bairro??'';
      tecCidade.text = responsavel.cidade??'';
      tecEmail.text = responsavel.email??'';

      try{
        tecTelefone.text = UtilBrasilFields.obterTelefone(responsavel.celular??'');
      } catch(e){
        tecTelefone.text = responsavel.celular??'';
      }

      tecNome.text = responsavel.nome??'';

      try{
        tecCep.text = UtilBrasilFields.obterCep(responsavel.cep??'');
      } catch(e){
        tecCep.text = responsavel.cep??'';
      }

      tecNumero.text = responsavel.numero??"";


    } else {
      clearAll();
    }
  }

  clearAll(){
    responsavelSelected = null;
    tecDocumento.text = '';
    tecEstado.text = '';
    tecEndereco.text = '';
    tecBairro.text = '';
    tecCidade.text = '';
    tecEmail.text = '';
    tecTelefone.text = '';
    tecNome.text = '';
    tecNumero.text = '';
    tecCep.text = '';
    setFromCrianca(false);
  }

  setEnderecoByCep() async{
    final _cepRepository = GenericRepository<EnderecoViaCep>(
      endpoint: "viacep/${UtilBrasilFields.removeCaracteres(tecCep.text)}",
      fromJson: (p0) => EnderecoViaCep.fromJson(p0),
    );
    EnderecoViaCep enderecoViaCep = await _cepRepository.get();
    tecBairro.text = enderecoViaCep.bairro??'';
    tecCidade.text = enderecoViaCep.localidade??'';
    tecEstado.text = enderecoViaCep.uf??'';
    tecEndereco.text = enderecoViaCep.logradouro??'';
  }

  setFromCrianca(bool value) => fromCrianca = value;

}
