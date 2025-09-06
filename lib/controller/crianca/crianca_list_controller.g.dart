// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crianca_list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CriancaListController on _CriancaListController, Store {
  late final _$isLoadingAtom = Atom(
    name: '_CriancaListController.isLoading',
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

  late final _$hasMoreAtom = Atom(
    name: '_CriancaListController.hasMore',
    context: context,
  );

  @override
  bool get hasMore {
    _$hasMoreAtom.reportRead();
    return super.hasMore;
  }

  @override
  set hasMore(bool value) {
    _$hasMoreAtom.reportWrite(value, super.hasMore, () {
      super.hasMore = value;
    });
  }

  late final _$criancasAtom = Atom(
    name: '_CriancaListController.criancas',
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

  late final _$getCriancasAsyncAction = AsyncAction(
    '_CriancaListController.getCriancas',
    context: context,
  );

  @override
  Future<void> getCriancas({bool reset = false}) {
    return _$getCriancasAsyncAction.run(() => super.getCriancas(reset: reset));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
hasMore: ${hasMore},
criancas: ${criancas}
    ''';
  }
}
