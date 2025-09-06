// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cadastro_empresa_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CadastroEmpresaController on _CadastroEmpresaController, Store {
  late final _$isLoadingAtom = Atom(
    name: '_CadastroEmpresaController.isLoading',
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

  late final _$createEmpresaAsyncAction = AsyncAction(
    '_CadastroEmpresaController.createEmpresa',
    context: context,
  );

  @override
  Future<dynamic> createEmpresa(BuildContext context) {
    return _$createEmpresaAsyncAction.run(() => super.createEmpresa(context));
  }

  late final _$updateEmpresaAsyncAction = AsyncAction(
    '_CadastroEmpresaController.updateEmpresa',
    context: context,
  );

  @override
  Future<dynamic> updateEmpresa(BuildContext context, Empresa empresa) {
    return _$updateEmpresaAsyncAction.run(
      () => super.updateEmpresa(context, empresa),
    );
  }

  late final _$_CadastroEmpresaControllerActionController = ActionController(
    name: '_CadastroEmpresaController',
    context: context,
  );

  @override
  void setEmpresa({Empresa? emprsa}) {
    final _$actionInfo = _$_CadastroEmpresaControllerActionController
        .startAction(name: '_CadastroEmpresaController.setEmpresa');
    try {
      return super.setEmpresa(emprsa: emprsa);
    } finally {
      _$_CadastroEmpresaControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading}
    ''';
  }
}
