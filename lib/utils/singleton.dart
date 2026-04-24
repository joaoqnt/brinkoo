import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_atividade_controller.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_guarda_volume_controller.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_parceiro_controller.dart';
import 'package:brinquedoteca_flutter/controller/checkin/cadastro_checkin_controller.dart';
import 'package:brinquedoteca_flutter/controller/checkin/checkin_list_controller.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_crianca_controller.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_empresa_controller.dart';
import 'package:brinquedoteca_flutter/controller/configuracao/cadastro_centro_custo_controller.dart';
import 'package:brinquedoteca_flutter/controller/configuracao/cadastro_convenio_controller.dart';
import 'package:brinquedoteca_flutter/controller/inicio_controller.dart';
import 'package:brinquedoteca_flutter/controller/navigation_controller.dart';
import 'package:brinquedoteca_flutter/controller/cadastro/cadastro_responsavel_controller.dart';
import 'package:brinquedoteca_flutter/model/empresa.dart';
import 'package:brinquedoteca_flutter/model/usuario.dart';

class Singleton {

  static final Singleton _instance = Singleton._internal();

  factory Singleton() => _instance;

  Singleton._internal();

  static Singleton get instance => _instance;

  String _pageSelected = "Início";

  late String tenant;

  Usuario? usuario;
  Empresa? empresa;

  /// Controllers globais
  final NavigationController navigationController = NavigationController();

  final CadastroCriancaController cadastroCriancaController = CadastroCriancaController();

  final CadastroResponsavelController cadastroResponsavelController = CadastroResponsavelController();

  final CadastroAtividadeController cadastroAtividadeController = CadastroAtividadeController();

  final CadastroCheckinController cadastroCheckinController = CadastroCheckinController();

  final CadastroEmpresaController cadastroEmpresaController = CadastroEmpresaController();

  final CadastroGuardaVolumeController cadastroGuardaVolumeController = CadastroGuardaVolumeController();

  final CadastroParceiroController cadastroParceiroController = CadastroParceiroController();

  final CadastroCentroCustoController cadastroCentroCustoController = CadastroCentroCustoController();

  final CadastroConvenioController cadastroConvenioController = CadastroConvenioController();

  final CheckinListController checkinListController = CheckinListController();

  final InicioController inicioController = InicioController();

  /// Getter / Setter
  String get pageSelected => _pageSelected;

  set pageSelected(String value) {
    _pageSelected = value;
  }
}