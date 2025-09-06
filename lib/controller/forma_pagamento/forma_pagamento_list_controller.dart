import 'package:brinquedoteca_flutter/model/forma_pagamento.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'forma_pagamento_list_controller.g.dart';

class FormaPagamentoListController = _FormaPagamentoListController with _$FormaPagamentoListController;

abstract class _FormaPagamentoListController with Store {
  final _formaPagamentoRepository = GenericRepository(
    endpoint: "forma_pagamento",
    fromJson: (p0) => FormaPagamento.fromJson(p0),
  );

  TextEditingController tecPesquisa = TextEditingController();

  @observable
  bool isLoading = false;

  @observable
  List<FormaPagamento> formasPagamento = ObservableList.of([]);

  @action
  Future<List<FormaPagamento>> getFormasPagamento() async {
    isLoading = true;
    try {
      formasPagamento = await _formaPagamentoRepository.getAll();
    } catch (e) {
      print(e);
    }
    isLoading = false;
    return formasPagamento;
  }
}
