import 'package:brasil_fields/brasil_fields.dart';

class Validator{
  bool isValidEmail(String email) {
    // Expressão regular para validar e-mails comuns
    final RegExp regex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );
    return regex.hasMatch(email.trim());
  }

  bool isValidCelular(String celular) {

    final String digits = UtilBrasilFields.removeCaracteres(celular);

    return digits.length == 11 && digits.startsWith(RegExp(r'[1-9]'));
  }

  bool isValidCpf(String cpf) {
    return UtilBrasilFields.isCPFValido(cpf);
  }

}