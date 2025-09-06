// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cadastro_guarda_volume_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CadastroGuardaVolumeController
    on _CadastroGuardaVolumeController, Store {
  late final _$isLoadingAtom = Atom(
    name: '_CadastroGuardaVolumeController.isLoading',
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

  late final _$createGuardaVolumeAsyncAction = AsyncAction(
    '_CadastroGuardaVolumeController.createGuardaVolume',
    context: context,
  );

  @override
  Future<dynamic> createGuardaVolume(BuildContext context) {
    return _$createGuardaVolumeAsyncAction.run(
      () => super.createGuardaVolume(context),
    );
  }

  late final _$updateGuardaVolumeAsyncAction = AsyncAction(
    '_CadastroGuardaVolumeController.updateGuardaVolume',
    context: context,
  );

  @override
  Future<dynamic> updateGuardaVolume(
    BuildContext context,
    GuardaVolume guardaVolume,
  ) {
    return _$updateGuardaVolumeAsyncAction.run(
      () => super.updateGuardaVolume(context, guardaVolume),
    );
  }

  late final _$_CadastroGuardaVolumeControllerActionController =
      ActionController(
        name: '_CadastroGuardaVolumeController',
        context: context,
      );

  @override
  void setGuardaVolume({GuardaVolume? guardaVolume}) {
    final _$actionInfo = _$_CadastroGuardaVolumeControllerActionController
        .startAction(name: '_CadastroGuardaVolumeController.setGuardaVolume');
    try {
      return super.setGuardaVolume(guardaVolume: guardaVolume);
    } finally {
      _$_CadastroGuardaVolumeControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading}
    ''';
  }
}
