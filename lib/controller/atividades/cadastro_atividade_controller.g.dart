// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cadastro_atividade_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CadastroAtividadeController on _CadastroAtividadeController, Store {
  late final _$isLoadingAtom = Atom(
    name: '_CadastroAtividadeController.isLoading',
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

  late final _$createAtividadeAsyncAction = AsyncAction(
    '_CadastroAtividadeController.createAtividade',
    context: context,
  );

  @override
  Future<dynamic> createAtividade(BuildContext context) {
    return _$createAtividadeAsyncAction.run(
      () => super.createAtividade(context),
    );
  }

  late final _$updateAtividadeAsyncAction = AsyncAction(
    '_CadastroAtividadeController.updateAtividade',
    context: context,
  );

  @override
  Future<dynamic> updateAtividade(BuildContext context, Atividade atividade) {
    return _$updateAtividadeAsyncAction.run(
      () => super.updateAtividade(context, atividade),
    );
  }

  late final _$_CadastroAtividadeControllerActionController = ActionController(
    name: '_CadastroAtividadeController',
    context: context,
  );

  @override
  void setAtividade({Atividade? atividade}) {
    final _$actionInfo = _$_CadastroAtividadeControllerActionController
        .startAction(name: '_CadastroAtividadeController.setAtividade');
    try {
      return super.setAtividade(atividade: atividade);
    } finally {
      _$_CadastroAtividadeControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading}
    ''';
  }
}
