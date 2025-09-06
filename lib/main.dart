import 'package:brinquedoteca_flutter/style.dart';
import 'package:brinquedoteca_flutter/view/cadastros/cadastro_view.dart';
import 'package:brinquedoteca_flutter/view/checkin/cadastro_checkin_view.dart';
import 'package:brinquedoteca_flutter/view/checkin/checkin_list_view.dart';
import 'package:brinquedoteca_flutter/view/crianca/cadastro_crianca_view.dart';
import 'package:brinquedoteca_flutter/view/crianca/crianca_list_view.dart';
import 'package:brinquedoteca_flutter/view/financeiro/financeiro_view.dart';
import 'package:brinquedoteca_flutter/view/home_view.dart';
import 'package:brinquedoteca_flutter/view/login_view.dart';
import 'package:brinquedoteca_flutter/view/parametro/parametro_view.dart';
import 'package:brinquedoteca_flutter/view/responsavel/responsavel_list_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brinquedoteca Virtual',
      theme: brinquedotecaTheme,
      //home: CadastroCheckinView(),
      // Rota inicial
      initialRoute: '/login',
      //// Definindo as rotas nomeadas
      routes: {
        '/login': (context) => const LoginView(),
        '/crianca': (context) =>  CriancaListView(),
        '/checkin': (context) => const CheckinListView(),
        '/responsavel': (context) => ResponsavelListView(),
        '/cadastros': (context) => CadastroView(),
        '/home': (context) => HomeView(),
        '/parametro': (context) => ParametroView(),
        '/financeiros': (context) => FinanceiroView(),
      },
    );
  }}
