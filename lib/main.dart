import 'package:flutter/material.dart';
import 'package:brinquedoteca_flutter/style.dart';
import 'package:brinquedoteca_flutter/view/login/login_view.dart';
import 'package:brinquedoteca_flutter/view/home_view.dart';
import 'package:brinquedoteca_flutter/view/crianca/crianca_list_view.dart';
import 'package:brinquedoteca_flutter/view/checkin/checkin_list_view.dart';
import 'package:brinquedoteca_flutter/view/responsavel/responsavel_list_view.dart';
import 'package:brinquedoteca_flutter/view/cadastros/cadastro_view.dart';
import 'package:brinquedoteca_flutter/view/parametro/parametro_view.dart';
import 'package:brinquedoteca_flutter/view/financeiro/financeiro_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brinquedoteca Virtual',
      theme: brinquedotecaTheme,
      debugShowCheckedModeBanner: false,
      home: const LoginView(), // Tela inicial
    );
  }
}
