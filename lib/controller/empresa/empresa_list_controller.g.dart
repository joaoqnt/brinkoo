// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'empresa_list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EmpresaListController on _EmpresaListController, Store {
  late final _$isLoadingAtom = Atom(
    name: '_EmpresaListController.isLoading',
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

  late final _$empresasAtom = Atom(
    name: '_EmpresaListController.empresas',
    context: context,
  );

  @override
  List<Empresa> get empresas {
    _$empresasAtom.reportRead();
    return super.empresas;
  }

  @override
  set empresas(List<Empresa> value) {
    _$empresasAtom.reportWrite(value, super.empresas, () {
      super.empresas = value;
    });
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
empresas: ${empresas}
    ''';
  }
}
