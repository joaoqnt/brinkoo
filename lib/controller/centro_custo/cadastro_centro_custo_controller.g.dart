// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cadastro_centro_custo_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CadastroCentroCustoController on _CadastroCentroCustoController, Store {
  late final _$isLoadingAtom = Atom(
    name: '_CadastroCentroCustoController.isLoading',
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

  late final _$createCenCusAsyncAction = AsyncAction(
    '_CadastroCentroCustoController.createCenCus',
    context: context,
  );

  @override
  Future<dynamic> createCenCus(BuildContext context) {
    return _$createCenCusAsyncAction.run(() => super.createCenCus(context));
  }

  late final _$updateCenCusAsyncAction = AsyncAction(
    '_CadastroCentroCustoController.updateCenCus',
    context: context,
  );

  @override
  Future<dynamic> updateCenCus(BuildContext context, CentroCusto atividade) {
    return _$updateCenCusAsyncAction.run(
      () => super.updateCenCus(context, atividade),
    );
  }

  late final _$_CadastroCentroCustoControllerActionController =
      ActionController(
        name: '_CadastroCentroCustoController',
        context: context,
      );

  @override
  void setCenCus({CentroCusto? cencus}) {
    final _$actionInfo = _$_CadastroCentroCustoControllerActionController
        .startAction(name: '_CadastroCentroCustoController.setCenCus');
    try {
      return super.setCenCus(cencus: cencus);
    } finally {
      _$_CadastroCentroCustoControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading}
    ''';
  }
}
