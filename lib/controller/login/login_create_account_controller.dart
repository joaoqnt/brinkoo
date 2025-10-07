import 'dart:convert';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/model/usuario.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:brinquedoteca_flutter/utils/shared_preferences_util.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'login_create_account_controller.g.dart';

class LoginCreateAccountController = _LoginCreateAccountController with _$LoginCreateAccountController;

abstract class _LoginCreateAccountController with Store {
  final _repository = GenericRepository(
    endpoint: "login_app",
    fromJson: (p0) => Usuario.fromJson(p0),
  );

  final formKey = GlobalKey<FormState>();

  TextEditingController tecCpf = TextEditingController();
  TextEditingController tecNome = TextEditingController();
  TextEditingController tecEmail = TextEditingController();
  TextEditingController tecSenha = TextEditingController();

  @observable
  bool isVisible = false;

  @observable
  bool isLoading = false;

  @observable
  Map<String,bool> passwordValid = ObservableMap.of({
    "8 ou mais caracteres": false,
    "Uma letra maiúscula": false,
    "Uma letra minúscula": false,
    "Um número": false,
    "Um caracter especial (exemplo: @ ! & #)": false,
  });

  @action
  void toggleVisibility() {
    isVisible = !isVisible;
  }

  @action
  bool validatePassword(String password) {
    passwordValid["8 ou mais caracteres"] = password.length >= 8;
    passwordValid["Uma letra maiúscula"] = RegExp(r'[A-Z]').hasMatch(password);
    passwordValid["Uma letra minúscula"] = RegExp(r'[a-z]').hasMatch(password);
    passwordValid["Um número"] = RegExp(r'[0-9]').hasMatch(password);
    passwordValid["Um caracter especial (exemplo: @ ! & #)"] =
        RegExp(r'[!@#\$&*~_\-\.\,]').hasMatch(password);

    // Retorna true se todas as regras forem atendidas
    return !passwordValid.containsValue(false);
  }
}
