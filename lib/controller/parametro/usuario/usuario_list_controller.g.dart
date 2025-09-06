// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario_list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UsuarioListController on _UsuarioListController, Store {
  late final _$isLoadingAtom = Atom(
    name: '_UsuarioListController.isLoading',
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

  late final _$usuariosAtom = Atom(
    name: '_UsuarioListController.usuarios',
    context: context,
  );

  @override
  List<Usuario> get usuarios {
    _$usuariosAtom.reportRead();
    return super.usuarios;
  }

  @override
  set usuarios(List<Usuario> value) {
    _$usuariosAtom.reportWrite(value, super.usuarios, () {
      super.usuarios = value;
    });
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
usuarios: ${usuarios}
    ''';
  }
}
