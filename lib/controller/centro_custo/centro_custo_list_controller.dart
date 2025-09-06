import 'package:brinquedoteca_flutter/model/centro_custo.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'centro_custo_list_controller.g.dart';

class CentroCustoListController = _CentroCustoListController with _$CentroCustoListController;

abstract class _CentroCustoListController with Store {
  final _cencusRepository = GenericRepository(
      endpoint: "centros-custo",
      fromJson:(p0) => CentroCusto.fromJson(p0),
  );
  TextEditingController tecPesquisa = TextEditingController();
  @observable
  bool isLoading = false;
  @observable
  List<CentroCusto> centros = ObservableList.of([]);

  Future<List<CentroCusto>> getCentros() async{
    try{
      centros = await _cencusRepository.getAll();
    } catch(e){
      print(e);
    }
    return centros;
  }
}
