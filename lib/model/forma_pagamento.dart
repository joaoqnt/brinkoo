class FormaPagamento {
  bool? ativo;
  String? descricao;
  int? id;
  int? numeroParcelas;

  FormaPagamento({this.ativo, this.descricao, this.id, this.numeroParcelas});

  FormaPagamento.fromJson(Map<String, dynamic> json) {
    ativo = json['ativo'];
    descricao = json['descricao'];
    id = json['id'];
    numeroParcelas = json['numero_parcelas'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ativo'] = this.ativo;
    data['descricao'] = this.descricao;
    data['id'] = this.id;
    data['numero_parcelas'] = this.numeroParcelas;
    return data;
  }
}
