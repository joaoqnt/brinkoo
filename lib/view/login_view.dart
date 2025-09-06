import 'package:brinquedoteca_flutter/component/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/controller/login_controller.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _controller = LoginController();
  final _responsive = Responsive();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Responsive.isMobile(context) ? null : Colors.grey.shade200,
      body: Stack(
        children: [
          //if(Responsive.isDesktop(context))
          //  Positioned.fill(
          //    child: Opacity(
          //      opacity: 0.2, // valor entre 0.0 e 1.0 (30% de opacidade)
          //      child: Image.asset(
          //        "assets/background.png",
          //        fit: BoxFit.cover,
          //      ),
          //    ),
          //  ),
          Center(
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
                              height: Responsive.isMobile(context) ? 70 : 100,
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
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email),
                        ),
                        SizedBox(height: 15),
                        CustomTextFormField(
                          hintText: "Senha",
                          obscureText: !_controller.isVisible,
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              _controller.setIsVisible();
                              setState(() {});
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
                        ),
                        SizedBox(height: 25),
                        Row(
                          children: [
                            Expanded(
                              child: FilledButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/home');
                                },
                                child: Text("Entrar"),
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
          )
        ],
      ),
    );
  }
}
