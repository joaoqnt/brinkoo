// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forma_pagamento_list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FormaPagamentoListController on _FormaPagamentoListController, Store {
  late final _$isLoadingAtom = Atom(
    name: '_FormaPagamentoListController.isLoading',
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

  late final _$formasPagamentoAtom = Atom(
    name: '_FormaPagamentoListController.formasPagamento',
    context: context,
  );

  @override
  List<FormaPagamento> get formasPagamento {
    _$formasPagamentoAtom.reportRead();
    return super.formasPagamento;
  }

  @override
  set formasPagamento(List<FormaPagamento> value) {
    _$formasPagamentoAtom.reportWrite(value, super.formasPagamento, () {
      super.formasPagamento = value;
    });
  }

  late final _$getFormasPagamentoAsyncAction = AsyncAction(
    '_FormaPagamentoListController.getFormasPagamento',
    context: context,
  );

  @override
  Future<List<FormaPagamento>> getFormasPagamento() {
    return _$getFormasPagamentoAsyncAction.run(
      () => super.getFormasPagamento(),
    );
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
formasPagamento: ${formasPagamento}
    ''';
  }
}
