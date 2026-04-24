import 'dart:convert';
import 'package:brinquedoteca_flutter/component/custom/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/model/centro_custo.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'cadastro_centro_custo_controller.g.dart';

class CadastroCentroCustoController = _CadastroCentroCustoController with _$CadastroCentroCustoController;

abstract class _CadastroCentroCustoController with Store {
  TextEditingController tecNomeCenCus = TextEditingController();
  TextEditingController tecCodigoCenCus = TextEditingController();
  TextEditingController tecPesquisa = TextEditingController();
  final formKeyCenCus = GlobalKey<FormState>();
  final _cencusRepository = GenericRepository(
      endpoint: "centros-custo",
      fromJson:(p0) => CentroCusto.fromJson(p0),
  );
  @observable
  bool isLoading = false;
  @observable
  bool isAltering = false;
  @observable
  bool isDeleting = false;
  @observable
  List<CentroCusto> centros = ObservableList.of([]);
  CentroCusto? centroCustoSelected;

  Future<List<CentroCusto>> getCentros() async{
    try{
      centros = await _cencusRepository.getAll();
    } catch(e){
      print(e);
    }
    return centros;
  }

  @action
  Future createCenCus(BuildContext context) async{
    isAltering = true;
    try{
      print(jsonEncode(_buildCenCus().toJson()));
      await _cencusRepository.create(_buildCenCus().toJson());
      CustomSnackBar.success(context, "Cadastrado com sucesso");
    } catch(e){
      print(e);
      CustomSnackBar.error(context, "Erro ao cadastrar");
    }
    await getCentros();
    isAltering = false;
  }

  @action
  Future updateCenCus(BuildContext context) async{
    isAltering = true;
    try{
      print(jsonEncode(_buildCenCus(cencus:centroCustoSelected).toJson()));
      await _cencusRepository.update(centroCustoSelected?.id,_buildCenCus(cencus:centroCustoSelected).toJson());
      CustomSnackBar.success(context, "Atualizado com sucesso");
    } catch(e){
      print(e);
      CustomSnackBar.error(context, "Erro ao atualizar");
    }
    await getCentros();
    isAltering = false;
  }

  @action
  Future deleteCenCus(BuildContext context,CentroCusto centroCusto) async{
    isAltering = true;
    try{
      await _cencusRepository.delete(centroCusto.id);
      CustomSnackBar.success(context, "Removido com sucesso");
    } catch(e){
      print(e);
      CustomSnackBar.error(context, "Erro ao remover");
    }
    await getCentros();
    isAltering = false;
  }

  CentroCusto _buildCenCus({CentroCusto? cencus}){
    CentroCusto criancaTmp = CentroCusto(
      id: cencus?.id,
      descricao: tecNomeCenCus.text,
    );
    return criancaTmp;
  }

  @action
  void setCenCus({CentroCusto? cencus}){
    centroCustoSelected = cencus;
    if(cencus != null){
      tecNomeCenCus.text = cencus.descricao??'';
      tecCodigoCenCus.text = cencus.id.toString();
    } else {
      clearAll();
    }
  }

  void clearAll(){
    tecNomeCenCus.text = '';
    tecCodigoCenCus.text = '';
  }
}
