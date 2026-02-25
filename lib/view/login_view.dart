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
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final width = constraints.maxWidth;

                        double containerWidth;
                        double horizontalPadding;

                        if (width < 600) {
                          // 📱 Mobile
                          containerWidth = width;
                          horizontalPadding = 20;
                        } else if (width < 1024) {
                          // 📲 Tablet
                          containerWidth = width * 0.6;
                          horizontalPadding = 28;
                        } else {
                          // 🖥 Desktop
                          containerWidth = 420; // largura fixa elegante
                          horizontalPadding = 32;
                        }

                        return Observer(
                          builder: (context) {
                            return Center(
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: containerWidth,
                                padding: EdgeInsets.symmetric(
                                  horizontal: horizontalPadding,
                                  vertical: 32,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: width < 600 ? 70 : 100,
                                            padding: const EdgeInsets.all(8),
                                            child: Image.asset(
                                              "assets/logo.jpeg",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Flexible(
                                            child: Text(
                                              'Brinkoo',
                                              style: TextStyle(
                                                fontSize: width < 600 ? 36 : 48,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 30),

                                      CustomTextFormField(
                                        hintText: "Login",
                                        controller: _controller.tecLogin,
                                        prefixIcon: const Icon(Icons.person),
                                        required: true,
                                      ),

                                      const SizedBox(height: 15),

                                      CustomTextFormField(
                                        hintText: "Senha",
                                        controller: _controller.tecSenha,
                                        obscureText: !_controller.isVisible,
                                        maxLines: 1,
                                        prefixIcon: const Icon(Icons.lock),
                                        required: true,
                                        suffixIcon: IconButton(
                                          onPressed: () => _controller.toggleVisibility(),
                                          icon: Icon(
                                            _controller.isVisible
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 15),

                                      CustomTextFormField(
                                        hintText: "Empresa",
                                        prefixIcon: const Icon(Icons.business),
                                        controller: _controller.tecEmpresa,
                                        required: true,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          CnpjInputFormatter(),
                                        ],
                                      ),

                                      const SizedBox(height: 30),

                                      SizedBox(
                                        width: double.infinity,
                                        child: FilledButton(
                                          onPressed: () async {
                                            if (_controller.formKey.currentState!.validate()) {
                                              try {
                                                Usuario? usuario = await _controller.doLogin();
                                                if (usuario != null) {
                                                  Navigator.of(context).pushNamed('/home');
                                                } else {
                                                  CustomSnackBar.error(
                                                      context, "Usuário não encontrado");
                                                }
                                              } catch (e) {
                                                CustomSnackBar.error(
                                                    context, "Dados incorretos!");
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
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        );
                      },
                    )
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
