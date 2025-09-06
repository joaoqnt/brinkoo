import 'package:brinquedoteca_flutter/model/centro_custo.dart';
import 'package:brinquedoteca_flutter/model/empresa.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'empresa_list_controller.g.dart';

class EmpresaListController = _EmpresaListController with _$EmpresaListController;

abstract class _EmpresaListController with Store {
  final _empresasRepository = GenericRepository(
    endpoint: "empresas",
    fromJson:(p0) => Empresa.fromJson(p0),
  );
  TextEditingController tecPesquisa = TextEditingController();
  @observable
  bool isLoading = false;
  @observable
  List<Empresa> empresas = ObservableList.of([]);

  Future<List<Empresa>> getEmpresas() async{
    try{
      empresas = await _empresasRepository.getAll();
    } catch(e){
      print(e);
    }
    return empresas;
  }
}
