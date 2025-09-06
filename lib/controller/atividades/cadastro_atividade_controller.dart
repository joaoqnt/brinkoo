import 'dart:convert';
import 'package:brinquedoteca_flutter/component/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/model/atividade.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'cadastro_atividade_controller.g.dart';

class CadastroAtividadeController = _CadastroAtividadeController with _$CadastroAtividadeController;

abstract class _CadastroAtividadeController with Store {
  TextEditingController tecNomeAtividade = TextEditingController();
  TextEditingController tecCodigoAtividade = TextEditingController();
  final formKeyAtividade = GlobalKey<FormState>();
  final _atividadeRepository = GenericRepository(
      endpoint: "atividades",
      fromJson:(p0) => Atividade.fromJson(p0),
  );
  @observable
  bool isLoading = false;


  @action
  Future createAtividade(BuildContext context) async{
    isLoading = true;
    try{
      print(jsonEncode(_buildAtividade().toJson()));
      await _atividadeRepository.create(_buildAtividade().toJson());
      CustomSnackBar.success(context, "Cadastrado com sucesso");
    } catch(e){
      print(e);
      CustomSnackBar.error(context, "Erro ao cadastrar");
    }
    isLoading = false;
  }

  @action
  Future updateAtividade(BuildContext context, Atividade atividade) async{
    isLoading = true;
    try{
      print(jsonEncode(_buildAtividade(atividade:atividade).toJson()));
      await _atividadeRepository.update(atividade.id,_buildAtividade(atividade:atividade).toJson());
      CustomSnackBar.success(context, "Atualizado com sucesso");
    } catch(e){
      print(e);
      CustomSnackBar.error(context, "Erro ao atualizar");
    }
    isLoading = false;
  }

  Atividade _buildAtividade({Atividade? atividade}){
    Atividade criancaTmp = Atividade(
      id: atividade?.id,
      descricao: tecNomeAtividade.text,
    );
    return criancaTmp;
  }

  @action
  void setAtividade({Atividade? atividade}){
    if(atividade != null){
      tecNomeAtividade.text = atividade.descricao??'';
      tecCodigoAtividade.text = atividade.id.toString();
    }
  }
}
