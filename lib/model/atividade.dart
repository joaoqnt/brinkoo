class Atividade {
  String? nome;
  String? descricao;
  String? icone;
  int? id;
  bool? ativo;
  bool? padrao;

  Atividade({
    this.nome,
    this.id,
    this.descricao,
    this.ativo,
    this.padrao,
    this.icone,
  });

  Atividade.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    descricao = json['descricao'];
    id = json['id'];
    padrao = json['padrao'];
    ativo = json['ativo'];
    icone = json['icone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    data['id'] = this.id;
    data['icone'] = this.icone;
    data['padrao'] = this.padrao;
    data['ativo'] = this.ativo;
    return data;
  }
}
