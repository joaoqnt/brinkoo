import 'package:characters/characters.dart';

class Utils {
  static int calcularIdade(DateTime dataNascimento) {
    final hoje = DateTime.now();
    int idade = hoje.year - dataNascimento.year;

    if (hoje.month < dataNascimento.month ||
        (hoje.month == dataNascimento.month && hoje.day < dataNascimento.day)) {
      idade--;
    }

    return idade;
  }

  static String removerAcentosEMinusculo(String texto) {
    final Map<String, String> acentos = {
      'á': 'a', 'à': 'a', 'ã': 'a', 'â': 'a',
      'é': 'e', 'ê': 'e',
      'í': 'i',
      'ó': 'o', 'ô': 'o', 'õ': 'o',
      'ú': 'u',
      'ç': 'c',
      'Á': 'a', 'À': 'a', 'Ã': 'a', 'Â': 'a',
      'É': 'e', 'Ê': 'e',
      'Í': 'i',
      'Ó': 'o', 'Ô': 'o', 'Õ': 'o',
      'Ú': 'u',
      'Ç': 'c',
    };

    final buffer = StringBuffer();
    for (final char in texto.characters) {
      buffer.write(acentos[char] ?? char.toLowerCase());
    }

    return buffer.toString().toLowerCase();
  }
}
