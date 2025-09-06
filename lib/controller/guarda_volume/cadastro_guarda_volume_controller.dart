import 'dart:convert';
import 'package:brinquedoteca_flutter/component/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/model/guarda_volume.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'cadastro_guarda_volume_controller.g.dart';

class CadastroGuardaVolumeController = _CadastroGuardaVolumeController with _$CadastroGuardaVolumeController;

abstract class _CadastroGuardaVolumeController with Store {
  TextEditingController tecNome = TextEditingController();
  TextEditingController tecCodigo = TextEditingController();
  final formKeyCenCus = GlobalKey<FormState>();
  final _naturezaRepository = GenericRepository(
      endpoint: "guardas-volume",
      fromJson:(p0) => GuardaVolume.fromJson(p0),
  );
  @observable
  bool isLoading = false;


  @action
  Future createGuardaVolume(BuildContext context) async{
    isLoading = true;
    try{
      print(jsonEncode(_buildGuardaVolume().toJson()));
      await _naturezaRepository.create(_buildGuardaVolume().toJson());
      CustomSnackBar.success(context, "Cadastrado com sucesso");
    } catch(e){
      print(e);
      CustomSnackBar.error(context, "Erro ao cadastrar");
    }
    isLoading = false;
  }

  @action
  Future updateGuardaVolume(BuildContext context, GuardaVolume guardaVolume) async{
    isLoading = true;
    try{
      print(jsonEncode(_buildGuardaVolume(guardaVolume:guardaVolume).toJson()));
      await _naturezaRepository.update(guardaVolume.id,_buildGuardaVolume(guardaVolume:guardaVolume).toJson());
      CustomSnackBar.success(context, "Atualizado com sucesso");
    } catch(e){
      print(e);
      CustomSnackBar.error(context, "Erro ao atualizar");
    }
    isLoading = false;
  }

  GuardaVolume _buildGuardaVolume({GuardaVolume? guardaVolume}){
    GuardaVolume criancaTmp = GuardaVolume(
      id: guardaVolume?.id,
      descricao: tecNome.text,
      utilizado: false
    );
    return criancaTmp;
  }

  @action
  void setGuardaVolume({GuardaVolume? guardaVolume}){
    if(guardaVolume != null){
      tecNome.text = guardaVolume.descricao??'';
      tecCodigo.text = guardaVolume.id.toString();
    }
  }
}
