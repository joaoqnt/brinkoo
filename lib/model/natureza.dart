class Natureza {
  String? descricao;
  int? id;

  Natureza({this.descricao, this.id});

  Natureza.fromJson(Map<String, dynamic> json) {
    descricao = json['descricao'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['descricao'] = this.descricao;
    data['id'] = this.id;
    return data;
  }
}
