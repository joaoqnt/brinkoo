import 'dart:convert';
import 'package:brinquedoteca_flutter/component/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/model/centro_custo.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'cadastro_centro_custo_controller.g.dart';

class CadastroCentroCustoController = _CadastroCentroCustoController with _$CadastroCentroCustoController;

abstract class _CadastroCentroCustoController with Store {
  TextEditingController tecNomeCenCus = TextEditingController();
  TextEditingController tecCodigoCenCus = TextEditingController();
  final formKeyCenCus = GlobalKey<FormState>();
  final _cencusRepository = GenericRepository(
      endpoint: "centros-custo",
      fromJson:(p0) => CentroCusto.fromJson(p0),
  );
  @observable
  bool isLoading = false;


  @action
  Future createCenCus(BuildContext context) async{
    isLoading = true;
    try{
      print(jsonEncode(_buildCenCus().toJson()));
      await _cencusRepository.create(_buildCenCus().toJson());
      CustomSnackBar.success(context, "Cadastrado com sucesso");
    } catch(e){
      print(e);
      CustomSnackBar.error(context, "Erro ao cadastrar");
    }
    isLoading = false;
  }

  @action
  Future updateCenCus(BuildContext context, CentroCusto atividade) async{
    isLoading = true;
    try{
      print(jsonEncode(_buildCenCus(cencus:atividade).toJson()));
      await _cencusRepository.update(atividade.id,_buildCenCus(cencus:atividade).toJson());
      CustomSnackBar.success(context, "Atualizado com sucesso");
    } catch(e){
      print(e);
      CustomSnackBar.error(context, "Erro ao atualizar");
    }
    isLoading = false;
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
    if(cencus != null){
      tecNomeCenCus.text = cencus.descricao??'';
      tecCodigoCenCus.text = cencus.id.toString();
    }
  }
}
