// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cadastro_natureza_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CadastroNaturezaController on _CadastroNaturezaController, Store {
  late final _$isLoadingAtom = Atom(
    name: '_CadastroNaturezaController.isLoading',
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

  late final _$createNaturezaAsyncAction = AsyncAction(
    '_CadastroNaturezaController.createNatureza',
    context: context,
  );

  @override
  Future<dynamic> createNatureza(BuildContext context) {
    return _$createNaturezaAsyncAction.run(() => super.createNatureza(context));
  }

  late final _$updateNaturezaAsyncAction = AsyncAction(
    '_CadastroNaturezaController.updateNatureza',
    context: context,
  );

  @override
  Future<dynamic> updateNatureza(BuildContext context, Natureza natureza) {
    return _$updateNaturezaAsyncAction.run(
      () => super.updateNatureza(context, natureza),
    );
  }

  late final _$_CadastroNaturezaControllerActionController = ActionController(
    name: '_CadastroNaturezaController',
    context: context,
  );

  @override
  void setNatureza({Natureza? natureza}) {
    final _$actionInfo = _$_CadastroNaturezaControllerActionController
        .startAction(name: '_CadastroNaturezaController.setNatureza');
    try {
      return super.setNatureza(natureza: natureza);
    } finally {
      _$_CadastroNaturezaControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading}
    ''';
  }
}
