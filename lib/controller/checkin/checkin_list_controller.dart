import 'dart:convert';
import 'dart:typed_data';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/model/checkin.dart';
import 'package:brinquedoteca_flutter/model/crianca.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:brinquedoteca_flutter/utils/date_helper_util.dart';
import 'package:camera/camera.dart';
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
        },
      );

      checkins.addAll(novosCheckins);
      page++;
    } catch (e) {
      print("Erro ao carregar checkins: $e");
    } finally {
      isLoading = false;
    }
  }

  /// Busca apenas checkins em aberto (sem saída)
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
        },
      );

      checkins.addAll(novosCheckins);
      page++;
    } catch (e) {
      print("Erro ao carregar checkins abertos: $e");
    }
    return checkins;
  }
}
