import 'dart:convert';

import 'package:brinquedoteca_flutter/model/usuario.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil{

  Future<void> saveToPreferences(Usuario usuario) async {
    final prefs = await SharedPreferences.getInstance();

    // Converte usuário para JSON e salva
    await prefs.setString("usuario", jsonEncode(usuario.toJson(isLogin: true)));

    Singleton.instance.usuario = usuario;
  }

  Future<Usuario?> loadUserFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    // Recupera usuário
    final usuarioJson = prefs.getString("usuario");
    if (usuarioJson != null) {
      Singleton.instance.usuario = Usuario.fromJson(jsonDecode(usuarioJson));
      return Singleton.instance.usuario;
    }
    return null;
  }

  Future<void> clearPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("tenant");
    await prefs.remove("usuario");
  }
}