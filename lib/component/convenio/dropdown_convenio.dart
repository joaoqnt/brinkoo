import 'package:brinquedoteca_flutter/model/convenio/convenio.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';


class DropdownConvenio extends StatelessWidget {
  bool required;
  bool enabled;
  Convenio? convenio;
  String? label;
  void Function(Convenio?)? onChanged;

  DropdownConvenio({
    super.key,
    this.required = true,
    this.enabled = true,
    this.convenio,
    this.onChanged,
    this.label,
  });

  final _repository = GenericRepository(endpoint: "/convenios", fromJson: (p0) => Convenio.fromJson(p0));
  List<Convenio> convenios = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: DropdownSearch<Convenio>(
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
            return convenios;
          } catch(e){
            return [];
          }
        },
        compareFn: (Convenio a, Convenio b) => a.id == b.id,
        itemAsString: (Convenio banco) => '${banco.descricao}',
        selectedItem: convenio,
        onChanged: onChanged,
        enabled: enabled,
        validator: required
            ? (value) => value == null ? 'Obrigatório' : null
            : null,
        decoratorProps: DropDownDecoratorProps(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.handshake_rounded),
            hintText: label??"Convenio",
            labelText: label??"Convenio",
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
