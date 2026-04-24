import 'package:brinquedoteca_flutter/model/guarda_volume.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../utils/responsive.dart';

class DropdownGuardaVolume extends StatelessWidget {
  bool required;
  bool enabled;
  GuardaVolume? guardaVolume;
  void Function(GuardaVolume?)? onChanged;

  DropdownGuardaVolume({
    super.key,
    this.required = true,
    this.enabled = true,
    this.guardaVolume,
    this.onChanged,
  });

  final _repository = GenericRepository(endpoint: "/guardas-volume", fromJson: (p0) => GuardaVolume.fromJson(p0));
  List<GuardaVolume> guardasVolume = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: DropdownSearch<GuardaVolume>(
        popupProps: PopupProps.menu(
          showSearchBox: true,
        ),
        items: (String filter, LoadProps? loadProps) async{
          try{
            return await _repository.getAll(
                filters: {
                  if(filter.isNotEmpty)
                    'descricao': filter,
                  if(Singleton.instance.usuario?.empresa != null)
                    'empresa': Singleton.instance.usuario?.empresa?.id,
                  'ativo':true
                }
            );
            return guardasVolume;
          } catch(e){
            return [];
          }
        },
        compareFn: (GuardaVolume a, GuardaVolume b) => a.id == b.id,
        itemAsString: (GuardaVolume banco) => '${banco.descricao}',
        selectedItem: guardaVolume,
        onChanged: onChanged,
        enabled: enabled,
        validator: required
            ? (value) => value == null ? 'Obrigatório' : null
            : null,
        decoratorProps: DropDownDecoratorProps(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.door_sliding),
            hintText: "Guarda Volume",
            labelText: "Guarda Volume",
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
