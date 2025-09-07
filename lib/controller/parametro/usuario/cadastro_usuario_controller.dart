import 'dart:convert';
import 'dart:typed_data';
import 'package:brinquedoteca_flutter/component/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/model/empresa.dart';
import 'package:brinquedoteca_flutter/model/usuario.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'cadastro_usuario_controller.g.dart';

class CadastroUsuarioController = _CadastroUsuarioController with _$CadastroUsuarioController;

abstract class _CadastroUsuarioController with Store {
  final _usuarioRepository = GenericRepository(
    endpoint: "usuarios",
    fromJson: (json) => Usuario.fromJson(json),
  );

  final formKeyUsuario = GlobalKey<FormState>();

  // TextEditingControllers
  TextEditingController tecNome = TextEditingController();
  TextEditingController tecLogin = TextEditingController();
  TextEditingController tecSenha = TextEditingController();

  @observable
  Uint8List? usuarioImage;
  Empresa? empresaSelected;

  @observable
  bool isLoading = false;

  // Permissões
  @observable bool permiteAcessarCadastro = false;
  @observable bool permiteAcessarFinanceiro = false;
  @observable bool permiteAcessarProduto = false;
  @observable bool permiteAcessarCheckin = false;

  @observable bool permiteCadastrarAtividade = false;
  @observable bool permiteCadastrarCheckin = false;
  @observable bool permiteCadastrarCrianca = false;
  @observable bool permiteCadastrarResponsavel = false;
  @observable bool permiteCadastrarNatureza = false;
  @observable bool permiteCadastrarCentroCusto = false;
  @observable bool permiteCadastrarGuardaVolume = false;
  @observable bool permiteCadastrarParceiro = false;
  @observable bool permiteCadastrarEmpresa = false;
  @observable bool permiteCadastrarUsuario = false;

  @observable bool permiteAtualizarAtividade = false;
  @observable bool permiteAtualizarCheckin = false;
  @observable bool permiteAtualizarCrianca = false;
  @observable bool permiteAtualizarResponsavel = false;
  @observable bool permiteAtualizarNatureza = false;
  @observable bool permiteAtualizarCentroCusto = false;
  @observable bool permiteAtualizarGuardaVolume = false;
  @observable bool permiteAtualizarParceiro = false;
  @observable bool permiteAtualizarEmpresa = false;
  @observable bool permiteAtualizarUsuario = false;

  @observable bool permiteDeletarAtividade = false;
  @observable bool permiteDeletarCheckin = false;
  @observable bool permiteDeletarCrianca = false;
  @observable bool permiteDeletarResponsavel = false;
  @observable bool permiteDeletarNatureza = false;
  @observable bool permiteDeletarCentroCusto = false;
  @observable bool permiteDeletarGuardaVolume = false;
  @observable bool permiteDeletarParceiro = false;
  @observable bool permiteDeletarEmpresa = false;
  @observable bool permiteDeletarUsuario = false;

  @action
  Future<void> createUsuario(BuildContext context) async {
    isLoading = true;
    try {
      final usuario = _buildUsuario();
      print(jsonEncode(usuario.toJson()));
      await _usuarioRepository.create(usuario.toJson());

      if (usuarioImage != null) {
        await uploadImage(usuario);
      }

      CustomSnackBar.success(context, "Usuário cadastrado com sucesso");
    } catch (e) {
      print(e);
      CustomSnackBar.error(context, "Erro ao cadastrar usuário");
    }
    isLoading = false;
  }

  @action
  Future<void> updateUsuario(BuildContext context, Usuario usuarioOriginal) async {
    isLoading = true;
    try {
      final usuario = _buildUsuario(id: usuarioOriginal.id);
      print(jsonEncode(usuario.toJson()));
      final res = await _usuarioRepository.update(usuario.id!, usuario.toJson());
      print("Resposta do update: $res");

      if (usuarioImage != null) {
        await uploadImage(usuario);
      }

      CustomSnackBar.success(context, "Usuário atualizado com sucesso");
    } catch (e) {
      print(e);
      CustomSnackBar.error(context, "Erro ao atualizar usuário");
    }
    isLoading = false;
  }

  Usuario _buildUsuario({int? id}) {
    return Usuario(
      id: id,
      nome: tecNome.text,
      login: tecLogin.text,
      senha: tecSenha.text,
      urlFoto: "https://brinkoo.com.br/images/${Singleton.instance.tenant}/usuario/${tecLogin.text}.png",
      empresa: empresaSelected,
      permiteAcessarCadastro: permiteAcessarCadastro,
      permiteAcessarFinanceiro: permiteAcessarFinanceiro,
      permiteAcessarProduto: permiteAcessarProduto,
      permiteAcessarCheckin: permiteAcessarCheckin,

      permiteCadastrarAtividade: permiteCadastrarAtividade,
      permiteCadastrarCheckin: permiteCadastrarCheckin,
      permiteCadastrarCrianca: permiteCadastrarCrianca,
      permiteCadastrarResponsavel: permiteCadastrarResponsavel,
      permiteCadastrarNatureza: permiteCadastrarNatureza,
      permiteCadastrarCentroCusto: permiteCadastrarCentroCusto,
      permiteCadastrarGuardaVolume: permiteCadastrarGuardaVolume,
      permiteCadastrarParceiro: permiteCadastrarParceiro,
      permiteCadastrarEmpresa: permiteCadastrarEmpresa,
      permiteCadastrarUsuario: permiteCadastrarUsuario,

      permiteAtualizarAtividade: permiteAtualizarAtividade,
      permiteAtualizarCheckin: permiteAtualizarCheckin,
      permiteAtualizarCrianca: permiteAtualizarCrianca,
      permiteAtualizarResponsavel: permiteAtualizarResponsavel,
      permiteAtualizarNatureza: permiteAtualizarNatureza,
      permiteAtualizarCentroCusto: permiteAtualizarCentroCusto,
      permiteAtualizarGuardaVolume: permiteAtualizarGuardaVolume,
      permiteAtualizarParceiro: permiteAtualizarParceiro,
      permiteAtualizarEmpresa: permiteAtualizarEmpresa,
      permiteAtualizarUsuario: permiteAtualizarUsuario,

      permiteDeletarAtividade: permiteDeletarAtividade,
      permiteDeletarCheckin: permiteDeletarCheckin,
      permiteDeletarCrianca: permiteDeletarCrianca,
      permiteDeletarResponsavel: permiteDeletarResponsavel,
      permiteDeletarNatureza: permiteDeletarNatureza,
      permiteDeletarCentroCusto: permiteDeletarCentroCusto,
      permiteDeletarGuardaVolume: permiteDeletarGuardaVolume,
      permiteDeletarParceiro: permiteDeletarParceiro,
      permiteDeletarEmpresa: permiteDeletarEmpresa,
      permiteDeletarUsuario: permiteDeletarUsuario,
    );
  }

  @action
  void setUsuario({Usuario? usuario}) {
    tecNome.text = usuario?.nome ?? '';
    tecLogin.text = usuario?.login ?? '';
    tecSenha.text = usuario?.senha ?? '';

    permiteAcessarCadastro = usuario?.permiteAcessarCadastro ?? false;
    permiteAcessarFinanceiro = usuario?.permiteAcessarFinanceiro ?? false;
    permiteAcessarProduto = usuario?.permiteAcessarProduto ?? false;
    permiteAcessarCheckin = usuario?.permiteAcessarCheckin ?? false;

    permiteCadastrarAtividade = usuario?.permiteCadastrarAtividade ?? false;
    permiteCadastrarCheckin = usuario?.permiteCadastrarCheckin ?? false;
    permiteCadastrarCrianca = usuario?.permiteCadastrarCrianca ?? false;
    permiteCadastrarResponsavel = usuario?.permiteCadastrarResponsavel ?? false;
    permiteCadastrarNatureza = usuario?.permiteCadastrarNatureza ?? false;
    permiteCadastrarCentroCusto = usuario?.permiteCadastrarCentroCusto ?? false;
    permiteCadastrarGuardaVolume = usuario?.permiteCadastrarGuardaVolume ?? false;
    permiteCadastrarParceiro = usuario?.permiteCadastrarParceiro ?? false;
    permiteCadastrarEmpresa = usuario?.permiteCadastrarEmpresa ?? false;
    permiteCadastrarUsuario = usuario?.permiteCadastrarUsuario ?? false;

    permiteAtualizarAtividade = usuario?.permiteAtualizarAtividade ?? false;
    permiteAtualizarCheckin = usuario?.permiteAtualizarCheckin ?? false;
    permiteAtualizarCrianca = usuario?.permiteAtualizarCrianca ?? false;
    permiteAtualizarResponsavel = usuario?.permiteAtualizarResponsavel ?? false;
    permiteAtualizarNatureza = usuario?.permiteAtualizarNatureza ?? false;
    permiteAtualizarCentroCusto = usuario?.permiteAtualizarCentroCusto ?? false;
    permiteAtualizarGuardaVolume = usuario?.permiteAtualizarGuardaVolume ?? false;
    permiteAtualizarParceiro = usuario?.permiteAtualizarParceiro ?? false;
    permiteAtualizarEmpresa = usuario?.permiteAtualizarEmpresa ?? false;
    permiteAtualizarUsuario = usuario?.permiteAtualizarUsuario ?? false;

    permiteDeletarAtividade = usuario?.permiteDeletarAtividade ?? false;
    permiteDeletarCheckin = usuario?.permiteDeletarCheckin ?? false;
    permiteDeletarCrianca = usuario?.permiteDeletarCrianca ?? false;
    permiteDeletarResponsavel = usuario?.permiteDeletarResponsavel ?? false;
    permiteDeletarNatureza = usuario?.permiteDeletarNatureza ?? false;
    permiteDeletarCentroCusto = usuario?.permiteDeletarCentroCusto ?? false;
    permiteDeletarGuardaVolume = usuario?.permiteDeletarGuardaVolume ?? false;
    permiteDeletarParceiro = usuario?.permiteDeletarParceiro ?? false;
    permiteDeletarEmpresa = usuario?.permiteDeletarEmpresa ?? false;
    permiteDeletarUsuario = usuario?.permiteDeletarUsuario ?? false;
    setEmpresa(usuario?.empresa);
  }

  @action
  void addFoto(Uint8List bytes) {
    usuarioImage = bytes;
  }

  Future<void> uploadImage(Usuario usuario) async {
    await _usuarioRepository.uploadFile(
      pathField: "usuario",
      filename: "${usuario.login}.png",
      fileBytes: usuarioImage!,
    );
  }

  setEmpresa(Empresa? empresa){
    empresaSelected = empresa;
  }
}
