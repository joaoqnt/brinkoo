class Empresa {
  String? cnpj;
  String? descricao;
  int? id;

  Empresa({this.cnpj, this.descricao, this.id});

  Empresa.fromJson(Map<String, dynamic> json) {
    cnpj = json['cnpj'].toString();
    descricao = json['descricao'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cnpj'] = this.cnpj;
    data['descricao'] = this.descricao;
    data['id'] = this.id;
    return data;
  }
}
