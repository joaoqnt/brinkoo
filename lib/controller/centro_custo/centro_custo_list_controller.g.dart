// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'centro_custo_list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CentroCustoListController on _CentroCustoListController, Store {
  late final _$isLoadingAtom = Atom(
    name: '_CentroCustoListController.isLoading',
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

  late final _$centrosAtom = Atom(
    name: '_CentroCustoListController.centros',
    context: context,
  );

  @override
  List<CentroCusto> get centros {
    _$centrosAtom.reportRead();
    return super.centros;
  }

  @override
  set centros(List<CentroCusto> value) {
    _$centrosAtom.reportWrite(value, super.centros, () {
      super.centros = value;
    });
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
centros: ${centros}
    ''';
  }
}
