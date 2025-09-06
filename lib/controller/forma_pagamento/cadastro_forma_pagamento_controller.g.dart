// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cadastro_forma_pagamento_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CadastroFormaPagamentoController
    on _CadastroFormaPagamentoController, Store {
  late final _$isLoadingAtom = Atom(
    name: '_CadastroFormaPagamentoController.isLoading',
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

  late final _$isAtivoAtom = Atom(
    name: '_CadastroFormaPagamentoController.isAtivo',
    context: context,
  );

  @override
  bool get isAtivo {
    _$isAtivoAtom.reportRead();
    return super.isAtivo;
  }

  @override
  set isAtivo(bool value) {
    _$isAtivoAtom.reportWrite(value, super.isAtivo, () {
      super.isAtivo = value;
    });
  }

  late final _$createFormaPagamentoAsyncAction = AsyncAction(
    '_CadastroFormaPagamentoController.createFormaPagamento',
    context: context,
  );

  @override
  Future<dynamic> createFormaPagamento(BuildContext context) {
    return _$createFormaPagamentoAsyncAction.run(
      () => super.createFormaPagamento(context),
    );
  }

  late final _$updateFormaPagamentoAsyncAction = AsyncAction(
    '_CadastroFormaPagamentoController.updateFormaPagamento',
    context: context,
  );

  @override
  Future<dynamic> updateFormaPagamento(
    BuildContext context,
    FormaPagamento forma,
  ) {
    return _$updateFormaPagamentoAsyncAction.run(
      () => super.updateFormaPagamento(context, forma),
    );
  }

  late final _$_CadastroFormaPagamentoControllerActionController =
      ActionController(
        name: '_CadastroFormaPagamentoController',
        context: context,
      );

  @override
  void setFormaPagamento({FormaPagamento? formaPagamento}) {
    final _$actionInfo = _$_CadastroFormaPagamentoControllerActionController
        .startAction(
          name: '_CadastroFormaPagamentoController.setFormaPagamento',
        );
    try {
      return super.setFormaPagamento(formaPagamento: formaPagamento);
    } finally {
      _$_CadastroFormaPagamentoControllerActionController.endAction(
        _$actionInfo,
      );
    }
  }

  @override
  dynamic setAtivo(bool value) {
    final _$actionInfo = _$_CadastroFormaPagamentoControllerActionController
        .startAction(name: '_CadastroFormaPagamentoController.setAtivo');
    try {
      return super.setAtivo(value);
    } finally {
      _$_CadastroFormaPagamentoControllerActionController.endAction(
        _$actionInfo,
      );
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isAtivo: ${isAtivo}
    ''';
  }
}
