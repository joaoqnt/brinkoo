class Responsavel {
  String? documento;
  String? email;
  int? id;
  String? nome;
  String? parentesco;
  String? celular;
  String? urlImage;
  String? endereco;
  String? cidade;
  String? bairro;
  String? estado;
  String? cep;

  Responsavel({
    this.documento,
    this.email,
    this.id,
    this.nome,
    this.parentesco,
    this.celular,
    this.urlImage,
    this.endereco,
    this.cidade,
    this.bairro,
    this.estado,
    this.cep,
  });

  Responsavel.fromJson(Map<String, dynamic> json) {
    documento = json['documento'].toString();
    email = json['email'];
    id = json['id'];
    nome = json['nome'];
    parentesco = json['parentesco'];
    celular = json['celular'].toString();
    urlImage = json['url_image'];
    endereco = json['endereco'].toString();
    cidade = json['cidade'];
    bairro = json['bairro'];
    estado = json['estado'];
    cep = json['cep'].toString();
  }

  Map<String, dynamic> toJson({bool? hideParentesco}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['documento'] = this.documento;
    data['email'] = this.email;
    data['id'] = this.id;
    data['nome'] = this.nome;
    if(!(hideParentesco??false))
      data['parentesco'] = this.parentesco;
    data['celular'] = this.celular;
    data['url_image'] = this.urlImage;
    data['endereco'] = this.endereco;
    data['cidade'] = this.cidade;
    data['bairro'] = this.bairro;
    data['estado'] = this.estado;
    data['cep'] = this.cep;
    return data;
  }
}