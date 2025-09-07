import 'package:brinquedoteca_flutter/model/empresa.dart';

class Usuario {
  int? id;
  String? login;
  String? nome;
  String? senha;
  String? urlFoto;
  Empresa? empresa;

  bool permiteAcessarCadastro;
  bool permiteAcessarFinanceiro;
  bool permiteAcessarProduto;
  bool permiteAcessarCheckin;

  bool permiteCadastrarAtividade;
  bool permiteCadastrarCheckin;
  bool permiteCadastrarCrianca;
  bool permiteCadastrarResponsavel;
  bool permiteCadastrarNatureza;
  bool permiteCadastrarCentroCusto;
  bool permiteCadastrarGuardaVolume;
  bool permiteCadastrarParceiro;
  bool permiteCadastrarEmpresa;
  bool permiteCadastrarUsuario;

  bool permiteAtualizarAtividade;
  bool permiteAtualizarCheckin;
  bool permiteAtualizarCrianca;
  bool permiteAtualizarResponsavel;
  bool permiteAtualizarNatureza;
  bool permiteAtualizarCentroCusto;
  bool permiteAtualizarGuardaVolume;
  bool permiteAtualizarParceiro;
  bool permiteAtualizarEmpresa;
  bool permiteAtualizarUsuario;

  bool permiteDeletarAtividade;
  bool permiteDeletarCheckin;
  bool permiteDeletarCrianca;
  bool permiteDeletarResponsavel;
  bool permiteDeletarNatureza;
  bool permiteDeletarCentroCusto;
  bool permiteDeletarGuardaVolume;
  bool permiteDeletarParceiro;
  bool permiteDeletarEmpresa;
  bool permiteDeletarUsuario;

  Usuario({
    this.id,
    this.login,
    this.nome,
    this.senha,
    this.urlFoto,
    this.empresa,
    this.permiteAcessarCadastro = false,
    this.permiteAcessarFinanceiro = false,
    this.permiteAcessarProduto = false,
    this.permiteAcessarCheckin = false,
    this.permiteCadastrarAtividade = false,
    this.permiteCadastrarCheckin = false,
    this.permiteCadastrarCrianca = false,
    this.permiteCadastrarResponsavel = false,
    this.permiteCadastrarNatureza = false,
    this.permiteCadastrarCentroCusto = false,
    this.permiteCadastrarGuardaVolume = false,
    this.permiteCadastrarParceiro = false,
    this.permiteCadastrarEmpresa = false,
    this.permiteCadastrarUsuario = false,
    this.permiteAtualizarAtividade = false,
    this.permiteAtualizarCheckin = false,
    this.permiteAtualizarCrianca = false,
    this.permiteAtualizarResponsavel = false,
    this.permiteAtualizarNatureza = false,
    this.permiteAtualizarCentroCusto = false,
    this.permiteAtualizarGuardaVolume = false,
    this.permiteAtualizarParceiro = false,
    this.permiteAtualizarEmpresa = false,
    this.permiteAtualizarUsuario = false,
    this.permiteDeletarAtividade = false,
    this.permiteDeletarCheckin = false,
    this.permiteDeletarCrianca = false,
    this.permiteDeletarResponsavel = false,
    this.permiteDeletarNatureza = false,
    this.permiteDeletarCentroCusto = false,
    this.permiteDeletarGuardaVolume = false,
    this.permiteDeletarParceiro = false,
    this.permiteDeletarEmpresa = false,
    this.permiteDeletarUsuario = false,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
    id: json['id'],
    login: json['login'],
    nome: json['nome'],
    senha: json['senha'],
    urlFoto: json['url_foto'],
    empresa: json['empresa'] != null ? Empresa.fromJson(json['empresa']) : null,
    permiteAcessarCadastro: json['permite_acessar_cadastro'] ?? false,
    permiteAcessarFinanceiro: json['permite_acessar_financeiro'] ?? false,
    permiteAcessarProduto: json['permite_acessar_produto'] ?? false,
    permiteAcessarCheckin: json['permite_acessar_checkin'] ?? false,
    permiteCadastrarAtividade: json['permite_cadastrar_atividade'] ?? false,
    permiteCadastrarCheckin: json['permite_cadastrar_checkin'] ?? false,
    permiteCadastrarCrianca: json['permite_cadastrar_crianca'] ?? false,
    permiteCadastrarResponsavel: json['permite_cadastrar_responsavel'] ?? false,
    permiteCadastrarNatureza: json['permite_cadastrar_natureza'] ?? false,
    permiteCadastrarCentroCusto: json['permite_cadastrar_centro_custo'] ?? false,
    permiteCadastrarGuardaVolume: json['permite_cadastrar_guarda_volume'] ?? false,
    permiteCadastrarParceiro: json['permite_cadastrar_parceiro'] ?? false,
    permiteCadastrarEmpresa: json['permite_cadastrar_empresa'] ?? false,
    permiteCadastrarUsuario: json['permite_cadastrar_usuario'] ?? false,
    permiteAtualizarAtividade: json['permite_atualizar_atividade'] ?? false,
    permiteAtualizarCheckin: json['permite_atualizar_checkin'] ?? false,
    permiteAtualizarCrianca: json['permite_atualizar_crianca'] ?? false,
    permiteAtualizarResponsavel: json['permite_atualizar_responsavel'] ?? false,
    permiteAtualizarNatureza: json['permite_atualizar_natureza'] ?? false,
    permiteAtualizarCentroCusto: json['permite_atualizar_centro_custo'] ?? false,
    permiteAtualizarGuardaVolume: json['permite_atualizar_guarda_volume'] ?? false,
    permiteAtualizarParceiro: json['permite_atualizar_parceiro'] ?? false,
    permiteAtualizarEmpresa: json['permite_atualizar_empresa'] ?? false,
    permiteAtualizarUsuario: json['permite_atualizar_usuario'] ?? false,
    permiteDeletarAtividade: json['permite_deletar_atividade'] ?? false,
    permiteDeletarCheckin: json['permite_deletar_checkin'] ?? false,
    permiteDeletarCrianca: json['permite_deletar_crianca'] ?? false,
    permiteDeletarResponsavel: json['permite_deletar_responsavel'] ?? false,
    permiteDeletarNatureza: json['permite_deletar_natureza'] ?? false,
    permiteDeletarCentroCusto: json['permite_deletar_centro_custo'] ?? false,
    permiteDeletarGuardaVolume: json['permite_deletar_guarda_volume'] ?? false,
    permiteDeletarParceiro: json['permite_deletar_parceiro'] ?? false,
    permiteDeletarEmpresa: json['permite_deletar_empresa'] ?? false,
    permiteDeletarUsuario: json['permite_deletar_usuario'] ?? false,
  );

  Map<String, dynamic> toJson({bool isLogin = false}) => {
    'id': id,
    'login': login,
    'nome': nome,
    'senha': senha,
    'url_foto': urlFoto,
    'permite_acessar_cadastro': permiteAcessarCadastro,
    'permite_acessar_financeiro': permiteAcessarFinanceiro,
    'permite_acessar_produto': permiteAcessarProduto,
    'permite_acessar_checkin': permiteAcessarCheckin,
    'permite_cadastrar_atividade': permiteCadastrarAtividade,
    'permite_cadastrar_checkin': permiteCadastrarCheckin,
    'permite_cadastrar_crianca': permiteCadastrarCrianca,
    'permite_cadastrar_responsavel': permiteCadastrarResponsavel,
    'permite_cadastrar_natureza': permiteCadastrarNatureza,
    'permite_cadastrar_centro_custo': permiteCadastrarCentroCusto,
    'permite_cadastrar_guarda_volume': permiteCadastrarGuardaVolume,
    'permite_cadastrar_parceiro': permiteCadastrarParceiro,
    'permite_cadastrar_empresa': permiteCadastrarEmpresa,
    'permite_cadastrar_usuario': permiteCadastrarUsuario,
    'permite_atualizar_atividade': permiteAtualizarAtividade,
    'permite_atualizar_checkin': permiteAtualizarCheckin,
    'permite_atualizar_crianca': permiteAtualizarCrianca,
    'permite_atualizar_responsavel': permiteAtualizarResponsavel,
    'permite_atualizar_natureza': permiteAtualizarNatureza,
    'permite_atualizar_centro_custo': permiteAtualizarCentroCusto,
    'permite_atualizar_guarda_volume': permiteAtualizarGuardaVolume,
    'permite_atualizar_parceiro': permiteAtualizarParceiro,
    'permite_atualizar_empresa': permiteAtualizarEmpresa,
    'permite_atualizar_usuario': permiteAtualizarUsuario,
    'permite_deletar_atividade': permiteDeletarAtividade,
    'permite_deletar_checkin': permiteDeletarCheckin,
    'permite_deletar_crianca': permiteDeletarCrianca,
    'permite_deletar_responsavel': permiteDeletarResponsavel,
    'permite_deletar_natureza': permiteDeletarNatureza,
    'permite_deletar_centro_custo': permiteDeletarCentroCusto,
    'permite_deletar_guarda_volume': permiteDeletarGuardaVolume,
    'permite_deletar_parceiro': permiteDeletarParceiro,
    'permite_deletar_empresa': permiteDeletarEmpresa,
    'permite_deletar_usuario': permiteDeletarUsuario,
    'empresa': isLogin ? empresa?.toJson() : empresa?.id,
  };
}
