import 'package:brinquedoteca_flutter/model/centro_custo.dart';
import 'package:brinquedoteca_flutter/model/forma_pagamento.dart';
import 'package:brinquedoteca_flutter/model/servico_nfse.dart';

class Parametro {
  String? cfop;
  int? empresa;
  int? finNfe;
  FormaPagamento? formaPagamento;
  Null? idDest;
  int? indFinal;
  int? indPres;
  int? minutosMaximo;
  int? minutosMinimo;
  Null? mod;
  String? natOp;
  double? percMinFidelidade;
  String? serie;
  int? tolerancia;
  int? tpEmis;
  int? tpImp;
  int? tpNf;
  double? valorHoraGuardaVolume;
  double? valorMinutoVisita;
  ServicoNfse? servicoNfse;
  CentroCusto? centroCustoCheckin;
  CentroCusto? centroCustoEvento;

  Parametro({
    this.centroCustoCheckin,
    this.centroCustoEvento,
    this.cfop,
    this.empresa,
    this.finNfe,
    this.formaPagamento,
    this.idDest,
    this.indFinal,
    this.indPres,
    this.minutosMaximo,
    this.minutosMinimo,
    this.mod,
    this.natOp,
    this.percMinFidelidade,
    this.serie,
    this.tolerancia,
    this.tpEmis,
    this.tpImp,
    this.tpNf,
    this.valorHoraGuardaVolume,
    this.valorMinutoVisita,
    this.servicoNfse,
  });

  Parametro.fromJson(Map<String, dynamic> json) {
    try{
      centroCustoCheckin = CentroCusto.fromJson(json['centro_custo_checkin']);
    } catch(e){

    }

    try{
      centroCustoEvento = CentroCusto.fromJson(json['centro_custo_evento']);
    } catch(e){

    }

    try{
      formaPagamento = FormaPagamento.fromJson(json['forma_pagamento']);
    } catch(e){

    }

    cfop = json['cfop'];
    empresa = json['empresa'];
    finNfe = json['fin_nfe'];
    idDest = json['id_dest'];
    indFinal = json['ind_final'];
    indPres = json['ind_pres'];
    minutosMaximo = json['minutos_maximo'];
    minutosMinimo = json['minutos_minimo'];
    mod = json['mod'];
    natOp = json['nat_op'];
    percMinFidelidade = json['perc_min_fidelidade'];
    serie = json['serie'];
    tolerancia = json['tolerancia'];
    tpEmis = json['tp_emis'];
    tpImp = json['tp_imp'];
    tpNf = json['tp_nf'];
    valorHoraGuardaVolume = json['valor_hora_guarda_volume'];
    valorMinutoVisita = json['valor_minuto_visita'];
    try{
      servicoNfse = ServicoNfse.fromJson(json['servico']);
    } catch(e){

    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['centro_custo_checkin'] = this.centroCustoCheckin?.id;
    data['centro_custo_evento'] = this.centroCustoEvento?.id;
    data['cfop'] = this.cfop;
    data['cod_srv'] = this.servicoNfse?.id;
    data['empresa'] = this.empresa;
    data['fin_nfe'] = this.finNfe;
    data['forma_pagamento'] = this.formaPagamento?.id;
    data['id_dest'] = this.idDest;
    data['ind_final'] = this.indFinal;
    data['ind_pres'] = this.indPres;
    data['minutos_maximo'] = this.minutosMaximo;
    data['minutos_minimo'] = this.minutosMinimo;
    data['mod'] = this.mod;
    data['nat_op'] = this.natOp;
    data['perc_min_fidelidade'] = this.percMinFidelidade;
    data['serie'] = this.serie;
    data['tolerancia'] = this.tolerancia;
    data['tp_emis'] = this.tpEmis;
    data['tp_imp'] = this.tpImp;
    data['tp_nf'] = this.tpNf;
    data['valor_hora_guarda_volume'] = this.valorHoraGuardaVolume;
    data['valor_minuto_visita'] = this.valorMinutoVisita;
    return data;
  }
}
