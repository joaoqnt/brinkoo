class Empresa {
  String? bairro;
  String? celular;
  String? cep;
  String? cidade;
  String? cnae;
  String? cnpj;
  String? complemento;
  String? descricao;
  String? email;
  int? id;
  String? inscest;
  String? logradouro;
  String? numero;
  String? telefone;
  String? uf;

  Empresa({
    this.bairro,
    this.celular,
    this.cep,
    this.cidade,
    this.cnae,
    this.cnpj,
    this.complemento,
    this.descricao,
    this.email,
    this.id,
    this.inscest,
    this.logradouro,
    this.numero,
    this.telefone,
    this.uf,
  });

  Empresa.fromJson(Map<String, dynamic> json) {
    bairro = json['bairro'];
    celular = json['celular'];
    cep = json['cep'];
    cidade = json['cidade'];
    cnae = json['cnae'];
    cnpj = json['cnpj'];
    complemento = json['complemento'];
    descricao = json['descricao'];
    email = json['email'];
    id = json['id'];
    inscest = json['inscest'];
    logradouro = json['logradouro'];
    numero = json['numero'];
    telefone = json['telefone'];
    uf = json['uf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bairro'] = this.bairro;
    data['celular'] = this.celular;
    data['cep'] = this.cep;
    data['cidade'] = this.cidade;
    data['cnae'] = this.cnae;
    data['cnpj'] = this.cnpj;
    data['complemento'] = this.complemento;
    data['descricao'] = this.descricao;
    data['email'] = this.email;
    data['id'] = this.id;
    data['inscest'] = this.inscest;
    data['logradouro'] = this.logradouro;
    data['numero'] = this.numero;
    data['telefone'] = this.telefone;
    data['uf'] = this.uf;
    return data;
  }
}
