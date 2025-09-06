import 'package:brinquedoteca_flutter/model/atividade.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../utils/responsive.dart';

class DropdownAtividade extends StatelessWidget {
  bool required;
  List<Atividade>? atividadesSelected;
  void Function(List<Atividade>?)? onChanged;

  DropdownAtividade({
    super.key,
    this.required = true,
    this.atividadesSelected,
    this.onChanged,
  });

  final _repository = GenericRepository(endpoint: "/atividades", fromJson: (p0) => Atividade.fromJson(p0));
  List<Atividade> atividades = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: DropdownSearch<Atividade>.multiSelection(
        items: (String filter, LoadProps? loadProps) async{
          try{
            return await _repository.getAll();
          } catch(e){
            return [];
          }
        },
        compareFn: (Atividade a, Atividade b) => a.id == b.id,
        itemAsString: (Atividade banco) => '${banco.descricao}',
        onChanged: onChanged,
        validator: required
            ? (value) => value == null ? 'Obrigatório' : null
            : null,
        selectedItems: atividadesSelected??[],
        decoratorProps: DropDownDecoratorProps(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.toys),
            hintText: "Selecione as atividades permitidas",
            labelText: "Atividades",
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }

}