// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parametro_geral_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ParametroGeralController on _ParametroGeralController, Store {
  late final _$isLoadingAtom = Atom(
    name: '_ParametroGeralController.isLoading',
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

  late final _$parametroAtualAtom = Atom(
    name: '_ParametroGeralController.parametroAtual',
    context: context,
  );

  @override
  Parametro? get parametroAtual {
    _$parametroAtualAtom.reportRead();
    return super.parametroAtual;
  }

  @override
  set parametroAtual(Parametro? value) {
    _$parametroAtualAtom.reportWrite(value, super.parametroAtual, () {
      super.parametroAtual = value;
    });
  }

  late final _$carregarParametroAsyncAction = AsyncAction(
    '_ParametroGeralController.carregarParametro',
    context: context,
  );

  @override
  Future<void> carregarParametro() {
    return _$carregarParametroAsyncAction.run(() => super.carregarParametro());
  }

  late final _$salvarParametroAsyncAction = AsyncAction(
    '_ParametroGeralController.salvarParametro',
    context: context,
  );

  @override
  Future<void> salvarParametro(BuildContext context) {
    return _$salvarParametroAsyncAction.run(
      () => super.salvarParametro(context),
    );
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
parametroAtual: ${parametroAtual}
    ''';
  }
}
