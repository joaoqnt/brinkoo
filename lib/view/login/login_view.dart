import 'package:brinquedoteca_flutter/component/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/component/login/button_google.dart';
import 'package:brinquedoteca_flutter/component/login/row_brinkoo_logo.dart';
import 'package:brinquedoteca_flutter/component/login/row_create_account.dart';
import 'package:brinquedoteca_flutter/component/login/row_divider_conecte.dart';
import 'package:brinquedoteca_flutter/component/login/text_field_login.dart';
import 'package:brinquedoteca_flutter/controller/login/login_controller.dart';
import 'package:brinquedoteca_flutter/model/usuario.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../utils/app_spacing.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _controller = LoginController();

  @override
  void initState() {
    _controller.setUsuario();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.translucent,
        child: Observer(
          builder: (context) {
            return Center(
              child: SingleChildScrollView(
                padding: AppSpacing.paddingH32V24,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 400),
                  child: Form(
                    key: _controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        /// LOGO
                        Center(child: RowBrinkooLogo()),
                        const SizedBox(height: 40),

                        /// CAMPOS
                        TextFieldLogin(
                          controller: _controller.tecLogin,
                          hintText: "seu.email@dominio.com",
                          labelText: "E-mail",
                          prefixIcon:
                          Icon(Icons.email, color: Colors.grey.shade600),
                        ),
                        const SizedBox(height: 16),
                        TextFieldLogin(
                          controller: _controller.tecSenha,
                          hintText: "sua senha",
                          labelText: "Senha",
                          prefixIcon:
                          Icon(Icons.lock, color: Colors.grey.shade600),
                          obscureText: !_controller.isVisible,
                          suffixIcon: IconButton(
                            onPressed: _controller.toggleVisibility,
                            icon: Icon(
                              _controller.isVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),

                        /// ESQUECI SENHA
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Esqueci minha senha",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        /// BOTÃO ENTRAR
                        FilledButton(
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () async {
                            if (_controller.formKey.currentState!.validate()) {
                              try {
                                Usuario? usuario = await _controller.doLogin();
                              } catch (e) {
                                CustomSnackBar.error(
                                  context,
                                  "E-mail e/ou senha incorreto(s)",
                                );
                              }
                            }
                          },
                          child: _controller.isLoading
                              ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                              : const Text("Entrar"),
                        ),
                        const SizedBox(height: 25),

                        /// DIVISOR
                        RowDividerConecte(),
                        const SizedBox(height: 25),

                        /// GOOGLE
                        Center(child: ButtonGoogle()),
                        const SizedBox(height: 30),

                        /// CRIAR CONTA
                        RowCreateAccount(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
