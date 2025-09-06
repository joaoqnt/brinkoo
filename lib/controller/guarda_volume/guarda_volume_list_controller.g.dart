// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guarda_volume_list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GuardaVolumeListController on _GuardaVolumeListController, Store {
  late final _$isLoadingAtom = Atom(
    name: '_GuardaVolumeListController.isLoading',
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

  late final _$guardasVoulmeAtom = Atom(
    name: '_GuardaVolumeListController.guardasVoulme',
    context: context,
  );

  @override
  List<GuardaVolume> get guardasVoulme {
    _$guardasVoulmeAtom.reportRead();
    return super.guardasVoulme;
  }

  @override
  set guardasVoulme(List<GuardaVolume> value) {
    _$guardasVoulmeAtom.reportWrite(value, super.guardasVoulme, () {
      super.guardasVoulme = value;
    });
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
guardasVoulme: ${guardasVoulme}
    ''';
  }
}
