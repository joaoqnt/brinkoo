import 'package:brinquedoteca_flutter/component/crianca/card_crianca.dart';
import 'package:brinquedoteca_flutter/component/responsavel/card_responsavel.dart';
import 'package:brinquedoteca_flutter/model/crianca.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../utils/responsive.dart';

class DropdownMultiselectionResponsavel extends StatelessWidget {
  bool required;
  bool enabled;
  List<Responsavel> responsaveis;
  List<Responsavel>? responsaveisSelected;
  void Function(List<Responsavel>?)? onChanged;
  bool checkin = true;

  DropdownMultiselectionResponsavel({
    super.key,
    this.required = true,
    this.enabled = true,
    this.checkin = true,
    this.responsaveisSelected,
    this.onChanged,
    required this.responsaveis
  });

  List<Crianca> criancas = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: DropdownSearch<Responsavel>.multiSelection(
        popupProps: PopupPropsMultiSelection.menu(
          showSearchBox: true,
          itemBuilder: (context, item, isDisabled, isSelected) => CardResponsavel(responsavel: item),
        ),
        //dropdownBuilder: (context, selectedItem) {
        //  if (selectedItem.isEmpty) {
        //    return ListTile(
        //      leading: Icon(Icons.person),
        //      title: Text("Selecione quem pode ser responsável pelo ${checkin ? "check-in" : "check-out"}"),
        //    );
        //  }
        //},
        items: (String filter, LoadProps? loadProps) async{
          try{
            return responsaveis;
          } catch(e){
            return [];
          }
        },
        compareFn: (Responsavel a, Responsavel b) => a.id == b.id,
        itemAsString: (Responsavel banco) => '${banco.nome}',
        selectedItems: responsaveisSelected??[],
        decoratorProps: DropDownDecoratorProps(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person),
            hintText: "Selecione os responsáveis permitidos",
            labelText: "Responsáveis",
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(),
          ),
        ),
        onChanged: onChanged,
        enabled: enabled,
        validator: required
            ? (value) => value == null ? 'Obrigatório' : null
            : null,
      ),
    );
  }

}
