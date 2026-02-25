import 'package:brinquedoteca_flutter/model/parceiro.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'parceiro_list_controller.g.dart';

class ParceiroListController = _ParceiroListController with _$ParceiroListController;

abstract class _ParceiroListController with Store {
  final _parceiroRepository = GenericRepository(
      endpoint: "parceiros",
      fromJson:(p0) => Parceiro.fromJson(p0),
  );
  TextEditingController tecPesquisa = TextEditingController();
  @observable
  bool isLoading = false;
  @observable
  List<Parceiro> parceiros = ObservableList.of([]);
  @observable
  bool hasMore = true;
  int _offset = 0;
  final int _limit = 50;

  @action
  Future<List<Parceiro>> getParceiros({bool reset = false}) async {
    isLoading = true;

    if (reset) {
      _offset = 0;
      hasMore = true;
      parceiros.clear();
    }

    try {
      if (!hasMore) {
        isLoading = false;
        return parceiros;
      }

      Map<String, dynamic> filters = {
        'limit': _limit,
        'offset': _offset,
      };
      if (tecPesquisa.text.isNotEmpty) {
        filters['nome'] = tecPesquisa.text;
      }

      final novosParceiros = await _parceiroRepository.getAll(filters: filters);

      if (novosParceiros.isEmpty || novosParceiros.length < _limit) {
        hasMore = false; // não tem mais páginas
      }

      // Se for reset, já limpou antes; se não, adiciona
      parceiros.addAll(novosParceiros);

      _offset += _limit;

    } catch (e) {
      print(e);
    }

    isLoading = false;
    return parceiros;
  }

}
