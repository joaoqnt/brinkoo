import 'package:brinquedoteca_flutter/model/usuario.dart';

class Singleton {
  // Instância única (privada)
  static final Singleton _instance = Singleton._internal();

  // Construtor privado
  Singleton._internal();

  // Getter para acesso externo à instância
  static Singleton get instance => _instance;

  // Atributo global
  String _pageSelected = "Início";

  late String tenant;

  Usuario? usuario;

  // Getter e Setter
  String get pageSelected => _pageSelected;

  set pageSelected(String value) {
    _pageSelected = value;
  }
}
