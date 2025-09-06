import 'package:brinquedoteca_flutter/model/responsavel.dart';

class Crianca {
  String? alergias;
  DateTime? dataCadastro;
  DateTime? dataImagem;
  DateTime? dataNascimento;
  String? grupoSanguineo;
  int? id;
  String? necessidadesEspeciais;
  String? nome;
  String? observacoes;
  List<Responsavel>? responsaveis;
  String? sexo;
  String? urlImage;

  Crianca(
      {this.alergias,
        this.dataCadastro,
        this.dataImagem,
        this.dataNascimento,
        this.grupoSanguineo,
        this.id,
        this.necessidadesEspeciais,
        this.nome,
        this.observacoes,
        this.responsaveis,
        this.sexo,
        this.urlImage});

  Crianca.fromJson(Map<String, dynamic> json) {
    alergias = json['alergias'];
    try {
      dataCadastro = DateTime.tryParse(json['data_cadastro']);
    } catch (e) {
      dataCadastro = null; // ou trate de outra forma
    }

    try {
      dataImagem = DateTime.tryParse(json['data_imagem']);
    } catch (e) {
      dataImagem = null;
    }

    try {
      dataNascimento = DateTime.tryParse(json['data_nascimento']);
    } catch (e) {
      dataNascimento = null;
    }

    grupoSanguineo = json['grupo_sanguineo'];
    id = json['id'];
    necessidadesEspeciais = json['necessidades_especiais'];
    nome = json['nome'];
    observacoes = json['observacoes'];
    if (json['responsaveis'] != null) {
      responsaveis = <Responsavel>[];
      json['responsaveis'].forEach((v) {
        responsaveis!.add(new Responsavel.fromJson(v));
      });
    }
    sexo = json['sexo'];
    urlImage = json['url_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['alergias'] = this.alergias;
    data['data_cadastro'] = this.dataCadastro?.toIso8601String();
    data['data_imagem'] = this.dataImagem?.toIso8601String();
    data['data_nascimento'] = this.dataNascimento?.toIso8601String();
    data['grupo_sanguineo'] = this.grupoSanguineo;
    data['id'] = this.id;
    data['necessidades_especiais'] = this.necessidadesEspeciais;
    data['nome'] = this.nome;
    data['observacoes'] = this.observacoes;
    if (this.responsaveis != null) {
      data['responsaveis'] = this.responsaveis!.map((v) => v.toJson()).toList();
    }
    data['sexo'] = this.sexo;
    data['url_image'] = this.urlImage;
    return data;
  }

}
