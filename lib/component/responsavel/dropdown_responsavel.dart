import 'package:brinquedoteca_flutter/component/crianca/card_crianca.dart';
import 'package:brinquedoteca_flutter/component/responsavel/card_responsavel.dart';
import 'package:brinquedoteca_flutter/model/crianca.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../utils/responsive.dart';

class DropdownResponsavel extends StatelessWidget {
  bool required;
  bool enabled;
  List<Responsavel>? responsaveis;
  Responsavel? responsavel;
  void Function(Responsavel?)? onChanged;
  bool checkin = true;
  String? title;

  DropdownResponsavel({
    super.key,
    this.required = true,
    this.enabled = true,
    this.checkin = true,
    this.responsavel,
    this.onChanged,
    this.responsaveis,
    this.title,
  });

  List<Crianca> criancas = [];

  final _responsavelRepository = GenericRepository(
    endpoint: "responsaveis",
    fromJson:(p0) => Responsavel.fromJson(p0),
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: DropdownSearch<Responsavel>(
        popupProps: PopupProps.menu(
          showSearchBox: true,
          itemBuilder: (context, item, isDisabled, isSelected) => CardResponsavel(responsavel: item),
        ),
        dropdownBuilder: (context, selectedItem) {
          if (selectedItem == null || selectedItem.nome == null) {
            return ListTile(
              leading: Icon(Icons.person),
              title: Text(title??"Selecione um responsável pelo ${checkin ? "check-in" : "check-out"}"),
            );
          }
          return CardResponsavel(responsavel: selectedItem,enableOnTap: false,);
        },
        items: (String filter, LoadProps? loadProps) async{
          try{
            if(responsaveis != null) {
              return responsaveis!;
            } else {
              responsaveis = await _responsavelRepository.getAll();
              return responsaveis!;
            }
          } catch(e){
            return [];
          }
        },
        compareFn: (Responsavel a, Responsavel b) => a.id == b.id,
        itemAsString: (Responsavel banco) => '${banco.nome}',
        selectedItem: responsavel,
        onChanged: onChanged,
        enabled: enabled,
        validator: required
            ? (value) => value == null ? 'Obrigatório' : null
            : null,
      ),
    );
  }

}
