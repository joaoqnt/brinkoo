bool isValidCPF(String cpf) {
  cpf = cpf.replaceAll(RegExp(r'[^0-9]'), '');

  if (cpf.length != 11) return false;

  // Verifica se todos os números são iguais
  if (RegExp(r'^(\d)\1*$').hasMatch(cpf)) return false;

  List<int> numbers = cpf.split('').map(int.parse).toList();

  // Primeiro dígito verificador
  int sum = 0;
  for (int i = 0; i < 9; i++) {
    sum += numbers[i] * (10 - i);
  }

  int firstDigit = (sum * 10) % 11;
  if (firstDigit == 10) firstDigit = 0;

  if (numbers[9] != firstDigit) return false;

  // Segundo dígito verificador
  sum = 0;
  for (int i = 0; i < 10; i++) {
    sum += numbers[i] * (11 - i);
  }

  int secondDigit = (sum * 10) % 11;
  if (secondDigit == 10) secondDigit = 0;

  if (numbers[10] != secondDigit) return false;

  return true;
}

bool isValidCNPJ(String cnpj) {
  cnpj = cnpj.replaceAll(RegExp(r'[^0-9]'), '');

  if (cnpj.length != 14) return false;

  // Verifica sequência repetida
  if (RegExp(r'^(\d)\1*$').hasMatch(cnpj)) return false;

  List<int> numbers = cnpj.split('').map(int.parse).toList();

  // Primeiro dígito verificador
  List<int> weights1 = [5,4,3,2,9,8,7,6,5,4,3,2];
  int sum = 0;

  for (int i = 0; i < 12; i++) {
    sum += numbers[i] * weights1[i];
  }

  int firstDigit = sum % 11;
  firstDigit = firstDigit < 2 ? 0 : 11 - firstDigit;

  if (numbers[12] != firstDigit) return false;

  // Segundo dígito verificador
  List<int> weights2 = [6,5,4,3,2,9,8,7,6,5,4,3,2];
  sum = 0;

  for (int i = 0; i < 13; i++) {
    sum += numbers[i] * weights2[i];
  }

  int secondDigit = sum % 11;
  secondDigit = secondDigit < 2 ? 0 : 11 - secondDigit;

  if (numbers[13] != secondDigit) return false;

  return true;
}

bool isValidEmail(String email) {
  final regex = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  return regex.hasMatch(email);
}

String? validateDia(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Informe o dia";
  }

  final dia = int.tryParse(value);

  if (dia == null) {
    return "Dia inválido";
  }

  if (dia < 1 || dia > 31) {
    return "O dia deve ser entre 1 e 31";
  }
  return null;
}
