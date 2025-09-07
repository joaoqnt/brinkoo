import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../model/empresa.dart';
import '../../utils/responsive.dart';

class DropdownEmpresa extends StatelessWidget {
  bool required;
  Empresa? empresaSelected;
  void Function(Empresa?)? onChanged;

  DropdownEmpresa({
    super.key,
    this.required = true,
    this.empresaSelected,
    this.onChanged,
  });

  final _repository = GenericRepository(endpoint: "/empresas", fromJson: (p0) => Empresa.fromJson(p0));
  List<Empresa> empresas = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: DropdownSearch<Empresa>(
        items: (String filter, LoadProps? loadProps) async{
          try{
            return await _repository.getAll();
          } catch(e){
            return [];
          }
        },
        compareFn: (Empresa a, Empresa b) => a.id == b.id,
        itemAsString: (Empresa banco) => '${banco.descricao}',
        onChanged: onChanged,
        validator: required
            ? (value) => value == null ? 'Obrigatório' : null
            : null,
        selectedItem: empresaSelected,
        decoratorProps: DropDownDecoratorProps(
          decoration: InputDecoration(
            hintText: "Selecione a empresa vinculada",
            labelText: "Empresa",
            filled: true,
            isDense: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }

}