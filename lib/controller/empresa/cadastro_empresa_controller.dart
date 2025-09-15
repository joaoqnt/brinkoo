import 'dart:convert';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/model/empresa.dart';
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
  final formKeyEmpresa = GlobalKey<FormState>();
  final _empresaRepository = GenericRepository(
      endpoint: "empresas",
      fromJson:(p0) => Empresa.fromJson(p0),
  );
  @observable
  bool isLoading = false;


  @action
  Future createEmpresa(BuildContext context) async{
    isLoading = true;
    try{
      print(jsonEncode(_buildEmpresa().toJson()));
      await _empresaRepository.create(_buildEmpresa().toJson());
      CustomSnackBar.success(context, "Cadastrado com sucesso");
    } catch(e){
      print(e);
      CustomSnackBar.error(context, "Erro ao cadastrar");
    }
    isLoading = false;
  }

  @action
  Future updateEmpresa(BuildContext context, Empresa empresa) async{
    isLoading = true;
    try{
      print(jsonEncode(_buildEmpresa(empresa:empresa).toJson()));
      await _empresaRepository.update(empresa.id,_buildEmpresa(empresa:empresa).toJson());
      CustomSnackBar.success(context, "Atualizado com sucesso");
    } catch(e){
      print(e);
      CustomSnackBar.error(context, "Erro ao atualizar");
    }
    isLoading = false;
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
  void setEmpresa({Empresa? emprsa}) {
    if (emprsa != null) {
      tecCodigo.text = emprsa.id?.toString() ?? '';
      tecNome.text = emprsa.descricao ?? '';
      tecCnpj.text = emprsa.cnpj != null ? UtilBrasilFields.obterCnpj(emprsa.cnpj!) : '';
      tecCep.text = emprsa.cep != null ? UtilBrasilFields.obterCep(emprsa.cep!) : '';
      tecTelefone.text = emprsa.telefone != null ? UtilBrasilFields.obterTelefone(emprsa.telefone!) : '';
      tecCelular.text = emprsa.celular != null ? UtilBrasilFields.obterTelefone(emprsa.celular!) : '';
      tecEmail.text = emprsa.email ?? '';
      tecBairro.text = emprsa.bairro ?? '';
      tecCidade.text = emprsa.cidade ?? '';
      tecUf.text = emprsa.uf ?? '';
      tecLogradouro.text = emprsa.logradouro ?? '';
      tecNumero.text = emprsa.numero ?? '';
      tecComplemento.text = emprsa.complemento ?? '';
      tecInscEst.text = emprsa.inscest ?? '';
      tecCnae.text = emprsa.cnae ?? '';
    }
  }

}
