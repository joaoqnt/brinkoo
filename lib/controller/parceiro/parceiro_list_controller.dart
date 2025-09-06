import 'package:brinquedoteca_flutter/model/parceiro.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'parceiro_list_controller.g.dart';

class ParceiroListController = _ParceiroListController with _$ParceiroListController;

abstract class _ParceiroListController with Store {
  final _naturezaRepository = GenericRepository(
      endpoint: "parceiros",
      fromJson:(p0) => Parceiro.fromJson(p0),
  );
  TextEditingController tecPesquisa = TextEditingController();
  @observable
  bool isLoading = false;
  @observable
  List<Parceiro> parceiros = ObservableList.of([]);

  Future<List<Parceiro>> getParceiros() async{
    try{
      parceiros = await _naturezaRepository.getAll();
    } catch(e){
      print(e);
    }
    return parceiros;
  }
}
