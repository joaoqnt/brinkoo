// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cadastro_checkin_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CadastroCheckinController on _CadastroCheckinController, Store {
  late final _$isLoadingAtom = Atom(
    name: '_CadastroCheckinController.isLoading',
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

  late final _$criancasAtom = Atom(
    name: '_CadastroCheckinController.criancas',
    context: context,
  );

  @override
  List<Crianca> get criancas {
    _$criancasAtom.reportRead();
    return super.criancas;
  }

  @override
  set criancas(List<Crianca> value) {
    _$criancasAtom.reportWrite(value, super.criancas, () {
      super.criancas = value;
    });
  }

  late final _$criancaSelectedAtom = Atom(
    name: '_CadastroCheckinController.criancaSelected',
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

  late final _$criancaImageAtom = Atom(
    name: '_CadastroCheckinController.criancaImage',
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

  late final _$responsavelEntradaImageAtom = Atom(
    name: '_CadastroCheckinController.responsavelEntradaImage',
    context: context,
  );

  @override
  Uint8List? get responsavelEntradaImage {
    _$responsavelEntradaImageAtom.reportRead();
    return super.responsavelEntradaImage;
  }

  @override
  set responsavelEntradaImage(Uint8List? value) {
    _$responsavelEntradaImageAtom.reportWrite(
      value,
      super.responsavelEntradaImage,
      () {
        super.responsavelEntradaImage = value;
      },
    );
  }

  late final _$responsavelSaidaImageAtom = Atom(
    name: '_CadastroCheckinController.responsavelSaidaImage',
    context: context,
  );

  @override
  Uint8List? get responsavelSaidaImage {
    _$responsavelSaidaImageAtom.reportRead();
    return super.responsavelSaidaImage;
  }

  @override
  set responsavelSaidaImage(Uint8List? value) {
    _$responsavelSaidaImageAtom.reportWrite(
      value,
      super.responsavelSaidaImage,
      () {
        super.responsavelSaidaImage = value;
      },
    );
  }

  late final _$valorFinalAtom = Atom(
    name: '_CadastroCheckinController.valorFinal',
    context: context,
  );

  @override
  double get valorFinal {
    _$valorFinalAtom.reportRead();
    return super.valorFinal;
  }

  @override
  set valorFinal(double value) {
    _$valorFinalAtom.reportWrite(value, super.valorFinal, () {
      super.valorFinal = value;
    });
  }

  late final _$tempoDecorridoAtom = Atom(
    name: '_CadastroCheckinController.tempoDecorrido',
    context: context,
  );

  @override
  Duration get tempoDecorrido {
    _$tempoDecorridoAtom.reportRead();
    return super.tempoDecorrido;
  }

  @override
  set tempoDecorrido(Duration value) {
    _$tempoDecorridoAtom.reportWrite(value, super.tempoDecorrido, () {
      super.tempoDecorrido = value;
    });
  }

  late final _$getCriancasAsyncAction = AsyncAction(
    '_CadastroCheckinController.getCriancas',
    context: context,
  );

  @override
  Future<List<Crianca>> getCriancas() {
    return _$getCriancasAsyncAction.run(() => super.getCriancas());
  }

  late final _$takePhotoAsyncAction = AsyncAction(
    '_CadastroCheckinController.takePhoto',
    context: context,
  );

  @override
  Future takePhoto(Uint8List imageData, int type) {
    return _$takePhotoAsyncAction.run(() => super.takePhoto(imageData, type));
  }

  late final _$createCheckinAsyncAction = AsyncAction(
    '_CadastroCheckinController.createCheckin',
    context: context,
  );

  @override
  Future createCheckin(BuildContext context) {
    return _$createCheckinAsyncAction.run(() => super.createCheckin(context));
  }

  late final _$updateCheckinAsyncAction = AsyncAction(
    '_CadastroCheckinController.updateCheckin',
    context: context,
  );

  @override
  Future updateCheckin(Checkin checkinCreated, BuildContext context) {
    return _$updateCheckinAsyncAction.run(
      () => super.updateCheckin(checkinCreated, context),
    );
  }

  late final _$_CadastroCheckinControllerActionController = ActionController(
    name: '_CadastroCheckinController',
    context: context,
  );

  @override
  void startTimer({required DateTime dataEntrada}) {
    final _$actionInfo = _$_CadastroCheckinControllerActionController
        .startAction(name: '_CadastroCheckinController.startTimer');
    try {
      return super.startTimer(dataEntrada: dataEntrada);
    } finally {
      _$_CadastroCheckinControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCrianca(Crianca crianca) {
    final _$actionInfo = _$_CadastroCheckinControllerActionController
        .startAction(name: '_CadastroCheckinController.setCrianca');
    try {
      return super.setCrianca(crianca);
    } finally {
      _$_CadastroCheckinControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
criancas: ${criancas},
criancaSelected: ${criancaSelected},
criancaImage: ${criancaImage},
responsavelEntradaImage: ${responsavelEntradaImage},
responsavelSaidaImage: ${responsavelSaidaImage},
valorFinal: ${valorFinal},
tempoDecorrido: ${tempoDecorrido}
    ''';
  }
}
