import 'package:brinquedoteca_flutter/component/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/component/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/component/login/button_google.dart';
import 'package:brinquedoteca_flutter/component/login/row_brinkoo_logo.dart';
import 'package:brinquedoteca_flutter/component/login/row_divider_conecte.dart';
import 'package:brinquedoteca_flutter/component/login/text_field_login.dart';
import 'package:brinquedoteca_flutter/controller/login_controller.dart';
import 'package:brinquedoteca_flutter/model/usuario.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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
      body: Observer(
        builder: (context) {
          return Form(
            key: _controller.formKey,
            child: Center(
              child: Container(
                padding: EdgeInsets.all(20),
                width: 400,
                color: Colors.white,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RowBrinkooLogo(),
                        SizedBox(height: 30),
                        TextFieldLogin(
                            controller: _controller.tecLogin,
                            hintText: "seu.email@exemplo.com",
                            labelText: "E-mail",
                            prefixIcon: Icon(Icons.email, color: Colors.grey.shade600)
                        ),
                        SizedBox(height: 15),
                        TextFieldLogin(
                          controller: _controller.tecSenha,
                          hintText: "sua senha",
                          labelText: "Senha",
                          prefixIcon: Icon(Icons.lock, color: Colors.grey.shade600),
                          obscureText: !_controller.isVisible,
                          suffixIcon: IconButton(
                            onPressed: () {
                              _controller.toggleVisibility();
                            },
                            icon: Icon(
                              _controller.isVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                                onPressed: () {

                                },
                                child: Text("Esqueci minha senha",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.grey
                                  )
                                )
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: FilledButton(
                                onPressed: () async {
                                  if(_controller.formKey.currentState!.validate()){
                                    try{
                                      Usuario? usuario = await _controller.doLogin();
                                    } catch(e){
                                      CustomSnackBar.error(context, "E-mail e/ou senha incorreto(s)");
                                    }
                                  }
                                },
                                child: _controller.isLoading
                                    ? Center(child: CircularProgressIndicator(color: Colors.white,))
                                    : Text("Entrar"),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        RowDividerConecte(),
                        SizedBox(height: 10),
                        ButtonGoogle(),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Não tem uma conta?",
                              style: TextStyle(fontSize: 14),
                            ),
                            const SizedBox(width: 4), // espaçamento pequeno entre os textos
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero, // remove padding padrão
                                minimumSize: Size(0, 0),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                "Cadastre-se",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
