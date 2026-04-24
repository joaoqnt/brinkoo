import 'package:brinquedoteca_flutter/component/parceiro/card_parceiro.dart';
import 'package:brinquedoteca_flutter/model/parceiro.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../utils/responsive.dart';

class DropdownParceiro extends StatelessWidget {
  bool required;
  bool enabled;
  Parceiro? parceiro;
  void Function(Parceiro?)? onChanged;

  DropdownParceiro({
    super.key,
    this.required = true,
    this.enabled = true,
    this.parceiro,
    this.onChanged,
  });

  final _repository = GenericRepository(endpoint: "/parceiros", fromJson: (p0) => Parceiro.fromJson(p0));
  List<Parceiro> parceiros = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: DropdownSearch<Parceiro>(
        popupProps: PopupProps.menu(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            autofocus: true, // já abre com o teclado ativo
          ),
        ),
        items: (String filter, LoadProps? loadProps) async {
          try {
            final Map<String, dynamic> filtros = {'limit': 50,'ativo':true};

            if (filter.isNotEmpty) {
              filtros['nome'] = filter;
            }

            return await _repository.getAll(filters: filtros);
          } catch (e) {
            return [];
          }
        },
        compareFn: (Parceiro a, Parceiro b) => a.id == b.id,
        itemAsString: (Parceiro parceiro) => '${parceiro.nome}',
        selectedItem: parceiro,
        onChanged: onChanged,
        enabled: enabled,
        decoratorProps: DropDownDecoratorProps(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person),
            hintText: "Parceiro",
            labelText: "Parceiro",
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(),
            isDense: true,
          ),
        ),
        validator: required
            ? (value) => value == null ? 'Obrigatório' : null
            : null,
      ),
    );
  }

}
