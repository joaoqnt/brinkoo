class GuardaVolume {
  String? descricao;
  int? id;
  bool? utilizado;

  GuardaVolume({this.descricao, this.id, this.utilizado});

  GuardaVolume.fromJson(Map<String, dynamic> json) {
    descricao = json['descricao'].toString();
    id = json['id'];
    utilizado = json['utilizado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['descricao'] = this.descricao;
    data['id'] = this.id;
    data['utilizado'] = this.utilizado;
    return data;
  }
}
