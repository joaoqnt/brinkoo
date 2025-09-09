import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom_snackbar.dart';
import 'package:brinquedoteca_flutter/component/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/controller/login_controller.dart';
import 'package:brinquedoteca_flutter/model/usuario.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

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
      backgroundColor: Responsive.isMobile(context) ? null : Colors.grey.shade200,
      body: Stack(
        children: [
          Observer(
            builder: (context) {
              return Form(
                key: _controller.formKey,
                child: Center(
                  child: Material(
                    elevation: Responsive.isMobile(context) ? 0 : 10,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: MediaQuery.of(context).size.width *
                          (Responsive.isMobile(context) ? 1 : 0.3),
                      // 🔹 Apenas no desktop fixa altura
                      height: Responsive.isMobile(context)
                          ? null
                          : MediaQuery.of(context).size.height * 0.65,
                      padding: EdgeInsets.all(20),
                      color: Colors.white,
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: Responsive.isMobile(context) ? 70 : 120,
                                    padding: EdgeInsets.all(8),
                                    child: Image.asset("assets/logo.jpeg", fit: BoxFit.cover),
                                  ),
                                  SizedBox(width: 10),
                                  Flexible(
                                    child: Text(
                                      'Brinkoo',
                                      style: TextStyle(
                                        fontSize:
                                        Responsive.isMobile(context) ? 36 : 60,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 20),
                              CustomTextFormField(
                                hintText: "Login",
                                controller: _controller.tecLogin,
                                prefixIcon: Icon(Icons.person),
                                required: true,
                              ),
                              SizedBox(height: 15),
                              CustomTextFormField(
                                hintText: "Senha",
                                controller: _controller.tecSenha,
                                obscureText: !_controller.isVisible,
                                prefixIcon: Icon(Icons.lock),
                                required: true,
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
                              SizedBox(height: 15),
                              CustomTextFormField(
                                hintText: "Empresa",
                                prefixIcon: Icon(Icons.business),
                                controller: _controller.tecEmpresa,
                                required: true,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  CnpjInputFormatter()
                                ],
                              ),
                              SizedBox(height: 25),
                              Row(
                                children: [
                                  Expanded(
                                    child: FilledButton(
                                      onPressed: () async {
                                        if(_controller.formKey.currentState!.validate()){
                                          try{
                                            Usuario? usuario = await _controller.doLogin();
                                            if(usuario != null) {

                                              Navigator.of(context).pushNamed('/home');
                                            } else {
                                              CustomSnackBar.error(context, "Usuário não encontrado");
                                            }
                                          } catch(e){
                                            CustomSnackBar.error(context, "Dados incorretos!");
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          )
        ],
      ),
    );
  }
}
