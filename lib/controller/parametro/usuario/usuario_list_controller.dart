import 'package:brinquedoteca_flutter/model/usuario.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:brinquedoteca_flutter/utils/date_helper_util.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'usuario_list_controller.g.dart';

class UsuarioListController = _UsuarioListController with _$UsuarioListController;

abstract class _UsuarioListController with Store {
  final _usuariosRepository = GenericRepository(
      endpoint: "usuarios",
      fromJson:(p0) => Usuario.fromJson(p0),
  );
  TextEditingController tecPesquisa = TextEditingController();
  @observable
  bool isLoading = false;
  @observable
  List<Usuario> usuarios = ObservableList.of([]);

  Future<List<Usuario>> getUsuarios() async{
    try{
      usuarios = await _usuariosRepository.getAll();
    } catch(e){
      print(e);
    }
    return usuarios;
  }
}
