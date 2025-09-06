import 'package:brinquedoteca_flutter/model/financeiro.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'financeiro_list_controller.g.dart';

class FinanceiroListController = _FinanceiroListController with _$FinanceiroListController;

abstract class _FinanceiroListController with Store {
  final _financeiroRepository = GenericRepository(
      endpoint: "financeiro",
      fromJson:(p0) => Financeiro.fromJson(p0),
  );
  TextEditingController tecPesquisa = TextEditingController();
  @observable
  bool isLoading = false;
  @observable
  List<Financeiro> financeiros = ObservableList.of([]);

  Future<List<Financeiro>> getFinanceiros(String receitaDespesa) async{
    try{
      financeiros = await _financeiroRepository.getAll(filters: {'receita_despesa':receitaDespesa});
    } catch(e){
      print(e);
    }
    return financeiros;
  }
}
