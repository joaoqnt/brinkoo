import 'package:brinquedoteca_flutter/model/centro_custo.dart';
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

  Convenio(
      {this.ativo,
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
        this.valorEmpresa});

  Convenio.fromJson(Map<String, dynamic> json) {
    ativo = json['ativo'];
    centroCusto = json['centro_custo'] != null ? CentroCusto.fromJson(json['centro_custo']) : null;
    try{
      dataExpiracao = DateTime.tryParse(json['data_expiracao']);
    } catch(e){

    }
    diaVencimento = json['dia_vencimento'];
    empresa = json['empresa'] != null ? new Empresa.fromJson(json['empresa']) : null;
    id = json['id'];
    maxVisita = json['max_visita'];
    minDiaVencimento = json['min_dia_vencimento'];
    natureza = json['natureza'] != null ? new Natureza.fromJson(json['natureza']) : null;
    descricao = json['descricao'];
    observacao = json['observacao'];
    parceiro = json['parceiro'] != null
        ? new Parceiro.fromJson(json['parceiro'])
        : null;
    percConvenio = json['perc_convenio'];
    percEmpresa = json['perc_empresa'];
    qtdVisita = json['qtd_visita'];
    valorConvenio = json['valor_convenio'];
    valorEmpresa = json['valor_empresa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ativo'] = this.ativo;
    if(this.centroCusto != null){
      data['centro_custo'] = this.centroCusto!.id;
    }
    data['data_expiracao'] = this.dataExpiracao;
    data['dia_vencimento'] = this.diaVencimento;
    if (this.empresa != null) {
      data['empresa'] = this.empresa!.id;
    }
    data['id'] = this.id;
    data['max_visita'] = this.maxVisita;
    data['min_dia_vencimento'] = this.minDiaVencimento;
    data['natureza'] = this.natureza;
    data['descricao'] = this.descricao;
    data['observacao'] = this.observacao;
    if (this.parceiro != null) {
      data['parceiro'] = this.parceiro!.id;
    }
    data['perc_convenio'] = this.percConvenio;
    data['perc_empresa'] = this.percEmpresa;
    data['qtd_visita'] = this.qtdVisita;
    data['valor_convenio'] = this.valorConvenio;
    data['valor_empresa'] = this.valorEmpresa;
    return data;
  }
}
