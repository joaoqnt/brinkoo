// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cadastro_crianca_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CadastroCriancaController on _CadastroCriancaController, Store {
  late final _$criancaImageAtom = Atom(
    name: '_CadastroCriancaController.criancaImage',
    context: context,
  );

  @override
  Uint8List? get criancaImage {
    _$criancaImageAtom.reportRead();
    return super.criancaImage;
  }

  @override
  set criancaImage(Uint8List? value) {
    _$criancaImageAtom.reportWrite(value, super.criancaImage, () {
      super.criancaImage = value;
    });
  }

  late final _$responsaveisAtom = Atom(
    name: '_CadastroCriancaController.responsaveis',
    context: context,
  );

  @override
  List<Responsavel> get responsaveis {
    _$responsaveisAtom.reportRead();
    return super.responsaveis;
  }

  @override
  set responsaveis(List<Responsavel> value) {
    _$responsaveisAtom.reportWrite(value, super.responsaveis, () {
      super.responsaveis = value;
    });
  }

  late final _$responsaveisControllerAtom = Atom(
    name: '_CadastroCriancaController.responsaveisController',
    context: context,
  );

  @override
  List<CadastroResponsavelController> get responsaveisController {
    _$responsaveisControllerAtom.reportRead();
    return super.responsaveisController;
  }

  @override
  set responsaveisController(List<CadastroResponsavelController> value) {
    _$responsaveisControllerAtom.reportWrite(
      value,
      super.responsaveisController,
      () {
        super.responsaveisController = value;
      },
    );
  }

  late final _$isLoadingAtom = Atom(
    name: '_CadastroCriancaController.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$criancaSelectedAtom = Atom(
    name: '_CadastroCriancaController.criancaSelected',
    context: context,
  );

  @override
  Crianca? get criancaSelected {
    _$criancaSelectedAtom.reportRead();
    return super.criancaSelected;
  }

  @override
  set criancaSelected(Crianca? value) {
    _$criancaSelectedAtom.reportWrite(value, super.criancaSelected, () {
      super.criancaSelected = value;
    });
  }

  late final _$addFotoAsyncAction = AsyncAction(
    '_CadastroCriancaController.addFoto',
    context: context,
  );

  @override
  Future<void> addFoto(Uint8List imageBytes) {
    return _$addFotoAsyncAction.run(() => super.addFoto(imageBytes));
  }

  late final _$createCriancaAsyncAction = AsyncAction(
    '_CadastroCriancaController.createCrianca',
    context: context,
  );

  @override
  Future<dynamic> createCrianca(BuildContext context) {
    return _$createCriancaAsyncAction.run(() => super.createCrianca(context));
  }

  late final _$updateCriancaAsyncAction = AsyncAction(
    '_CadastroCriancaController.updateCrianca',
    context: context,
  );

  @override
  Future<dynamic> updateCrianca(BuildContext context, Crianca crianca) {
    return _$updateCriancaAsyncAction.run(
      () => super.updateCrianca(context, crianca),
    );
  }

  late final _$_CadastroCriancaControllerActionController = ActionController(
    name: '_CadastroCriancaController',
    context: context,
  );

  @override
  dynamic addResponsavel({Responsavel? responsavel}) {
    final _$actionInfo = _$_CadastroCriancaControllerActionController
        .startAction(name: '_CadastroCriancaController.addResponsavel');
    try {
      return super.addResponsavel(responsavel: responsavel);
    } finally {
      _$_CadastroCriancaControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeResponsavel(
    Responsavel responsavel,
    CadastroResponsavelController responsavelController,
  ) {
    final _$actionInfo = _$_CadastroCriancaControllerActionController
        .startAction(name: '_CadastroCriancaController.removeResponsavel');
    try {
      return super.removeResponsavel(responsavel, responsavelController);
    } finally {
      _$_CadastroCriancaControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCrianca({Crianca? crianca}) {
    final _$actionInfo = _$_CadastroCriancaControllerActionController
        .startAction(name: '_CadastroCriancaController.setCrianca');
    try {
      return super.setCrianca(crianca: crianca);
    } finally {
      _$_CadastroCriancaControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
criancaImage: ${criancaImage},
responsaveis: ${responsaveis},
responsaveisController: ${responsaveisController},
isLoading: ${isLoading},
criancaSelected: ${criancaSelected}
    ''';
  }
}
