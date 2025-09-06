import 'package:brinquedoteca_flutter/model/atividade.dart';
import 'package:brinquedoteca_flutter/model/crianca.dart';
import 'package:brinquedoteca_flutter/model/forma_pagamento.dart';
import 'package:brinquedoteca_flutter/model/guarda_volume.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';

class Checkin {
  Crianca? crianca;
  String? cupomDesconto;
  DateTime? dataEntrada;
  DateTime? dataSaida;
  int? id;
  Responsavel? responsavelEntrada;
  Responsavel? responsavelSaida;
  GuardaVolume? guardaVolume;
  FormaPagamento? formaPagamento;
  double? valorTotal;
  String? urlImageCrianca;
  String? urlImageResponsavelEntrada;
  String? urlImageResponsavelSaida;
  List<Atividade>? atividades;
  List<Responsavel>? responsaveisPossiveisCheckout;
  bool? useUrlImageCrianca;
  bool? useUrlImageResponsavelEntrada;
  bool? useUrlImageResponsavelSaida;
  int? minutosDesejados;

  Checkin({
    this.crianca,
    this.cupomDesconto,
    this.dataEntrada,
    this.dataSaida,
    this.id,
    this.responsavelEntrada,
    this.responsavelSaida,
    this.atividades,
    this.valorTotal,
    this.guardaVolume,
    this.formaPagamento,
    this.urlImageCrianca,
    this.urlImageResponsavelEntrada,
    this.urlImageResponsavelSaida,
    this.useUrlImageCrianca,
    this.useUrlImageResponsavelEntrada,
    this.useUrlImageResponsavelSaida,
    this.responsaveisPossiveisCheckout,
    this.minutosDesejados,
  });

  Checkin.fromJson(Map<String, dynamic> json) {
    try {
      crianca = json['crianca'] != null
          ? Crianca.fromJson(json['crianca'])
          : null;
    } catch (e) {
      crianca = null;
    }

    cupomDesconto = json['cupom_desconto'];

    try {
      dataEntrada = DateTime.tryParse(json['data_entrada']);
    } catch (e) {
      dataEntrada = null;
    }

    try {
      dataSaida = DateTime.tryParse(json['data_saida']);
    } catch (e) {
      dataSaida = null;
    }

    try {
      if (json['atividades'] != null) {
        atividades = <Atividade>[];
        json['atividades'].forEach((v) {
          try {
            atividades!.add(Atividade.fromJson(v));
          } catch (e) {}
        });
      }
    } catch (e) {
      atividades = null;
    }

    try {
      if (json['responsaveis_possiveis_checkout'] != null) {
        responsaveisPossiveisCheckout = <Responsavel>[];
        json['responsaveis_possiveis_checkout'].forEach((v) {
          try {
            responsaveisPossiveisCheckout!.add(Responsavel.fromJson(v));
          } catch (e) {}
        });
      }
    } catch (e) {
      responsaveisPossiveisCheckout = null;
    }

    id = json['id'];
    urlImageCrianca = json['url_image_crianca'];
    useUrlImageCrianca = json['use_url_image_crianca'];
    useUrlImageResponsavelEntrada = json['use_url_image_responsavel_entrada'];
    useUrlImageResponsavelSaida = json['use_url_image_responsavel_saida'];
    urlImageResponsavelEntrada = json['url_image_responsavel_entrada'];
    urlImageResponsavelSaida = json['url_image_responsavel_saida'];

    try {
      responsavelEntrada = json['responsavel_entrada'] != null
          ? Responsavel.fromJson(json['responsavel_entrada'])
          : null;
    } catch (e) {
      responsavelEntrada = null;
    }

    try {
      responsavelSaida = json['responsavel_saida'] != null
          ? Responsavel.fromJson(json['responsavel_saida'])
          : null;
    } catch (e) {
      responsavelSaida = null;
    }

    try {
      valorTotal = double.tryParse(json['valor_total'] ?? '');
    } catch (e) {
      valorTotal = null;
    }

    minutosDesejados = json['minutos_desejados'];

    try {
      guardaVolume = json['guarda_volume'] != null
          ? GuardaVolume.fromJson(json['guarda_volume'])
          : null;
    } catch (e) {
      guardaVolume = null;
    }

    try {
      formaPagamento = json['forma_pagamento'] != null
          ? FormaPagamento.fromJson(json['forma_pagamento'])
          : null;
    } catch (e) {
      formaPagamento = null;
    }
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.crianca != null) {
      data['crianca'] = this.crianca!.id;
    }
    if (this.guardaVolume != null) {
      data['guarda_volume'] = this.guardaVolume!.id;
    }
    if (this.formaPagamento != null) {
      data['forma_pagamento'] = this.formaPagamento!.id;
    }
    data['cupom_desconto'] = this.cupomDesconto;
    data['data_entrada'] = this.dataEntrada?.toIso8601String();
    data['data_saida'] = this.dataSaida?.toIso8601String();
    data['id'] = this.id;
    if (this.responsavelEntrada != null) {
      data['responsavel_entrada'] = this.responsavelEntrada!.id;
    }
    if (this.atividades != null) {
      data['atividades'] = this.atividades!.map((v) => v.toJson()).toList();
    }
    if (this.responsaveisPossiveisCheckout != null) {
      data['responsaveis_possiveis_checkout'] = this.responsaveisPossiveisCheckout!.map((v) => v.toJson()).toList();
    }
    data['responsavel_saida'] = this.responsavelSaida?.id;
    data['valor_total'] = this.valorTotal;
    data['use_url_image_crianca'] = this.useUrlImageCrianca;
    data['use_url_image_responsavel_entrada'] = this.useUrlImageResponsavelEntrada;
    data['use_url_image_responsavel_saida'] = this.useUrlImageResponsavelSaida;
    data['url_image_crianca'] = this.urlImageCrianca;
    data['url_image_responsavel_entrada'] = this.urlImageResponsavelEntrada;
    data['url_image_responsavel_saida'] = this.urlImageResponsavelSaida;
    data['minutos_desejados'] = this.minutosDesejados;
    return data;
  }
}
