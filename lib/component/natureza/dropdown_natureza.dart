import 'package:brinquedoteca_flutter/model/natureza.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../utils/responsive.dart';

class DropdownNatureza extends StatelessWidget {
  bool required;
  bool enabled;
  Natureza? natureza;
  void Function(Natureza?)? onChanged;

  DropdownNatureza({
    super.key,
    this.required = true,
    this.enabled = true,
    this.natureza,
    this.onChanged,
  });

  final _repository = GenericRepository(endpoint: "/naturezas", fromJson: (p0) => Natureza.fromJson(p0));
  List<Natureza> naturezas = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: DropdownSearch<Natureza>(
        popupProps: PopupProps.menu(
          showSearchBox: true,
        ),
        items: (String filter, LoadProps? loadProps) async{
          try{
            return await _repository.getAll(
                filters: {
                  if(filter.isNotEmpty)
                    'descricao': filter,
                  'ativo':true
                }
            );
            return naturezas;
          } catch(e){
            return [];
          }
        },
        compareFn: (Natureza a, Natureza b) => a.id == b.id,
        itemAsString: (Natureza banco) => '${banco.descricao}',
        selectedItem: natureza,
        onChanged: onChanged,
        enabled: enabled,
        validator: required
            ? (value) => value == null ? 'Obrigatório' : null
            : null,
        decoratorProps: DropDownDecoratorProps(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.category),
            hintText: "Naturezas",
            labelText: "Naturezas",
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(),
            isDense: true,
          ),
        ),
      ),
    );
  }

}
