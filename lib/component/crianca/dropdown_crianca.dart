import 'package:brinquedoteca_flutter/component/crianca/card_crianca.dart';
import 'package:brinquedoteca_flutter/model/crianca.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../utils/responsive.dart';

class DropdownCrianca extends StatelessWidget {
  bool required;
  bool enabled;
  Crianca? crianca;
  void Function(Crianca?)? onChanged;

  DropdownCrianca({
    super.key,
    this.required = true,
    this.enabled = true,
    this.crianca,
    this.onChanged,
  });

  final _repository = GenericRepository(endpoint: "/criancas", fromJson: (p0) => Crianca.fromJson(p0));
  List<Crianca> criancas = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: DropdownSearch<Crianca>(

        popupProps: PopupProps.menu(
          showSearchBox: true,
          itemBuilder: (context, item, isDisabled, isSelected) => CardCrianca(crianca: item),
          searchFieldProps: TextFieldProps(
            autofocus: true, // já abre com o teclado ativo
          ),
        ),

        dropdownBuilder: (context, selectedItem) {
          if (selectedItem == null) {
            return const ListTile(
              leading: Icon(Icons.child_care),
              title: Text("Selecione uma criança"),
            );
          }
          return CardCrianca(crianca: selectedItem,enableOnTap: false);
        },
        items: (String filter, LoadProps? loadProps) async {
          try {
            final Map<String, dynamic> filtros = {'limit': 50,'ativo':true};

            if (filter.isNotEmpty) {
              filtros['unaccent(LOWER(c.nome))'] = filter;
            }

            return await _repository.getAll(filters: filtros);
          } catch (e) {
            return [];
          }
        },
        compareFn: (Crianca a, Crianca b) => a.id == b.id,
        itemAsString: (Crianca banco) => '${banco.nome}',
        selectedItem: crianca,
        onChanged: onChanged,
        enabled: enabled,
        validator: required
            ? (value) => value == null ? 'Obrigatório' : null
            : null,
      ),
    );
  }

}
