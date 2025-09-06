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
  final formKeyCenCus = GlobalKey<FormState>();
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

  Empresa _buildEmpresa({Empresa? empresa}){
    Empresa criancaTmp = Empresa(
      id: empresa?.id,
      descricao: tecNome.text,
      cnpj: UtilBrasilFields.removeCaracteres(tecCnpj.text)
    );
    return criancaTmp;
  }

  @action
  void setEmpresa({Empresa? emprsa}){
    if(emprsa != null){
      tecNome.text = emprsa.descricao??'';
      tecCnpj.text = UtilBrasilFields.obterCnpj(emprsa.cnpj!);
      tecCodigo.text = emprsa.id.toString();
    }
  }
}
