import 'package:brinquedoteca_flutter/model/checkin.dart';
import 'package:brinquedoteca_flutter/model/forma_pagamento.dart';
import 'package:brinquedoteca_flutter/model/parceiro.dart';
import 'package:brinquedoteca_flutter/model/usuario.dart';

class Financeiro {
  Checkin? checkin;
  DateTime? dataNegociacao;
  String? descricao;
  FormaPagamento? formaPagamento;
  int? id;
  Parceiro? parceiro;
  String? receitaDespesa;
  Usuario? usuario;
  double? valorTotal;

  Financeiro(
      {this.checkin,
        this.dataNegociacao,
        this.descricao,
        this.formaPagamento,
        this.id,
        this.parceiro,
        this.receitaDespesa,
        this.usuario,
        this.valorTotal});

  Financeiro.fromJson(Map<String, dynamic> json) {
    checkin = json['checkin_data'] != null ? new Checkin.fromJson(json['checkin_data']) : null;
    dataNegociacao = DateTime.parse(json['data_negociacao']);
    descricao = json['descricao'];
    formaPagamento = json['forma_pagamento'] != null
         ? new FormaPagamento.fromJson(json['forma_pagamento'])
         : null;
    id = json['id'];
    parceiro = json['parceiro'] != null ? new Parceiro.fromJson(json['parceiro']) : null;
    receitaDespesa = json['receita_despesa'];
    usuario = json['usuario'];
    valorTotal = json['valor_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.checkin != null) {
      data['checkin'] = this.checkin!.toJson();
    }
    data['data_negociacao'] = this.dataNegociacao;
    data['descricao'] = this.descricao;
    if (this.formaPagamento != null) {
      data['forma_pagamento'] = this.formaPagamento!.toJson();
    }
    data['id'] = this.id;
    if (this.parceiro != null) {
      data['parceiro'] = this.parceiro!.toJson();
    }
    data['receita_despesa'] = this.receitaDespesa;
    data['usuario'] = this.usuario;
    data['valor_total'] = this.valorTotal;
    return data;
  }
}

