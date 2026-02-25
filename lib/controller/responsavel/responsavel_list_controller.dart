import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'responsavel_list_controller.g.dart';

class ResponsavelListController = _ResponsavelListController with _$ResponsavelListController;

abstract class _ResponsavelListController with Store {
  final _responsavelRepository = GenericRepository(
      endpoint: "responsaveis",
      fromJson:(p0) => Responsavel.fromJson(p0),
  );
  TextEditingController tecPesquisa = TextEditingController();
  @observable
  bool isLoading = false;
  @observable
  List<Responsavel> responsaveis = ObservableList.of([]);

  @observable
  int page = 0;

  @action
  Future<void> getResponsaveis({bool refresh = false}) async {
    try {
      if (isLoading) return; // evita chamadas duplicadas
      isLoading = true;

      if (refresh) {
        page = 0;
        responsaveis.clear();
      }

      final novosResponsaveis = await _responsavelRepository.getAll(
        filters: {
          'limit': 50,
          'offset': page * 50,
          if (tecPesquisa.text.isNotEmpty) 'nome': tecPesquisa.text,
        },
      );

      responsaveis.addAll(novosResponsaveis);
      page++;
    } catch (e) {
      print("Erro ao carregar responsáveis: $e");
    } finally {
      isLoading = false;
    }
  }
}
