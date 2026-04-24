import 'package:brinquedoteca_flutter/model/servico_nfse.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../utils/responsive.dart';

class DropdownServicoNfse extends StatelessWidget {
  bool required;
  bool enabled;
  ServicoNfse? servicoSelected;
  void Function(ServicoNfse?)? onChanged;

  DropdownServicoNfse({
    super.key,
    this.required = true,
    this.enabled = true,
    this.servicoSelected,
    this.onChanged,
  });

  final _repository = GenericRepository(endpoint: "/servicos_nfse", fromJson: (p0) => ServicoNfse.fromJson(p0));
  List<ServicoNfse> servicos = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: DropdownSearch<ServicoNfse>(
        popupProps: PopupProps.menu(
          showSearchBox: true,
        ),
        items: (String filter, LoadProps? loadProps) async{
          try{
            return await _repository.getAll();
            return servicos;
          } catch(e){
            return [];
          }
        },
        compareFn: (ServicoNfse a, ServicoNfse b) => a.id == b.id,
        itemAsString: (ServicoNfse banco) => '${banco.descricao}',
        selectedItem: servicoSelected,
        onChanged: onChanged,
        enabled: enabled,
        validator: required
            ? (value) => value == null ? 'Obrigatório' : null
            : null,
        decoratorProps: DropDownDecoratorProps(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.business_center),
            hintText: "Serviço",
            labelText: "Serviço",
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
