class GuardaVolume {
  String? descricao;
  int? id;
  bool? utilizado;
  bool? ativo;
  int? empresa;

  GuardaVolume({
    this.descricao,
    this.id,
    this.utilizado,
    this.ativo,
    this.empresa,
  });

  GuardaVolume.fromJson(Map<String, dynamic> json) {
    descricao = json['descricao'].toString();
    id = json['id'];
    utilizado = json['utilizado'];
    ativo = json['ativo'];
    empresa = json['empresa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['descricao'] = this.descricao;
    data['id'] = this.id;
    data['utilizado'] = this.utilizado;
    data['ativo'] = this.ativo;
    data['empresa'] = this.empresa;
    return data;
  }
}
