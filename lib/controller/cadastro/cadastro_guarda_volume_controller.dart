import 'dart:convert';
import 'package:brinquedoteca_flutter/component/custom/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/model/guarda_volume.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'cadastro_guarda_volume_controller.g.dart';

class CadastroGuardaVolumeController = _CadastroGuardaVolumeController with _$CadastroGuardaVolumeController;

abstract class _CadastroGuardaVolumeController with Store {
  TextEditingController tecNome = TextEditingController();
  TextEditingController tecCodigo = TextEditingController();
  TextEditingController tecPesquisa = TextEditingController();
  final formKeyGuardaVolume = GlobalKey<FormState>();
  final _guardasVolumeRepository = GenericRepository(
      endpoint: "guardas-volume",
      fromJson:(p0) => GuardaVolume.fromJson(p0),
  );
  GuardaVolume? guardaVolumeSelected;
  @observable
  bool isLoading = false;
  @observable
  bool isAltering = false;
  @observable
  bool isDeleting = false;
  @observable
  List<GuardaVolume> guardasVoulme = ObservableList.of([]);
  @observable
  int radioAtivo = 0;

  Future<List<GuardaVolume>> getGuardasVolumes({String? descricao}) async{
    try{
      dynamic filters = {
        if ((descricao??'').isNotEmpty) 'descricao': descricao,
        "empresa":Singleton().usuario?.empresa?.id
      };
      guardasVoulme = await _guardasVolumeRepository.getAll(filters: filters);
    } catch(e){
      print(e);
    }
    return guardasVoulme;
  }

  @action
  Future createGuardaVolume(BuildContext context) async{
    isAltering = true;
    try{
      print(jsonEncode(_buildGuardaVolume().toJson()));
      await _guardasVolumeRepository.create(_buildGuardaVolume().toJson());
      CustomSnackBar.success(context, "Cadastrado com sucesso");
    } catch(e){
      print(e);
      CustomSnackBar.error(context, "Erro ao cadastrar");
    }
    await getGuardasVolumes();
    isAltering = false;
  }

  @action
  Future updateGuardaVolume(BuildContext context) async{
    isAltering = true;
    try{
      print(jsonEncode(_buildGuardaVolume(guardaVolume:guardaVolumeSelected).toJson()));
      await _guardasVolumeRepository.update(guardaVolumeSelected?.id,_buildGuardaVolume(guardaVolume:guardaVolumeSelected).toJson());
      CustomSnackBar.success(context, "Atualizado com sucesso");
    } catch(e){
      print(e);
      CustomSnackBar.error(context, "Erro ao atualizar");
    }
    await getGuardasVolumes();
    isAltering = false;
  }

  @action
  Future deleteGuardaVolume(BuildContext context, GuardaVolume guardaVolume) async{
    isDeleting = true;
    try{
      await _guardasVolumeRepository.delete(guardaVolume.id);
      CustomSnackBar.success(context, "Removido com sucesso");
    } catch(e){
      print(e);
      CustomSnackBar.error(context, "Erro ao remover");
    }
    await getGuardasVolumes();
    isDeleting = false;
  }

  GuardaVolume _buildGuardaVolume({GuardaVolume? guardaVolume}){
    GuardaVolume criancaTmp = GuardaVolume(
      id: guardaVolume?.id,
      descricao: tecNome.text,
      utilizado: false,
      ativo: radioAtivo == 0,
      empresa: Singleton().usuario?.empresa?.id
    );
    return criancaTmp;
  }

  @action
  void setGuardaVolume({GuardaVolume? guardaVolume}){
    guardaVolumeSelected = guardaVolume;
    if(guardaVolume != null){
      tecNome.text = guardaVolume.descricao??'';
      tecCodigo.text = guardaVolume.id.toString();
      setRadioAtivo(guardaVolume.ativo == true ? 0 : 1);
    } else {
      clearAll();
    }
  }

  @action
  void clearAll(){
    tecNome.text = '';
    tecCodigo.text = '';
    setRadioAtivo(0);
  }

  @action
  setRadioAtivo(int value) => radioAtivo = value;
}
