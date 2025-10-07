import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom_appbar.dart';
import 'package:brinquedoteca_flutter/component/login/row_brinkoo_logo.dart';
import 'package:brinquedoteca_flutter/component/login/row_divider_conecte.dart';
import 'package:brinquedoteca_flutter/component/login/text_field_login.dart';
import 'package:brinquedoteca_flutter/controller/login/login_create_account_controller.dart';
import 'package:brinquedoteca_flutter/utils/app_spacing.dart';
import 'package:brinquedoteca_flutter/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../component/login/button_google.dart';

class LoginCreateAccountView extends StatelessWidget {
  LoginCreateAccountView({super.key});
  final _controller = LoginCreateAccountController();

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 500;

    return Scaffold(
      appBar: const CustomAppBar(title: "Criar conta"),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.translucent,
        child: Observer(
          builder: (context) {
            return Center(
              child: SingleChildScrollView(
                padding: AppSpacing.paddingH32V24,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        /// LOGO
                        Center(
                          child: RowBrinkooLogo(
                            fontSize: 28,
                            height: 30,
                          ),
                        ),
                        const SizedBox(height: 30),

                        /// GOOGLE LOGIN
                        RowDividerConecte(title: "Conecte com"),
                        const SizedBox(height: 20),
                        Center(child: ButtonGoogle()),
                        const SizedBox(height: 25),

                        /// SEPARADOR
                        RowDividerConecte(title: "ou"),
                        const SizedBox(height: 25),

                        /// TÍTULO
                        Text(
                          "Crie sua conta gratuitamente",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 25),

                        /// CAMPOS DE TEXTO
                        TextFieldLogin(
                          controller: _controller.tecCpf,
                          hintText: "000.000.000-01",
                          labelText: "CPF",
                          prefixIcon: Icon(Icons.assignment,
                              color: Colors.grey.shade600),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CpfInputFormatter(),
                          ],
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 15),

                        TextFieldLogin(
                          controller: _controller.tecNome,
                          hintText: "João Vítor Silva",
                          labelText: "Nome completo",
                          prefixIcon:
                          Icon(Icons.person, color: Colors.grey.shade600),
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 15),

                        TextFieldLogin(
                          controller: _controller.tecEmail,
                          hintText: "seu.email@dominio.com",
                          labelText: "Email",
                          prefixIcon:
                          Icon(Icons.email, color: Colors.grey.shade600),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 15),

                        TextFieldLogin(
                          controller: _controller.tecSenha,
                          hintText: "sua senha",
                          labelText: "Senha",
                          prefixIcon:
                          Icon(Icons.lock, color: Colors.grey.shade600),
                          onChanged: _controller.validatePassword,
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
                        const SizedBox(height: 12),

                        /// REGRAS DE SENHA
                        Text(
                          "Para sua segurança, crie uma senha com no mínimo:",
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 8),
                        Column(
                          children: _controller.passwordValid.entries.map((entry) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Row(
                                children: [
                                  Icon(
                                    entry.value ? Icons.check : Icons.close,
                                    size: 14,
                                    color:
                                    entry.value ? Colors.green : Colors.red,
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      entry.key,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: entry.value
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 30),

                        /// BOTÃO CRIAR CONTA
                        FilledButton(
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            // TODO: Implementar lógica de criação de conta
                          },
                          child: const Text("Criar conta"),
                        ),
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
