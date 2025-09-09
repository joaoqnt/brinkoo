import 'package:brinquedoteca_flutter/model/convenio.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'convenio_list_controller.g.dart';

class ConvenioListController = _ConvenioListController with _$ConvenioListController;

abstract class _ConvenioListController with Store {
  final _convenioRepository = GenericRepository(
      endpoint: "convenios",
      fromJson:(p0) => Convenio.fromJson(p0),
  );
  TextEditingController tecPesquisa = TextEditingController();
  @observable
  bool isLoading = false;
  @observable
  List<Convenio> convenios = ObservableList.of([]);

  Future<List<Convenio>> getConvenios() async{
    try{
      convenios = await _convenioRepository.getAll();
    } catch(e){
      print(e);
    }
    return convenios;
  }
}
