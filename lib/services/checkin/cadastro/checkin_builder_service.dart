import 'package:brinquedoteca_flutter/model/atividade.dart';
import 'package:brinquedoteca_flutter/model/checkin.dart';
import 'package:brinquedoteca_flutter/model/convenio/convenio.dart';
import 'package:brinquedoteca_flutter/model/crianca.dart';
import 'package:brinquedoteca_flutter/model/forma_pagamento.dart';
import 'package:brinquedoteca_flutter/model/guarda_volume.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';

class CheckinBuilderService {
  Checkin build({
    Checkin? checkin,
    DateTime? dataSaida,
    required bool isList,
    required Map<String, double>? valores,
    required Crianca? criancaSelected,
    required Responsavel? responsavelEntradaSelected,
    required Responsavel? responsavelSaidaSelected,
    required Convenio? convenioSelected,
    required GuardaVolume? guardaVolumeSelected,
    required List<Atividade> atividadesSelected,
    required List<FormaPagamento> formas,
    required List<Responsavel> responsaveisPossiveisCheckout,
    required int minutosDesejados,
    required String? valorLiquidoText,
    required double Function(String? value) parseCurrency,
    required String tenant,
    required bool hasCriancaImage,
    required bool hasResponsavelEntradaImage,
    required bool hasResponsavelSaidaImage,
  }) {
    if (isList && checkin == null) {
      throw Exception('Checkin não informado no checkout em lista');
    }

    if (isList && valores == null) {
      throw Exception('Valores do checkin ${checkin?.id} não foram calculados');
    }

    return Checkin(
      crianca: criancaSelected ?? checkin?.crianca,
      responsavelEntrada: responsavelEntradaSelected ?? checkin?.responsavelEntrada,
      dataEntrada: checkin?.dataEntrada ?? DateTime.now(),
      atividades: atividadesSelected,
      usuarioEntrada: checkin?.usuarioEntrada ?? Singleton.instance.usuario,
      usuarioSaida: dataSaida != null
          ? checkin?.usuarioSaida ?? Singleton.instance.usuario
          : checkin?.usuarioSaida,
      id: checkin?.id,
      convenio: convenioSelected,
      urlImageCrianca: checkin?.urlImageCrianca,
      urlImageResponsavelEntrada: checkin?.urlImageResponsavelEntrada,
      responsavelSaida: responsavelSaidaSelected,
      guardaVolume: guardaVolumeSelected,
      formaPagamento: formas,
      valorTotal: isList
          ? (valores?['valorLiquido'] ?? 0)
          : checkin == null
          ? null
          : checkin.dataSaida == null
          ? parseCurrency(valorLiquidoText)
          : checkin.valorTotal,
      valorBruto: isList ? (valores?['valorBruto'] ?? 0) : (checkin?.valorBruto ?? 0),
      desconto: isList ? (valores?['desconto'] ?? 0) : (checkin?.desconto ?? 0),
      descontoConvenio: isList
          ? (valores?['valorDescontoConvenio'] ?? 0)
          : (checkin?.descontoConvenio ?? 0),
      urlImageResponsavelSaida: checkin?.urlImageResponsavelSaida ??
          ((checkin == null || !hasResponsavelSaidaImage)
              ? null
              : 'https://brinkoo.com.br/images/$tenant/checkout_responsavel/'
              '${responsavelSaidaSelected?.id}_${checkin.id}.png'),
      useUrlImageCrianca: checkin?.useUrlImageCrianca ??
          ((checkin == null || !hasCriancaImage) ? false : true),
      useUrlImageResponsavelSaida: checkin?.useUrlImageResponsavelSaida ??
          ((checkin == null || !hasResponsavelSaidaImage) ? false : true),
      useUrlImageResponsavelEntrada: checkin?.useUrlImageResponsavelEntrada ??
          ((checkin == null || !hasResponsavelEntradaImage) ? false : true),
      dataSaida: checkin?.dataSaida ?? dataSaida,
      responsaveisPossiveisCheckout: responsaveisPossiveisCheckout,
      minutosDesejados: minutosDesejados,
      empresa: Singleton.instance.usuario?.empresa,
    );
  }
}