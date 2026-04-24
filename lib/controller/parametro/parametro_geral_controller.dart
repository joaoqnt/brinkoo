import 'dart:convert';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/model/centro_custo.dart';
import 'package:brinquedoteca_flutter/model/empresa.dart';
import 'package:brinquedoteca_flutter/model/forma_pagamento.dart';
import 'package:brinquedoteca_flutter/model/parametro.dart';
import 'package:brinquedoteca_flutter/model/servico_nfse.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'parametro_geral_controller.g.dart';

class ParametroGeralController = _ParametroGeralController with _$ParametroGeralController;

abstract class _ParametroGeralController with Store {
  final _parametroRepository = GenericRepository(
    endpoint: "empresas",
    fromJson: (json) => Empresa.fromJson(json),
  );

  final formKeyParametro = GlobalKey<FormState>();

  // TextEditingControllers
  TextEditingController tecTolerancia = TextEditingController();
  TextEditingController tecMinutosMinimo = TextEditingController();
  TextEditingController tecMinutosMaximo = TextEditingController();
  TextEditingController tecValorHoraGuardaVolume = TextEditingController();
  TextEditingController tecValorMinutoVisita = TextEditingController();
  TextEditingController tecPercMinFildelidade = TextEditingController();
  TextEditingController tecNatOp = TextEditingController();
  TextEditingController tecCfop = TextEditingController();
  TextEditingController tecSerie = TextEditingController();

  @observable
  bool isLoading = false;

  @observable
  Parametro? parametroSelected;

  @observable
  Empresa? empresaSelected;

  ServicoNfse? servicoNfseSelected;
  FormaPagamento? formaPagamentoSelected;
  CentroCusto? centroCustoCheckinSelected;
  CentroCusto? centroCustoEventoSelected;

  @action
  Future<void> carregarParametro() async {
    isLoading = true;
    try {
      final response = await _parametroRepository.getAll();
      setEmpresa(response.firstOrNull);
    } catch (e) {
      print("Erro ao carregar parâmetro: $e");
    }
    isLoading = false;
  }

  @action
  setEmpresa(Empresa? empresa) {
    empresaSelected = empresa;
    parametroSelected = empresa?.parametro;
    try{
      _preencherCampos(parametroSelected!);
    } catch(e){

    }
  }

  @action
  Future<void> salvarParametro(BuildContext context) async {
    isLoading = true;
    try {
      final parametro = _buildParametro();
      if (parametroSelected == null) {
        await _parametroRepository.create(parametro.toJson());
        CustomSnackBar.success(context, "Parâmetro criado com sucesso");
      } else {
        print(jsonEncode(parametro.toJson()));
        await _parametroRepository.update('', parametro.toJson()); // update sem ID
        CustomSnackBar.success(context, "Parâmetro atualizado com sucesso");
      }
      parametroSelected = parametro;
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
      percMinFidelidade: UtilBrasilFields.converterMoedaParaDouble(tecPercMinFildelidade.text),
      centroCustoCheckin: centroCustoCheckinSelected,
      centroCustoEvento: centroCustoEventoSelected,
      servicoNfse: servicoNfseSelected,
      empresa: empresaSelected?.id,
      formaPagamento: formaPagamentoSelected,
      natOp: tecNatOp.text,
      cfop: tecCfop.text,
      serie: tecSerie.text,

    );
  }

  void _preencherCampos(Parametro parametro) {
    tecTolerancia.text = parametro.tolerancia?.toString() ?? '';
    tecMinutosMinimo.text = parametro.minutosMinimo?.toString() ?? '';
    tecMinutosMaximo.text = parametro.minutosMaximo?.toString() ?? '';
    tecSerie.text = parametro.serie??'';
    tecNatOp.text = parametro.natOp??'';
    tecCfop.text = parametro.cfop??'';
    tecValorHoraGuardaVolume.text = UtilBrasilFields.obterReal(parametro.valorHoraGuardaVolume!);
    tecValorMinutoVisita.text = UtilBrasilFields.obterReal(parametro.valorMinutoVisita!);
    tecValorMinutoVisita.text = UtilBrasilFields.obterReal(parametro.valorMinutoVisita!);
    tecPercMinFildelidade.text = UtilBrasilFields.obterReal(parametro.percMinFidelidade!,moeda: false);
    setServicoNfse(parametro.servicoNfse);
    setFormaPagamento(parametro.formaPagamento);
    setCentroCustoCheckin(parametro.centroCustoCheckin);
    setCentroCustoEvento(parametro.centroCustoEvento);
  }

  void setServicoNfse(ServicoNfse? servico) => servicoNfseSelected = servico;

  void setFormaPagamento(FormaPagamento? formaPagamento) => formaPagamentoSelected = formaPagamento;

  void setCentroCustoCheckin(CentroCusto? centroCusto) => centroCustoCheckinSelected = centroCusto;

  void setCentroCustoEvento(CentroCusto? centroCusto) => centroCustoEventoSelected = centroCusto;
}
