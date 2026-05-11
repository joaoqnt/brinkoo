import 'package:brinquedoteca_flutter/model/checkin.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'checkin_list_controller.g.dart';

class CheckinListController = _CheckinListController with _$CheckinListController;

abstract class _CheckinListController with Store {
  final _checkinRepository = GenericRepository(
    endpoint: "checkins",
    fromJson: (p0) => Checkin.fromJson(p0),
  );

  TextEditingController tecPesquisa = TextEditingController();

  @observable
  bool isLoading = false;

  @observable
  List<Checkin> checkins = ObservableList.of([]);

  @observable
  int page = 0;

  @observable
  Map<Checkin,bool> isSelected = ObservableMap.of({});

  final int limit = 20;

  /// Carrega os checkins (com paginação e filtro)
  @action
  Future<void> getCheckins({bool refresh = false}) async {
    if (isLoading) return;
    isLoading = true;

    try {
      if (refresh) {
        page = 0;
        checkins.clear();
      }

      final novosCheckins = await _checkinRepository.getAll(
        filters: {
          'limit': limit,
          'offset': page * limit,
          if (tecPesquisa.text.isNotEmpty)
            'unaccent(c.nome)': tecPesquisa.text,
          if(Singleton.instance.usuario?.empresa != null)
            'ch.empresa':Singleton.instance.usuario?.empresa?.id
        },
      );
      print(novosCheckins.length);
      checkins.addAll(novosCheckins);
      page++;
    } catch (e) {
      print("Erro ao carregar checkins: $e");
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<List<Checkin>> getCheckinsAberto({bool refresh = false}) async {
    try {
      if (refresh) {
        page = 0;
        checkins.clear();
      }

      final novosCheckins = await _checkinRepository.search(
        filters: {
          "ch.data_saida": null,
          'limit': limit,
          'offset': page * limit,
          if(Singleton.instance.usuario?.empresa != null)
            'ch.empresa':Singleton.instance.usuario?.empresa?.id
        },
      );

      checkins.addAll(novosCheckins);
      page++;
    } catch (e) {
      print("Erro ao carregar checkins abertos: $e");
    }
    return checkins;
  }

  @action
  setIsSelected(Checkin checkin, bool value) => isSelected[checkin] = value;

  @action
  bool hasAnySelected() {
    return isSelected.values.any((value) => value == true);
  }

  List<Checkin> getCheckinsSelected(){
    return isSelected.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList();
  }

  @action
  List<Responsavel> getCommonResponsaveis() {
    final selected = getCheckinsSelected();

    if (selected.isEmpty) return [];

    Set<int>? commonIds;
    Map<int, Responsavel> responsavelMap = {};

    for (final checkin in selected) {
      final responsaveis = checkin.responsaveisPossiveisCheckout;

      if (responsaveis == null || responsaveis.isEmpty) {
        return [];
      }

      final currentIds = responsaveis.map((r) => r.id!).toSet();

      // guarda referência pra poder retornar o objeto depois
      for (var r in responsaveis) {
        responsavelMap[r.id!] = r;
      }

      if (commonIds == null) {
        commonIds = currentIds;
      } else {
        commonIds = commonIds.intersection(currentIds);
      }

      if (commonIds.isEmpty) return [];
    }

    return commonIds!.map((id) => responsavelMap[id]!).toList();
  }
}
