import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/crianca/card_crianca.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_selectable_card.dart';
import 'package:brinquedoteca_flutter/component/responsavel/card_responsavel.dart';
import 'package:brinquedoteca_flutter/events/image_preview_dialog.dart';
import 'package:brinquedoteca_flutter/model/crianca.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
import 'package:brinquedoteca_flutter/style.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../utils/responsive.dart';

class DropdownMultiselectionResponsavel extends StatefulWidget {
  final bool required;
  final bool enabled;
  final List<Responsavel> responsaveis;
  final List<Responsavel>? responsaveisSelected;
  final void Function(List<Responsavel>?)? onChanged;
  final bool checkin;

  const DropdownMultiselectionResponsavel({
    super.key,
    this.required = true,
    this.enabled = true,
    this.checkin = true,
    this.responsaveisSelected,
    this.onChanged,
    required this.responsaveis,
  });

  @override
  State<DropdownMultiselectionResponsavel> createState() =>
      _DropdownMultiselectionResponsavelState();
}

class _DropdownMultiselectionResponsavelState
    extends State<DropdownMultiselectionResponsavel> {

  late List<Responsavel> _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.responsaveisSelected ?? [];
  }

  void _onTapped(Responsavel responsavel, bool selected) {
    setState(() {
      if (selected) {
        _selected.add(responsavel);
      } else {
        _selected.removeWhere((r) => r.id == responsavel.id);
      }
    });

    widget.onChanged?.call(_selected);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: widget.responsaveis.map((responsavel) {

        final isSelected = _selected.any((r) => r.id == responsavel.id);

        return SelectableCard(
          selected: isSelected,
          onTap: () => _onTapped(responsavel, !isSelected),
          title: responsavel.nome ?? '',
          leading: CircleAvatar(
            radius: 20,
            backgroundImage: responsavel.urlImage != null
                ? NetworkImage(responsavel.urlImage!)
                : null,
          ),
          subtitle: Row(
            children: [
              const Icon(Icons.phone, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                UtilBrasilFields.obterTelefone(responsavel.celular ?? ''),
                style: const TextStyle(fontSize: 13),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}