import 'dart:convert';
import 'package:brinquedoteca_flutter/component/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/model/natureza.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'cadastro_natureza_controller.g.dart';

class CadastroNaturezaController = _CadastroNaturezaController with _$CadastroNaturezaController;

abstract class _CadastroNaturezaController with Store {
  TextEditingController tecNomeNatureza = TextEditingController();
  TextEditingController tecCodigoNatureza = TextEditingController();
  final formKeyCenCus = GlobalKey<FormState>();
  final _naturezaRepository = GenericRepository(
      endpoint: "naturezas",
      fromJson:(p0) => Natureza.fromJson(p0),
  );
  @observable
  bool isLoading = false;


  @action
  Future createNatureza(BuildContext context) async{
    isLoading = true;
    try{
      print(jsonEncode(_buildNatureza().toJson()));
      await _naturezaRepository.create(_buildNatureza().toJson());
      CustomSnackBar.success(context, "Cadastrado com sucesso");
    } catch(e){
      print(e);
      CustomSnackBar.error(context, "Erro ao cadastrar");
    }
    isLoading = false;
  }

  @action
  Future updateNatureza(BuildContext context, Natureza natureza) async{
    isLoading = true;
    try{
      print(jsonEncode(_buildNatureza(natureza:natureza).toJson()));
      await _naturezaRepository.update(natureza.id,_buildNatureza(natureza:natureza).toJson());
      CustomSnackBar.success(context, "Atualizado com sucesso");
    } catch(e){
      print(e);
      CustomSnackBar.error(context, "Erro ao atualizar");
    }
    isLoading = false;
  }

  Natureza _buildNatureza({Natureza? natureza}){
    Natureza criancaTmp = Natureza(
      id: natureza?.id,
      descricao: tecNomeNatureza.text,
    );
    return criancaTmp;
  }

  @action
  void setNatureza({Natureza? natureza}){
    if(natureza != null){
      tecNomeNatureza.text = natureza.descricao??'';
      tecCodigoNatureza.text = natureza.id.toString();
    }
  }
}
