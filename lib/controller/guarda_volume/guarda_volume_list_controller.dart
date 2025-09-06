import 'package:brinquedoteca_flutter/model/guarda_volume.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'guarda_volume_list_controller.g.dart';

class GuardaVolumeListController = _GuardaVolumeListController with _$GuardaVolumeListController;

abstract class _GuardaVolumeListController with Store {
  final _guardasVolumeRepository = GenericRepository(
      endpoint: "guardas-volume",
      fromJson:(p0) => GuardaVolume.fromJson(p0),
  );
  TextEditingController tecPesquisa = TextEditingController();
  @observable
  bool isLoading = false;
  @observable
  List<GuardaVolume> guardasVoulme = ObservableList.of([]);

  Future<List<GuardaVolume>> getGuardasVolumes() async{
    try{
      guardasVoulme = await _guardasVolumeRepository.getAll();
    } catch(e){
      print(e);
    }
    return guardasVoulme;
  }
}
