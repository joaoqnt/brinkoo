import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/custom_appbar.dart';
import 'package:brinquedoteca_flutter/component/login/row_brinkoo_logo.dart';
import 'package:brinquedoteca_flutter/component/login/row_divider_conecte.dart';
import 'package:brinquedoteca_flutter/component/login/text_field_login.dart';
import 'package:brinquedoteca_flutter/controller/login/login_create_account_controller.dart';
import 'package:brinquedoteca_flutter/utils/app_spacing.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:brinquedoteca_flutter/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../component/login/button_google.dart';

class LoginCreateAccountView extends StatelessWidget {
  LoginCreateAccountView({super.key});
  final _controller = LoginCreateAccountController();

  @override
  Widget build(BuildContext context) {
    Singleton.instance.tenant = "responsaveis";
    return Scaffold(
      appBar: const CustomAppBar(title: "Criar conta"),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.translucent,
        child: Observer(
          builder: (context) {
            return Center(
              child: SingleChildScrollView(
                padding: AppSpacing.paddingH24V16,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Form(
                    key: _controller.formKey,
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
                        AppSpacing.vLg,

                        /// GOOGLE LOGIN
                        RowDividerConecte(title: "Conecte com"),
                        AppSpacing.vMd,
                        Center(child: ButtonGoogle()),
                        AppSpacing.vMd,

                        /// SEPARADOR
                        RowDividerConecte(title: "ou"),
                        AppSpacing.vMd,

                        /// TÍTULO
                        Text(
                          "Crie sua conta gratuitamente",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        AppSpacing.vMd,

                        /// CAMPOS DE TEXTO
                        TextFieldLogin(
                          controller: _controller.tecCpf,
                          hintText: "000.000.000-01",
                          labelText: "CPF",
                          prefixIcon: Icon(Icons.assignment, color: Colors.grey.shade600),
                          errorText: _controller.errorTextCpf,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CpfInputFormatter(),
                          ],
                          validator: (p0) {
                            if(!Validator().isValidCpf(UtilBrasilFields.removeCaracteres(p0!)))
                              return "Cpf inválido";
                            return null;
                          },
                          keyboardType: TextInputType.number,
                        ),
                        AppSpacing.vMd,

                        TextFieldLogin(
                          controller: _controller.tecNome,
                          hintText: "João Vítor Silva",
                          labelText: "Nome completo",
                          prefixIcon:
                          Icon(Icons.person, color: Colors.grey.shade600),
                          keyboardType: TextInputType.text,
                        ),
                        AppSpacing.vMd,
                        TextFieldLogin(
                          controller: _controller.tecEmail,
                          hintText: "seu.email@dominio.com",
                          labelText: "Email",
                          prefixIcon: Icon(Icons.email, color: Colors.grey.shade600),
                          validator: (p0) {
                            if(!Validator().isValidEmail(p0!))
                              return "E-mail inválido";
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        AppSpacing.vMd,

                        TextFieldLogin(
                          controller: _controller.tecCelular,
                          hintText: "(34) 99998-8899",
                          labelText: "Celular",
                          prefixIcon: Icon(Icons.phone_android, color: Colors.grey.shade600),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            TelefoneInputFormatter()
                          ],
                          validator: (p0) {
                            if(!Validator().isValidCelular(p0!))
                              return "Celular inválido";
                            return null;
                          },
                          keyboardType: TextInputType.phone,
                        ),
                        AppSpacing.vMd,

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
                        AppSpacing.vSm,

                        /// REGRAS DE SENHA
                        Text(
                          "Para sua segurança, crie uma senha com no mínimo:",
                          style: const TextStyle(fontSize: 12),
                        ),
                        AppSpacing.vXs,
                        Column(
                          children: _controller.passwordValid.entries.map((entry) {
                            return Row(
                              children: [
                                AppSpacing.hMd,
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
                            );
                          }).toList(),
                        ),
                        AppSpacing.vMd,
                        /// BOTÃO CRIAR CONTA
                        FilledButton(
                          style: FilledButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () async{
                            if(_controller.formKey.currentState!.validate()) {
                              await _controller.validateCpf();
                            }
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
