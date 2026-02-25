import 'dart:convert';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/model/parametro.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'parametro_geral_controller.g.dart';

class ParametroGeralController = _ParametroGeralController with _$ParametroGeralController;

abstract class _ParametroGeralController with Store {
  final _parametroRepository = GenericRepository(
    endpoint: "parametro_geral",
    fromJson: (json) => Parametro.fromJson(json),
  );

  final formKeyParametro = GlobalKey<FormState>();

  // TextEditingControllers
  TextEditingController tecTolerancia = TextEditingController();
  TextEditingController tecMinutosMinimo = TextEditingController();
  TextEditingController tecMinutosMaximo = TextEditingController();
  TextEditingController tecValorHoraGuardaVolume = TextEditingController();
  TextEditingController tecValorMinutoVisita = TextEditingController();

  @observable
  bool isLoading = false;

  @observable
  Parametro? parametroAtual;

  @action
  Future<void> carregarParametro() async {
    isLoading = true;
    try {
      final response = await _parametroRepository.get();
      parametroAtual = response;
      preencherCampos(parametroAtual!);
    } catch (e) {
      print("Erro ao carregar parâmetro: $e");
    }
    isLoading = false;
  }

  @action
  Future<void> salvarParametro(BuildContext context) async {
    isLoading = true;
    try {
      final parametro = _buildParametro();
      if (parametroAtual == null) {
        await _parametroRepository.create(parametro.toJson());
        CustomSnackBar.success(context, "Parâmetro criado com sucesso");
      } else {
        print(jsonEncode(parametro.toJson()));
        await _parametroRepository.update('', parametro.toJson()); // update sem ID
        CustomSnackBar.success(context, "Parâmetro atualizado com sucesso");
      }
      parametroAtual = parametro;
    } catch (e) {
      print("Erro ao salvar parâmetro: $e");
      CustomSnackBar.error(context, "Erro ao salvar parâmetro");
    }
    isLoading = false;
  }

  Parametro _buildParametro() {
    return Parametro(
      tolerancia: int.tryParse(tecTolerancia.text),
      minutosMinimo: int.tryParse(tecMinutosMinimo.text),
      minutosMaximo: int.tryParse(tecMinutosMaximo.text),
      valorHoraGuardaVolume: UtilBrasilFields.converterMoedaParaDouble(tecValorHoraGuardaVolume.text),
      valorMinutoVisita: UtilBrasilFields.converterMoedaParaDouble(tecValorMinutoVisita.text),
    );
  }

  void preencherCampos(Parametro parametro) {
    tecTolerancia.text = parametro.tolerancia?.toString() ?? '';
    tecMinutosMinimo.text = parametro.minutosMinimo?.toString() ?? '';
    tecMinutosMaximo.text = parametro.minutosMaximo?.toString() ?? '';
    tecValorHoraGuardaVolume.text = UtilBrasilFields.obterReal(parametro.valorHoraGuardaVolume!);
    tecValorMinutoVisita.text = UtilBrasilFields.obterReal(parametro.valorMinutoVisita!);
  }
}
