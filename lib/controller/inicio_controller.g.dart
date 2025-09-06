// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inicio_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$InicioController on _InicioController, Store {
  late final _$checkinsAtom = Atom(
    name: '_InicioController.checkins',
    context: context,
  );

  @override
  List<Checkin> get checkins {
    _$checkinsAtom.reportRead();
    return super.checkins;
  }

  @override
  set checkins(List<Checkin> value) {
    _$checkinsAtom.reportWrite(value, super.checkins, () {
      super.checkins = value;
    });
  }

  @override
  String toString() {
    return '''
checkins: ${checkins}
    ''';
  }
}
