import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/model/checkin.dart';
import 'package:brinquedoteca_flutter/model/convenio/convenio.dart';
import 'package:brinquedoteca_flutter/model/forma_pagamento.dart';
import 'package:brinquedoteca_flutter/model/parametro.dart';

class CheckinValueService {
  double getValorBrutoCheckin({
    required Checkin checkin,
    required Parametro? parametro,
  }) {
    final now = DateTime.now();
    final pricePerMinute = parametro?.valorMinutoVisita ?? 1;

    if (checkin.valorTotal == null) {
      final startedAt = checkin.dataEntrada;
      if (startedAt == null) return 0;

      final minutes = now.difference(startedAt).inMinutes;
      return minutes * pricePerMinute;
    }

    return checkin.valorBruto ?? checkin.valorTotal ?? 0;
  }

  double getValorBrutoTotalCheckins({
    required List<Checkin> checkins,
    required Parametro? parametro,
    required Map<Checkin, Map<String, double>> valoresPorCheckin,
  }) {
    double total = 0;

    for (final checkin in checkins) {
      final valorBruto = getValorBrutoCheckin(
        checkin: checkin,
        parametro: parametro,
      );

      total += valorBruto;

      valoresPorCheckin[checkin] = {
        ...?valoresPorCheckin[checkin],
        'valorBruto': valorBruto,
      };
    }

    return total;
  }

  double parseCurrency(String? value) {
    try {
      if (value == null || value.isEmpty) return 0;
      return UtilBrasilFields.converterMoedaParaDouble(value);
    } catch (_) {
      return 0;
    }
  }

  String formatCurrency(double value) {
    return UtilBrasilFields.obterReal(value);
  }

  double getLiquidValue({
    required double grossValue,
    required double convenioDiscount,
    required double manualDiscount,
  }) {
    final value = grossValue - convenioDiscount - manualDiscount;
    return value < 0 ? 0 : value;
  }

  double getDefaultPaymentValue({
    required List<FormaPagamento> formas,
    required String valorLiquidoText,
    required double valorRestante,
  }) {
    if (formas.isEmpty) {
      return parseCurrency(valorLiquidoText);
    }

    return valorRestante;
  }

  double getRemainingValue({
    required List<FormaPagamento> formas,
    required String valorLiquidoText,
  }) {
    final totalPaid = formas.fold<double>(
      0,
          (sum, forma) => sum + (forma.valor ?? 0),
    );

    final liquidValue = parseCurrency(valorLiquidoText);

    final remainingValue = liquidValue - totalPaid;

    return remainingValue < 0 ? 0 : remainingValue;
  }
}