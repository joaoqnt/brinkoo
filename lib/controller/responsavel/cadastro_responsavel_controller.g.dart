// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cadastro_responsavel_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CadastroResponsavelController on _CadastroResponsavelController, Store {
  late final _$isLoadingAtom = Atom(
    name: '_CadastroResponsavelController.isLoading',
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

  late final _$responsavelImageAtom = Atom(
    name: '_CadastroResponsavelController.responsavelImage',
    context: context,
  );

  @override
  Uint8List? get responsavelImage {
    _$responsavelImageAtom.reportRead();
    return super.responsavelImage;
  }

  @override
  set responsavelImage(Uint8List? value) {
    _$responsavelImageAtom.reportWrite(value, super.responsavelImage, () {
      super.responsavelImage = value;
    });
  }

  late final _$responsavelSelectedAtom = Atom(
    name: '_CadastroResponsavelController.responsavelSelected',
    context: context,
  );

  @override
  Responsavel? get responsavelSelected {
    _$responsavelSelectedAtom.reportRead();
    return super.responsavelSelected;
  }

  @override
  set responsavelSelected(Responsavel? value) {
    _$responsavelSelectedAtom.reportWrite(value, super.responsavelSelected, () {
      super.responsavelSelected = value;
    });
  }

  late final _$createResponsavelAsyncAction = AsyncAction(
    '_CadastroResponsavelController.createResponsavel',
    context: context,
  );

  @override
  Future<dynamic> createResponsavel(BuildContext context, bool hideParentesco) {
    return _$createResponsavelAsyncAction.run(
      () => super.createResponsavel(context, hideParentesco),
    );
  }

  late final _$updateResponsavelAsyncAction = AsyncAction(
    '_CadastroResponsavelController.updateResponsavel',
    context: context,
  );

  @override
  Future<dynamic> updateResponsavel(
    BuildContext context,
    Responsavel responsavel,
  ) {
    return _$updateResponsavelAsyncAction.run(
      () => super.updateResponsavel(context, responsavel),
    );
  }

  late final _$_CadastroResponsavelControllerActionController =
      ActionController(
        name: '_CadastroResponsavelController',
        context: context,
      );

  @override
  dynamic addFoto(Uint8List p0) {
    final _$actionInfo = _$_CadastroResponsavelControllerActionController
        .startAction(name: '_CadastroResponsavelController.addFoto');
    try {
      return super.addFoto(p0);
    } finally {
      _$_CadastroResponsavelControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setResponsavel({Responsavel? responsavel}) {
    final _$actionInfo = _$_CadastroResponsavelControllerActionController
        .startAction(name: '_CadastroResponsavelController.setResponsavel');
    try {
      return super.setResponsavel(responsavel: responsavel);
    } finally {
      _$_CadastroResponsavelControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
responsavelImage: ${responsavelImage},
responsavelSelected: ${responsavelSelected}
    ''';
  }
}
