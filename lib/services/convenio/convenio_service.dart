import 'package:brinquedoteca_flutter/model/checkin.dart';
import 'package:brinquedoteca_flutter/model/convenio/convenio.dart';

class ConvenioService {
  double? calcularDescontoConvenioCheckin({
    required Checkin checkin,
    required double valorBase,
    required Convenio convenio,
  }) {
    if (checkin.dataSaida != null) {
      return checkin.descontoConvenio;
    }

    final dias = convenio.convenioDias;
    if (dias == null || dias.isEmpty) return null;

    final diaSemana = checkin.dataEntrada?.weekday;
    if (diaSemana == null) return null;

    // tenta pegar dia válido específico
    final diasValidos = dias.where(
          (e) =>
      e.dia == diaSemana &&
          ((e.percConvenio ?? 0) != 0 || (e.percEmpresa ?? 0) != 0),
    );

    // fallback: dia == 0
    final fallback = dias.firstWhere(
          (e) => e.dia == 0,
      orElse: () => dias.first,
    );

    final diaValido = diasValidos.isNotEmpty
        ? diasValidos.first
        : fallback;

    final percentual =
        (diaValido.percConvenio ?? 0) + (diaValido.percEmpresa ?? 0);

    if (percentual == 0) return null;

    return valorBase * (percentual / 100);
  }

  double calcularDescontoConvenioTotalCheckins({
    required List<Checkin> checkins,
    required Convenio convenio,
    required double Function(Checkin checkin) getValorBase,
    required Map<Checkin, Map<String, double>> valoresPorCheckin,
  }) {
    double totalDesconto = 0;

    for (final checkin in checkins) {
      final valorBase = getValorBase(checkin);

      final desconto = calcularDescontoConvenioCheckin(
        checkin: checkin,
        valorBase: valorBase,
        convenio: convenio,
      ) ?? 0;

      totalDesconto += desconto;

      valoresPorCheckin[checkin] = {
        ...?valoresPorCheckin[checkin],
        'valorBruto': valorBase,
        'valorDescontoConvenio': desconto,
        'valorLiquido': valorBase - desconto,
      };
    }

    return totalDesconto;
  }
}