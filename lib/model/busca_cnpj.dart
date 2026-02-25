class BuscaCnpj {
  String? abertura;
  String? situacao;
  String? tipo;
  String? nome;
  String? porte;
  String? naturezaJuridica;
  List<Atividade>? atividadePrincipal;
  List<Atividade>? atividadesSecundarias;
  String? logradouro;
  String? numero;
  String? complemento;
  String? municipio;
  String? bairro;
  String? uf;
  String? cep;
  String? email;
  String? telefone;
  String? dataSituacao;
  String? cnpj;
  String? ultimaAtualizacao;
  String? status;
  String? fantasia;
  String? efr;
  String? motivoSituacao;
  String? situacaoEspecial;
  String? dataSituacaoEspecial;
  String? capitalSocial;
  List<dynamic>? qsa;
  Simples? simples;
  Simei? simei;
  Map<String, dynamic>? extra;
  Billing? billing;

  BuscaCnpj({
    this.abertura,
    this.situacao,
    this.tipo,
    this.nome,
    this.porte,
    this.naturezaJuridica,
    this.atividadePrincipal,
    this.atividadesSecundarias,
    this.logradouro,
    this.numero,
    this.complemento,
    this.municipio,
    this.bairro,
    this.uf,
    this.cep,
    this.email,
    this.telefone,
    this.dataSituacao,
    this.cnpj,
    this.ultimaAtualizacao,
    this.status,
    this.fantasia,
    this.efr,
    this.motivoSituacao,
    this.situacaoEspecial,
    this.dataSituacaoEspecial,
    this.capitalSocial,
    this.qsa,
    this.simples,
    this.simei,
    this.extra,
    this.billing,
  });

  BuscaCnpj.fromJson(Map<String, dynamic> json) {
    abertura = json['abertura'];
    situacao = json['situacao'];
    tipo = json['tipo'];
    nome = json['nome'];
    porte = json['porte'];
    naturezaJuridica = json['natureza_juridica'];
    if (json['atividade_principal'] != null) {
      atividadePrincipal = <Atividade>[];
      json['atividade_principal'].forEach((v) {
        atividadePrincipal!.add(Atividade.fromJson(v));
      });
    }
    if (json['atividades_secundarias'] != null) {
      atividadesSecundarias = <Atividade>[];
      json['atividades_secundarias'].forEach((v) {
        atividadesSecundarias!.add(Atividade.fromJson(v));
      });
    }
    logradouro = json['logradouro'];
    numero = json['numero'];
    complemento = json['complemento'];
    municipio = json['municipio'];
    bairro = json['bairro'];
    uf = json['uf'];
    cep = json['cep'];
    email = json['email'];
    telefone = json['telefone'];
    dataSituacao = json['data_situacao'];
    cnpj = json['cnpj'];
    ultimaAtualizacao = json['ultima_atualizacao'];
    status = json['status'];
    fantasia = json['fantasia'];
    efr = json['efr'];
    motivoSituacao = json['motivo_situacao'];
    situacaoEspecial = json['situacao_especial'];
    dataSituacaoEspecial = json['data_situacao_especial'];
    capitalSocial = json['capital_social'];
    qsa = json['qsa'];
    simples = json['simples'] != null
        ? Simples.fromJson(json['simples'])
        : null;
    simei =
    json['simei'] != null ? Simei.fromJson(json['simei']) : null;
    extra = json['extra'];
    billing =
    json['billing'] != null ? Billing.fromJson(json['billing']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['abertura'] = abertura;
    data['situacao'] = situacao;
    data['tipo'] = tipo;
    data['nome'] = nome;
    data['porte'] = porte;
    data['natureza_juridica'] = naturezaJuridica;
    if (atividadePrincipal != null) {
      data['atividade_principal'] =
          atividadePrincipal!.map((v) => v.toJson()).toList();
    }
    if (atividadesSecundarias != null) {
      data['atividades_secundarias'] =
          atividadesSecundarias!.map((v) => v.toJson()).toList();
    }
    data['logradouro'] = logradouro;
    data['numero'] = numero;
    data['complemento'] = complemento;
    data['municipio'] = municipio;
    data['bairro'] = bairro;
    data['uf'] = uf;
    data['cep'] = cep;
    data['email'] = email;
    data['telefone'] = telefone;
    data['data_situacao'] = dataSituacao;
    data['cnpj'] = cnpj;
    data['ultima_atualizacao'] = ultimaAtualizacao;
    data['status'] = status;
    data['fantasia'] = fantasia;
    data['efr'] = efr;
    data['motivo_situacao'] = motivoSituacao;
    data['situacao_especial'] = situacaoEspecial;
    data['data_situacao_especial'] = dataSituacaoEspecial;
    data['capital_social'] = capitalSocial;
    data['qsa'] = qsa;
    if (simples != null) {
      data['simples'] = simples!.toJson();
    }
    if (simei != null) {
      data['simei'] = simei!.toJson();
    }
    data['extra'] = extra;
    if (billing != null) {
      data['billing'] = billing!.toJson();
    }
    return data;
  }
}

class Atividade {
  String? code;
  String? text;

  Atividade({this.code, this.text});

  Atividade.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['text'] = text;
    return data;
  }
}

class Simples {
  bool? optante;
  String? dataOpcao;
  String? dataExclusao;
  String? ultimaAtualizacao;

  Simples({
    this.optante,
    this.dataOpcao,
    this.dataExclusao,
    this.ultimaAtualizacao,
  });

  Simples.fromJson(Map<String, dynamic> json) {
    optante = json['optante'];
    dataOpcao = json['data_opcao'];
    dataExclusao = json['data_exclusao'];
    ultimaAtualizacao = json['ultima_atualizacao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['optante'] = optante;
    data['data_opcao'] = dataOpcao;
    data['data_exclusao'] = dataExclusao;
    data['ultima_atualizacao'] = ultimaAtualizacao;
    return data;
  }
}

class Simei {
  bool? optante;
  String? dataOpcao;
  String? dataExclusao;
  String? ultimaAtualizacao;

  Simei({
    this.optante,
    this.dataOpcao,
    this.dataExclusao,
    this.ultimaAtualizacao,
  });

  Simei.fromJson(Map<String, dynamic> json) {
    optante = json['optante'];
    dataOpcao = json['data_opcao'];
    dataExclusao = json['data_exclusao'];
    ultimaAtualizacao = json['ultima_atualizacao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['optante'] = optante;
    data['data_opcao'] = dataOpcao;
    data['data_exclusao'] = dataExclusao;
    data['ultima_atualizacao'] = ultimaAtualizacao;
    return data;
  }
}

class Billing {
  bool? free;
  bool? database;

  Billing({this.free, this.database});

  Billing.fromJson(Map<String, dynamic> json) {
    free = json['free'];
    database = json['database'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['free'] = free;
    data['database'] = database;
    return data;
  }
}