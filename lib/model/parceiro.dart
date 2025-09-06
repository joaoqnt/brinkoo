class Parceiro {
  bool? agenciaBancaria;
  String? bairro;
  String? cep;
  String? cidade;
  bool? cliente;
  String? cpfCnpj;
  String? nome;
  String? email;
  String? endereco;
  String? estado;
  String? urlImage;
  bool? fornecedor;
  bool? funcionario;
  int? id;
  bool? pessoaFisica;
  String? telefone;
  String? inscricaoEstadual;
  bool? transportador;

  Parceiro(
      {this.agenciaBancaria,
        this.bairro,
        this.cep,
        this.cidade,
        this.cliente,
        this.cpfCnpj,
        this.nome,
        this.email,
        this.urlImage,
        this.endereco,
        this.estado,
        this.fornecedor,
        this.funcionario,
        this.inscricaoEstadual,
        this.id,
        this.pessoaFisica,
        this.telefone,
        this.transportador});

  Parceiro.fromJson(Map<String, dynamic> json) {
    agenciaBancaria = json['agencia_bancaria'];
    bairro = json['bairro'];
    cep = json['cep'];
    cidade = json['cidade'];
    cliente = json['cliente'];
    cpfCnpj = json['cpf_cnpj'].toString();
    nome = json['nome'];
    email = json['email'];
    endereco = json['endereco'];
    estado = json['estado'];
    fornecedor = json['fornecedor'];
    funcionario = json['funcionario'];
    id = json['id'];
    pessoaFisica = json['pessoa_fisica'];
    telefone = json['telefone'].toString();
    transportador = json['transportador'];
    urlImage = json['url_image'];
    inscricaoEstadual = json['inscricao_estadual']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['agencia_bancaria'] = this.agenciaBancaria;
    data['bairro'] = this.bairro;
    data['cep'] = this.cep;
    data['cidade'] = this.cidade;
    data['cliente'] = this.cliente;
    data['cpf_cnpj'] = this.cpfCnpj;
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['endereco'] = this.endereco;
    data['estado'] = this.estado;
    data['fornecedor'] = this.fornecedor;
    data['funcionario'] = this.funcionario;
    data['id'] = this.id;
    data['pessoa_fisica'] = this.pessoaFisica;
    data['telefone'] = this.telefone;
    data['transportador'] = this.transportador;
    data['url_image'] = this.urlImage;
    data['inscricao_estadual'] = this.inscricaoEstadual;
    return data;
  }
}
