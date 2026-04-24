import 'dart:convert';
import 'package:brinquedoteca_flutter/component/custom/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/model/atividade.dart';
import 'package:brinquedoteca_flutter/model/tmp/icone_atividade.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:brinquedoteca_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'cadastro_atividade_controller.g.dart';

class CadastroAtividadeController = _CadastroAtividadeController with _$CadastroAtividadeController;

abstract class _CadastroAtividadeController with Store {
  TextEditingController tecNomeAtividade = TextEditingController();
  TextEditingController tecDescricaoAtividade = TextEditingController();
  TextEditingController tecCodigoAtividade = TextEditingController();
  TextEditingController tecPesquisa = TextEditingController();
  final formKeyAtividade = GlobalKey<FormState>();
  final _atividadeRepository = GenericRepository(
      endpoint: "atividades",
      fromJson:(p0) => Atividade.fromJson(p0),
  );
  @observable
  bool isAltering = false;
  @observable
  bool isDeleting = false;
  @observable
  bool isLoading = false;
  @observable
  List<Atividade> atividades = ObservableList.of([]);
  @observable
  IconeAtividade? iconSelected;
  @observable
  int radioAtivo = 0;
  @observable
  int radioPadrao = 0;
  Atividade? atividadeSelected;

  Future<List<Atividade>> getAtividades() async{
    isLoading = true;
    try{
      atividades = await _atividadeRepository.getAll();
    } catch(e){
      print(e);
    }
    isLoading = false;
    return atividades;
  }


  @action
  Future createAtividade(BuildContext context) async{
    isAltering = true;
    try{
      print(jsonEncode(_buildAtividade().toJson()));
      await _atividadeRepository.create(_buildAtividade().toJson());
      CustomSnackBar.success(context, "Cadastrado com sucesso");
    } catch(e){
      print(e);
      CustomSnackBar.error(context, "Erro ao cadastrar");
    }
    isAltering = false;
  }

  @action
  Future updateAtividade(BuildContext context) async{
    isAltering = true;
    try{
      print(jsonEncode(_buildAtividade(atividade:atividadeSelected).toJson()));
      await _atividadeRepository.update(atividadeSelected?.id,_buildAtividade(atividade:atividadeSelected).toJson());
      CustomSnackBar.success(context, "Atualizado com sucesso");
    } catch(e){
      print(e);
      CustomSnackBar.error(context, "Erro ao atualizar");
    }
    isAltering = false;
  }

  @action
  Future deleteAtividade(BuildContext context,Atividade atividade) async{
    isDeleting = true;
    try{
      await _atividadeRepository.delete(atividadeSelected?.id);
      CustomSnackBar.success(context, "Removido com sucesso");
    } catch(e){
      print(e);
      CustomSnackBar.error(context, "Erro ao remover");
    }
    setAtividade(atividade: null);
    await getAtividades();
    isDeleting = false;
  }

  Atividade _buildAtividade({Atividade? atividade}){
    Atividade criancaTmp = Atividade(
      id: atividade?.id,
      nome: tecNomeAtividade.text,
      descricao: tecDescricaoAtividade.text,
      icone: iconSelected?.nome,
      ativo: radioAtivo == 0,
      padrao:  radioPadrao == 0
    );
    return criancaTmp;
  }

  @action
  void setAtividade({Atividade? atividade}){
    atividadeSelected = atividade;
    if(atividade != null){
      tecNomeAtividade.text = atividade.nome??'';
      tecDescricaoAtividade.text = atividade.descricao??'';
      tecCodigoAtividade.text = atividade.id.toString();
      setRadioPadrao(atividade.padrao == true ? 0 : 1);
      setRadioAtivo(atividade.ativo == true ? 0 : 1);
      try{
        setIconAtividade(Utils().getIconeAtividadeByName(atividade.icone!)!);
      } catch(e){

      }
    } else {
      clearAll();
    }
  }


  void clearAll() {

    tecNomeAtividade.clear();
    tecDescricaoAtividade.clear();
    tecCodigoAtividade.clear();
    atividadeSelected = null;

    setRadioPadrao(0);
    setRadioAtivo(0);

    iconSelected = null;

  }

  @action
  setIconAtividade(IconeAtividade icon) => iconSelected = icon;

  @action
  setRadioAtivo(int value) => radioAtivo = value;

  @action
  setRadioPadrao(int value) => radioPadrao = value;
}
