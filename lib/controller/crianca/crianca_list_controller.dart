import 'dart:convert';
import 'dart:typed_data';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/model/crianca.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:brinquedoteca_flutter/utils/date_helper_util.dart';
import 'package:brinquedoteca_flutter/utils/utils.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'crianca_list_controller.g.dart';

class CriancaListController = _CriancaListController with _$CriancaListController;

abstract class _CriancaListController with Store {
  final _criancaRepository = GenericRepository(
    endpoint: "criancas",
    fromJson: (p0) => Crianca.fromJson(p0),
  );

  TextEditingController tecPesquisa = TextEditingController();

  @observable
  bool isLoading = false;

  @observable
  bool isDeleting = false;

  @observable
  bool hasMore = true; // controla se ainda tem mais registros

  @observable
  List<Crianca> criancas = ObservableList.of([]);

  final Map<String, Map<String, TextEditingController>> filtersConfig = {
    "Nome da Criança": {
      "unaccent(LOWER(c.nome))": TextEditingController()
    },
    "Responsável": {
      "unaccent(LOWER(rf.nome))": TextEditingController()
    }
  };

  int _offset = 0;
  final int _limit = 50;

  @action
  Future<void> getCriancas({bool reset = false}) async {
    try {
      if (isLoading) return;
      isLoading = true;

      if (reset) {
        _offset = 0;
        hasMore = true;
        criancas.clear();
      }

      if (!hasMore) return;

      Map<String, dynamic> filters = {
        'limit': _limit,
        'offset': _offset,
      };

      // Filtro principal de pesquisa
      if (tecPesquisa.text.isNotEmpty) {
        filters['unaccent(LOWER(c.nome))'] =
            Utils.removerAcentosEMinusculo(tecPesquisa.text);
      }

      // 🔥 Aqui adiciona dinamicamente os filtros do dialog
      filtersConfig.forEach((label, mapInterno) {
        mapInterno.forEach((campo, controller) {
          if (controller.text.isNotEmpty) {
            filters[campo] =
                Utils.removerAcentosEMinusculo(controller.text);
          }
        });
      });

      final novaLista = await _criancaRepository.getAll(
        filters: filters,
      );

      if (novaLista.isEmpty || novaLista.length < _limit) {
        hasMore = false;
      }

      criancas.addAll(novaLista);
      _offset += _limit;

    } catch (e) {
      print("Erro ao carregar crianças: $e");
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> resetarFiltros() async {
    // Limpa campo de pesquisa principal
    tecPesquisa.clear();

    // Limpa todos os filtros do dialog
    filtersConfig.forEach((_, mapInterno) {
      mapInterno.forEach((_, controller) {
        controller.clear();
      });
    });

    // Recarrega lista do zero
    await getCriancas(reset: true);
  }

  @action
  Future<void> deleteCrianca(BuildContext context, Crianca crianca) async{
    isDeleting = true;
    try{
      await _criancaRepository.delete(crianca.id);
      await getCriancas(reset: true);
      CustomSnackBar.success(context, "Removido com sucesso");
    } catch(e){
      print(e);
      CustomSnackBar.error(context, "Erro ao remover.\nSe a criança já tiver alguma movimentação, favor apenas inativar o cadastro.");
    }
    isDeleting = false;
  }
}
