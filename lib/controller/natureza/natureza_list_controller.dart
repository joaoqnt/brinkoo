import 'package:brinquedoteca_flutter/model/natureza.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'natureza_list_controller.g.dart';

class NaturezaListController = _NaturezaListController with _$NaturezaListController;

abstract class _NaturezaListController with Store {
  final _naturezaRepository = GenericRepository(
      endpoint: "naturezas",
      fromJson:(p0) => Natureza.fromJson(p0),
  );
  TextEditingController tecPesquisa = TextEditingController();
  @observable
  bool isLoading = false;
  @observable
  List<Natureza> naturezas = ObservableList.of([]);

  Future<List<Natureza>> getNaturezas() async{
    try{
      naturezas = await _naturezaRepository.getAll();
    } catch(e){
      print(e);
    }
    return naturezas;
  }
}
