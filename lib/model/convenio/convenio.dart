import 'package:brinquedoteca_flutter/model/centro_custo.dart';
import 'package:brinquedoteca_flutter/model/convenio/convenio_dia.dart';
import 'package:brinquedoteca_flutter/model/empresa.dart';
import 'package:brinquedoteca_flutter/model/natureza.dart';
import 'package:brinquedoteca_flutter/model/parceiro.dart';

class Convenio {
  bool? ativo;
  CentroCusto? centroCusto;
  DateTime? dataExpiracao;
  int? diaVencimento;
  Empresa? empresa;
  int? id;
  int? maxVisita;
  int? minDiaVencimento;
  Natureza? natureza;
  String? descricao;
  String? observacao;
  Parceiro? parceiro;
  double? percConvenio;
  double? percEmpresa;
  int? qtdVisita;
  double? valorConvenio;
  double? valorEmpresa;

  // 🔥 NOVO
  List<ConvenioDia>? convenioDias;

  Convenio({
    this.ativo,
    this.centroCusto,
    this.dataExpiracao,
    this.diaVencimento,
    this.empresa,
    this.id,
    this.maxVisita,
    this.minDiaVencimento,
    this.natureza,
    this.descricao,
    this.observacao,
    this.parceiro,
    this.percConvenio,
    this.percEmpresa,
    this.qtdVisita,
    this.valorConvenio,
    this.valorEmpresa,
    this.convenioDias,
  });

  Convenio.fromJson(Map<String, dynamic> json) {
    ativo = json['ativo'];

    try{
      centroCusto = json['centro_custo'] != null
          ? CentroCusto.fromJson(json['centro_custo'])
          : null;
    } catch(e){

    }


    try {
      dataExpiracao = DateTime.tryParse(json['data_expiracao']);
    } catch (e) {}

    diaVencimento = json['dia_vencimento'];

    try{
      empresa = json['empresa'] != null ? Empresa.fromJson(json['empresa']) : null;
    } catch(e){

    }



    id = json['id'];
    maxVisita = json['max_visita'];
    minDiaVencimento = json['min_dia_vencimento'];

    try{
      natureza = json['natureza'] != null ? Natureza.fromJson(json['natureza']) : null;
    } catch(e){

    }

    descricao = json['descricao'];
    observacao = json['observacao'];

    try{
      parceiro = json['parceiro'] != null
          ? Parceiro.fromJson(json['parceiro'])
          : null;
    } catch(e){

    }


    percConvenio = (json['perc_convenio'] as num?)?.toDouble();
    percEmpresa = (json['perc_empresa'] as num?)?.toDouble();
    qtdVisita = json['qtd_visita'];
    valorConvenio = (json['valor_convenio'] as num?)?.toDouble();
    valorEmpresa = (json['valor_empresa'] as num?)?.toDouble();

    convenioDias = json['convenio_dias'] != null
        ? List<ConvenioDia>.from(
      json['convenio_dias'].map((x) => ConvenioDia.fromJson(x)),
    )
        : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['ativo'] = ativo;

    if (centroCusto != null) {
      data['centro_custo'] = centroCusto!.id;
    }

    data['data_expiracao'] = dataExpiracao?.toIso8601String();
    data['dia_vencimento'] = diaVencimento;

    if (empresa != null) {
      data['empresa'] = empresa!.id;
    }

    data['id'] = id;
    data['max_visita'] = maxVisita;
    data['min_dia_vencimento'] = minDiaVencimento;
    data['natureza'] = natureza?.id;
    data['descricao'] = descricao;
    data['observacao'] = observacao;

    if (parceiro != null) {
      data['parceiro'] = parceiro!.id;
    }

    data['perc_convenio'] = percConvenio;
    data['perc_empresa'] = percEmpresa;
    data['qtd_visita'] = qtdVisita;
    data['valor_convenio'] = valorConvenio;
    data['valor_empresa'] = valorEmpresa;

    if (convenioDias != null && convenioDias!.isNotEmpty) {
      data['convenio_dias'] =
          convenioDias!.map((x) => x.toJson()).toList();
    }

    return data;
  }
}