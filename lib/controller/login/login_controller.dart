import 'dart:convert';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/model/usuario.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:brinquedoteca_flutter/utils/shared_preferences_util.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final _repository = GenericRepository(
    endpoint: "login_app",
    fromJson: (p0) => Usuario.fromJson(p0),
  );

  final formKey = GlobalKey<FormState>();

  TextEditingController tecLogin = TextEditingController();
  TextEditingController tecSenha = TextEditingController();

  @observable
  bool isVisible = false;

  @observable
  bool isLoading = false;

  @action
  void toggleVisibility() {
    isVisible = !isVisible;
  }

  setUsuario(){
    if(Singleton.instance.usuario != null){
      Usuario usuario = Singleton.instance.usuario!;
      tecLogin.text = usuario.login??'';
      tecSenha.text = usuario.senha??'';
    }
  }

  @action
  Future<Usuario?> doLogin() async {
    try {
      isLoading = true;

      final usuario = await _repository.create({
        "email": tecLogin.text,
        "senha": tecSenha.text,
      });

      await SharedPreferencesUtil().saveToPreferences(usuario);

      return usuario;
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
    }
  }


}
