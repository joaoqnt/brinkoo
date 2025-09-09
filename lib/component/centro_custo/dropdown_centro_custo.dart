import 'package:brinquedoteca_flutter/model/centro_custo.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../utils/responsive.dart';

class DropdownCentroCusto extends StatelessWidget {
  bool required;
  bool enabled;
  CentroCusto? centroCusto;
  void Function(CentroCusto?)? onChanged;

  DropdownCentroCusto({
    super.key,
    this.required = true,
    this.enabled = true,
    this.centroCusto,
    this.onChanged,
  });

  final _repository = GenericRepository(endpoint: "/centros-custo", fromJson: (p0) => CentroCusto.fromJson(p0));
  List<CentroCusto> centrosCusto = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: DropdownSearch<CentroCusto>(
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
            return centrosCusto;
          } catch(e){
            return [];
          }
        },
        compareFn: (CentroCusto a, CentroCusto b) => a.id == b.id,
        itemAsString: (CentroCusto banco) => '${banco.descricao}',
        selectedItem: centroCusto,
        onChanged: onChanged,
        enabled: enabled,
        validator: required
            ? (value) => value == null ? 'Obrigatório' : null
            : null,
        decoratorProps: DropDownDecoratorProps(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.business_center),
            hintText: "Centro de Custo",
            labelText: "Centro de Custo",
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
