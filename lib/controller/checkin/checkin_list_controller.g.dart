// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkin_list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CheckinListController on _CheckinListController, Store {
  late final _$isLoadingAtom = Atom(
    name: '_CheckinListController.isLoading',
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

  late final _$checkinsAtom = Atom(
    name: '_CheckinListController.checkins',
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

  late final _$pageAtom = Atom(
    name: '_CheckinListController.page',
    context: context,
  );

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  late final _$getCheckinsAsyncAction = AsyncAction(
    '_CheckinListController.getCheckins',
    context: context,
  );

  @override
  Future<void> getCheckins({bool refresh = false}) {
    return _$getCheckinsAsyncAction.run(
      () => super.getCheckins(refresh: refresh),
    );
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
checkins: ${checkins},
page: ${page}
    ''';
  }
}
