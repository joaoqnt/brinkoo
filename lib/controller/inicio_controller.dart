import 'package:brinquedoteca_flutter/controller/checkin/checkin_list_controller.dart';
import 'package:brinquedoteca_flutter/model/checkin.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'inicio_controller.g.dart';

class InicioController = _InicioController with _$InicioController;

abstract class _InicioController with Store {
  final checkinController = CheckinListController();
  final tecPesquisa = TextEditingController();
  @observable
  List<Checkin> checkins = ObservableList.of([]);

  Future<List<Checkin>> initAll() async{
    checkins = await checkinController.getCheckinsAberto();
    return checkins;
  }
}
