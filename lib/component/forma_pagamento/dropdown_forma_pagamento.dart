import 'package:brinquedoteca_flutter/model/forma_pagamento.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../utils/responsive.dart';

class DropdownFormaPagamento extends StatelessWidget {
  bool required;
  bool enabled;
  FormaPagamento? formaPagamento;
  void Function(FormaPagamento?)? onChanged;

  DropdownFormaPagamento({
    super.key,
    this.required = true,
    this.enabled = true,
    this.formaPagamento,
    this.onChanged,
  });

  final _repository = GenericRepository(endpoint: "/forma_pagamento", fromJson: (p0) => FormaPagamento.fromJson(p0));
  List<FormaPagamento> formasPagamento = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: DropdownSearch<FormaPagamento>(
        popupProps: PopupProps.menu(
          showSearchBox: true,
        ),
        items: (String filter, LoadProps? loadProps) async{
          try{
            return await _repository.getAll(filters: {'descricao': filter,'ativo':true});
            return formasPagamento;
          } catch(e){
            return [];
          }
        },
        compareFn: (FormaPagamento a, FormaPagamento b) => a.id == b.id,
        itemAsString: (FormaPagamento banco) => '${banco.descricao}',
        selectedItem: formaPagamento,
        onChanged: onChanged,
        enabled: enabled,
        validator: required
            ? (value) => value == null ? 'Obrigatório' : null
            : null,
        decoratorProps: DropDownDecoratorProps(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.door_sliding),
            hintText: "Forma Pagamento",
            labelText: "Forma Pagamento",
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
