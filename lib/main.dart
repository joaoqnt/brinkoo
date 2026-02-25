import 'package:brinquedoteca_flutter/style.dart';
import 'package:brinquedoteca_flutter/view/cadastros/cadastro_view.dart';
import 'package:brinquedoteca_flutter/view/checkin/checkin_list_view.dart';
import 'package:brinquedoteca_flutter/view/crianca/crianca_list_view.dart';
import 'package:brinquedoteca_flutter/view/financeiro/financeiro_view.dart';
import 'package:brinquedoteca_flutter/view/home_view.dart';
import 'package:brinquedoteca_flutter/view/login_view.dart';
import 'package:brinquedoteca_flutter/view/parametro/parametro_view.dart';
import 'package:brinquedoteca_flutter/view/responsavel/responsavel_list_view.dart';
import 'package:brinquedoteca_flutter/model/usuario.dart';
import 'package:brinquedoteca_flutter/utils/shared_preferences_util.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // necessário para async no main

  final prefsUtil = SharedPreferencesUtil();
  final Usuario? usuario = await prefsUtil.loadUserFromPreferences();

  final String initialRoute = '/';

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brinquedoteca Virtual',
      theme: brinquedotecaTheme,
      initialRoute: initialRoute,
      showSemanticsDebugger: false,
      routes: {
        '/': (context) => const LoginView(),
        '/crianca': (context) => CriancaListView(),
        '/checkin': (context) => const CheckinListView(),
        '/responsavel': (context) => ResponsavelListView(),
        '/cadastros': (context) => CadastroView(),
        '/home': (context) => HomeView(),
        '/parametro_geral': (context) => ParametroView(),
        '/financeiros': (context) => FinanceiroView(),
      },

    );
  }
}
