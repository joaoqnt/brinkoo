import 'dart:convert';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/model/busca_cnpj.dart';
import 'package:brinquedoteca_flutter/model/empresa.dart';
import 'package:brinquedoteca_flutter/model/endereco_via_cep.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'cadastro_empresa_controller.g.dart';

class CadastroEmpresaController = _CadastroEmpresaController with _$CadastroEmpresaController;

abstract class _CadastroEmpresaController with Store {
  TextEditingController tecNome = TextEditingController();
  TextEditingController tecCodigo = TextEditingController();
  TextEditingController tecCnpj = TextEditingController();
  TextEditingController tecCep = TextEditingController();
  TextEditingController tecBairro = TextEditingController();
  TextEditingController tecCidade = TextEditingController();
  TextEditingController tecUf = TextEditingController();
  TextEditingController tecLogradouro = TextEditingController();
  TextEditingController tecNumero = TextEditingController();
  TextEditingController tecComplemento = TextEditingController();
  TextEditingController tecTelefone = TextEditingController();
  TextEditingController tecCelular = TextEditingController();
  TextEditingController tecEmail = TextEditingController();
  TextEditingController tecInscEst = TextEditingController();
  TextEditingController tecCnae = TextEditingController();
  TextEditingController tecPesquisa = TextEditingController();
  final formKeyEmpresa = GlobalKey<FormState>();
  final _empresaRepository = GenericRepository(
      endpoint: "empresas",
      fromJson:(p0) => Empresa.fromJson(p0),
  );
  @observable
  bool isLoading = false;
  @observable
  bool isAltering = false;
  @observable
  List<Empresa> empresas = ObservableList.of([]);
  Empresa? empresaSelected;

  Future<List<Empresa>> getEmpresas() async{
    try{
      empresas = await _empresaRepository.getAll();
    } catch(e){
      print(e);
    }
    return empresas;
  }

  @action
  Future createEmpresa(BuildContext context) async{
    isAltering = true;
    try{
      print(jsonEncode(_buildEmpresa().toJson()));
      await _empresaRepository.create(_buildEmpresa().toJson());
      await getEmpresas();
      CustomSnackBar.success(context, "Cadastrado com sucesso");
    } catch(e){
      print(e);
      CustomSnackBar.error(context, "Erro ao cadastrar");
    }
    isAltering = false;
  }

  @action
  Future updateEmpresa(BuildContext context) async{
    isAltering = true;
    try{
      print(jsonEncode(_buildEmpresa(empresa:empresaSelected).toJson()));
      await _empresaRepository.update(empresaSelected?.id,_buildEmpresa(empresa:empresaSelected).toJson());
      await getEmpresas();
      CustomSnackBar.success(context, "Atualizado com sucesso");
    } catch(e){
      print(e);
      CustomSnackBar.error(context, "Erro ao atualizar");
    }
    isAltering = false;
  }

  Empresa _buildEmpresa({Empresa? empresa}) {
    return Empresa(
      id: empresa?.id,
      descricao: tecNome.text,
      cnpj: UtilBrasilFields.removeCaracteres(tecCnpj.text),
      cep: UtilBrasilFields.removeCaracteres(tecCep.text),
      bairro: tecBairro.text,
      cidade: tecCidade.text,
      uf: tecUf.text,
      logradouro: tecLogradouro.text,
      numero: tecNumero.text,
      complemento: tecComplemento.text,
      telefone: UtilBrasilFields.removeCaracteres(tecTelefone.text),
      celular: UtilBrasilFields.removeCaracteres(tecCelular.text),
      email: tecEmail.text,
      inscest: tecInscEst.text,
      cnae: tecCnae.text,
    );
  }

  @action
  void setEmpresa({Empresa? empresa}) {
    empresaSelected = empresa;
    if (empresa != null) {
      tecCodigo.text = empresa.id?.toString() ?? '';
      tecNome.text = empresa.descricao ?? '';
      tecCnpj.text = empresa.cnpj != null ? UtilBrasilFields.obterCnpj(empresa.cnpj!) : '';
      tecCep.text = empresa.cep != null ? UtilBrasilFields.obterCep(empresa.cep!) : '';
      tecTelefone.text = empresa.telefone != null ? UtilBrasilFields.obterTelefone(empresa.telefone!) : '';
      tecCelular.text = empresa.celular != null ? UtilBrasilFields.obterTelefone(empresa.celular!) : '';
      tecEmail.text = empresa.email ?? '';
      tecBairro.text = empresa.bairro ?? '';
      tecCidade.text = empresa.cidade ?? '';
      tecUf.text = empresa.uf ?? '';
      tecLogradouro.text = empresa.logradouro ?? '';
      tecNumero.text = empresa.numero ?? '';
      tecComplemento.text = empresa.complemento ?? '';
      tecInscEst.text = empresa.inscest ?? '';
      tecCnae.text = empresa.cnae ?? '';
    } else {
      clearAll();
    }
  }

  void clearAll() {
    tecCodigo.clear();
    tecNome.clear();
    tecCnpj.clear();
    tecCep.clear();
    tecTelefone.clear();
    tecCelular.clear();
    tecEmail.clear();
    tecBairro.clear();
    tecCidade.clear();
    tecUf.clear();
    tecLogradouro.clear();
    tecNumero.clear();
    tecComplemento.clear();
    tecInscEst.clear();
    tecCnae.clear();
  }

  setEnderecoByCep() async{
    final _cepRepository = GenericRepository<EnderecoViaCep>(
      endpoint: "viacep/${UtilBrasilFields.removeCaracteres(tecCep.text)}",
      fromJson: (p0) => EnderecoViaCep.fromJson(p0),
    );
    EnderecoViaCep enderecoViaCep = await _cepRepository.get();
    tecBairro.text = enderecoViaCep.bairro??'';
    tecCidade.text = enderecoViaCep.localidade??'';
    tecUf.text = enderecoViaCep.uf??'';
    tecLogradouro.text = enderecoViaCep.logradouro??'';
  }

  setDataByCnpj() async{
    try{
      final _cnpjRepository = GenericRepository<BuscaCnpj>(
        endpoint: "opencnpj/${UtilBrasilFields.removeCaracteres(tecCnpj.text)}",
        fromJson: (p0) => BuscaCnpj.fromJson(p0),
      );
      BuscaCnpj buscaCnpj = await _cnpjRepository.get();

      tecBairro.text = buscaCnpj.bairro??'';
      tecCidade.text = buscaCnpj.municipio??'';
      tecUf.text = buscaCnpj.uf??'';
      tecLogradouro.text = buscaCnpj.logradouro??'';
      tecNome.text = buscaCnpj.nome??'';
      tecEmail.text = buscaCnpj.email??'';
      try{
        tecCep.text = buscaCnpj.cep??'';
      } catch(e){
        tecCep.text = buscaCnpj.cep??'';
      }

      try{
        tecTelefone.text = UtilBrasilFields.obterTelefone("${UtilBrasilFields.removeCaracteres(buscaCnpj.telefone!)}");
      } catch(e){

      }

    } catch(e){
      print(e);
    }
  }
}
