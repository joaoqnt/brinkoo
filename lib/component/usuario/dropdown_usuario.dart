import 'package:brinquedoteca_flutter/component/usuario/card_usuario.dart';
import 'package:brinquedoteca_flutter/model/usuario.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../utils/responsive.dart';

class DropdownUsuario extends StatelessWidget {
  bool required;
  bool enabled;
  Usuario? usuario;
  void Function(Usuario?)? onChanged;

  DropdownUsuario({
    super.key,
    this.required = true,
    this.enabled = true,
    this.usuario,
    this.onChanged,
  });

  final _repository = GenericRepository(endpoint: "usuarios", fromJson: (p0) => Usuario.fromJson(p0));
  List<Usuario> usuarios = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: DropdownSearch<Usuario>(

        popupProps: PopupProps.menu(
          showSearchBox: true,
          itemBuilder: (context, item, isDisabled, isSelected) => CardUsuario(usuario: item),
          searchFieldProps: TextFieldProps(
            autofocus: true, // já abre com o teclado ativo
          ),
        ),

        dropdownBuilder: (context, selectedItem) {
          if (selectedItem == null) {
            return const ListTile(
              leading: Icon(Icons.person),
              title: Text("Selecione um atendente"),
            );
          }
          return CardUsuario(usuario: selectedItem,enableOnTap: false);
        },
        items: (String filter, LoadProps? loadProps) async {
          try {
            final Map<String, dynamic> filtros = {'limit': 50};

            if (filter.isNotEmpty) {
              filtros['login'] = filter;
            }

            return await _repository.getAll(filters: filtros);
          } catch (e) {
            return [];
          }
        },
        compareFn: (Usuario a, Usuario b) => a.id == b.id,
        itemAsString: (Usuario banco) => '${banco.nome}',
        selectedItem: usuario,
        onChanged: onChanged,
        enabled: enabled,
        validator: required
            ? (value) => value == null ? 'Obrigatório' : null
            : null,
      ),
    );
  }

}
