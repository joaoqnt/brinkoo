import 'package:brinquedoteca_flutter/model/atividade.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'atividade_list_controller.g.dart';

class AtividadeListController = _AtividadeListController with _$AtividadeListController;

abstract class _AtividadeListController with Store {
  final _atividadeRepository = GenericRepository(
      endpoint: "atividades",
      fromJson:(p0) => Atividade.fromJson(p0),
  );
  TextEditingController tecPesquisa = TextEditingController();
  @observable
  bool isLoading = false;
  @observable
  List<Atividade> atividades = ObservableList.of([]);

  Future<List<Atividade>> getAtividades() async{
    try{
      atividades = await _atividadeRepository.getAll();
    } catch(e){
      print(e);
    }
    return atividades;
  }
}
