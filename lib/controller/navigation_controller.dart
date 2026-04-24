import 'package:brinquedoteca_flutter/view/cadastros/atividades/cadastro_atividade_view.dart';
import 'package:brinquedoteca_flutter/view/cadastros/crianca/cadastro_crianca_view.dart';
import 'package:brinquedoteca_flutter/view/cadastros/empresa/cadastro_empresa_view.dart';
import 'package:brinquedoteca_flutter/view/cadastros/guardas_volume/cadastro_guarda_volume_view.dart';
import 'package:brinquedoteca_flutter/view/cadastros/parceiro/cadastro_parceiro_view.dart';
import 'package:brinquedoteca_flutter/view/cadastros/responsavel/cadastro_responsavel_view.dart';
import 'package:brinquedoteca_flutter/view/checkin/cadastro_checkin_view.dart';
import 'package:brinquedoteca_flutter/view/checkin/checkin_list_view.dart';
import 'package:brinquedoteca_flutter/view/configuracao/centro_custo/cadastro_centro_custo_view.dart';
import 'package:brinquedoteca_flutter/view/configuracao/convenio/cadastro_convenio_view.dart';
import 'package:brinquedoteca_flutter/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'navigation_controller.g.dart';

class NavigationItem {
  final String label;
  final IconData? icon;
  final bool isHeader;

  NavigationItem({
    required this.label,
    this.icon,
    this.isHeader = false,
  });
}

class NavigationController = _NavigationControllerBase with _$NavigationController;

abstract class _NavigationControllerBase with Store {

  @observable
  int selectedIndex = 1;

  final int indexCadastroCheckinView = 1;
  final int indexHomeView = 2;
  final int indexCheckinListView = 3;
  final int indexCadastroCriancaView = 5;
  final int indexCadastroResponsavelView = 6;
  final int indexCadastroAtividadeView = 7;
  final int indexCadastroParceiroView = 8;
  final int indexCadastroEmpresaView = 9;
  final int indexCadastroGuardasVolumeView = 10;
  final int indexCadastroCentroCustoView = 12;
  final int indexCadastroConvenioView = 13;

  final Map<int, Widget> loadedPages = {};

  void ensurePageLoaded(int index) {
    if (loadedPages.containsKey(index)) return;

    if (index == indexCadastroCheckinView) {
      loadedPages[index] = CadastroCheckinView();

    } else if (index == indexHomeView) {
      loadedPages[index] = const HomeView();

    } else if (index == indexCheckinListView) {
      loadedPages[index] = const CheckinListView();

    } else if (index == indexCadastroCriancaView) {
      loadedPages[index] = CadastroCriancaView();

    } else if (index == indexCadastroResponsavelView) {
      loadedPages[index] = CadastroResponsavelView();

    } else if (index == indexCadastroAtividadeView) {
      loadedPages[index] = CadastroAtividadeView();

    } else if (index == indexCadastroParceiroView) {
      loadedPages[index] = CadastroParceiroView();
    } else if (index == indexCadastroEmpresaView) {
      loadedPages[index] = CadastroEmpresaView();
    }else if (index == indexCadastroGuardasVolumeView) {
      loadedPages[index] = CadastroGuardasVolumeView();
    }else if (index == indexCadastroCentroCustoView) {
      loadedPages[index] = CadastroCentroCustoView();
    } else if (index == indexCadastroConvenioView) {
      loadedPages[index] = CadastroConvenioView();
    }  else {
      loadedPages[index] = const SizedBox();
    }
  }

  @action
  void setIndex(int index) {
    ensurePageLoaded(index);
    selectedIndex = index;
  }

  /// Estrutura do menu
  final List<NavigationItem> menuItems = [
    NavigationItem(label: "OPERAÇÃO", isHeader: true),
    NavigationItem(label: "Check-in", icon: Icons.login_rounded),
    NavigationItem(label: "No espaço agora", icon: Icons.people_outline_rounded),
    NavigationItem(label: "Atendimentos", icon: Icons.calendar_today_rounded),

    NavigationItem(label: "CADASTROS", isHeader: true),
    NavigationItem(label: "Criança", icon: Icons.child_care),
    NavigationItem(label: "Responsável", icon: Icons.person),
    NavigationItem(label: "Atividade", icon: Icons.toys),
    NavigationItem(label: "Parceiro", icon: Icons.person_pin),
    NavigationItem(label: "Empresa", icon: Icons.business_center),
    NavigationItem(label: "Guarda-Volume", icon: Icons.cases_outlined),

    NavigationItem(label: "CONFIGURAÇÃO", isHeader: true),

    NavigationItem(
      label: "Centro de Custo",
      icon: Icons.account_balance_wallet_rounded,
    ),

    NavigationItem(
      label: "Convênio",
      icon: Icons.handshake_rounded,
    ),

    NavigationItem(
      label: "Formas de Pagamento",
      icon: Icons.payment_rounded,
    ),

    NavigationItem(
      label: "Natureza",
      icon: Icons.category_rounded,
    ),

    NavigationItem(label: "FINANCEIRO", isHeader: true),

    NavigationItem(
      label: "Contas a Pagar",
      icon: Icons.request_quote_rounded,
    ),

    NavigationItem(
      label: "Contas a Receber",
      icon: Icons.payments_rounded,
    ),

    NavigationItem(
      label: "NFS-e",
      icon: Icons.receipt_long_rounded,
    ),
  ];

  /// Páginas fixas (não recriam)
  final List<Widget> pages = [
    const SizedBox(), // header
    CadastroCheckinView(),
    const HomeView(),
    const CheckinListView(),

    const SizedBox(), // header
    CadastroCriancaView(),
    CadastroResponsavelView(),
    CadastroAtividadeView(),
    CadastroParceiroView(),
    CadastroEmpresaView(),
    CadastroGuardasVolumeView(),

    const SizedBox(), // header
    CadastroCentroCustoView()
  ];
}