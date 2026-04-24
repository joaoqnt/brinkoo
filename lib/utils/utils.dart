import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/model/crianca.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/model/tmp/icone_atividade.dart';
import 'package:characters/characters.dart';

class Utils {
  static List<IconeAtividade> _icones = [
    IconeAtividade(nome: "Alimentação", pathImage: "alimentação-removebg-preview.png"),
    IconeAtividade(nome: "Batom", pathImage: "batom-removebg-preview.png"),
    IconeAtividade(nome: "Blocos de montar", pathImage: "blocos_de_montar-removebg-preview.png"),
    IconeAtividade(nome: "Cabelo", pathImage: "cabelo_1_-removebg-preview.png"),
    IconeAtividade(nome: "Esmalte", pathImage: "esmalte_new-removebg-preview.png"),
    IconeAtividade(nome: "Paleta", pathImage: "paleta-removebg-preview.png"),
    IconeAtividade(nome: "Piscina de bolinhas", pathImage: "piscina_de_bolinhas.jpg-removebg-preview.png"),
    IconeAtividade(nome: "Teatro", pathImage: "teatro.jpg-removebg-preview.png"),
    IconeAtividade(nome: "Tesoura", pathImage: "tesoura2-removebg-preview.png"),
    IconeAtividade(nome: "Videogame", pathImage: "videogame-removebg-preview.png"),

  ];

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

  static String obterTelefoneResponsavelCrianca(Crianca crianca){
    try{
      Responsavel responsavel;
      try{
        responsavel = crianca.responsaveis!.firstWhere((element) => element.parentesco?.toLowerCase() == "mae");
      } catch(e){
        responsavel = crianca.responsaveis!.first;
      }
      try{
        return UtilBrasilFields.obterTelefone(responsavel.celular!);
      } catch(e){
        return responsavel.celular!;
      }
    } catch(e){
      return "";
    }
  }

  IconeAtividade? getIconeAtividadeByName(String name){

    return _icones.where((element) => element.nome == name).firstOrNull;
  }

  List<IconeAtividade> getIconesAtividade(){
    return _icones;
  }

}
