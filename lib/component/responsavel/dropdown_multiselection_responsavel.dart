import 'package:brasil_fields/brasil_fields.dart';
import 'package:brinquedoteca_flutter/component/crianca/card_crianca.dart';
import 'package:brinquedoteca_flutter/component/responsavel/card_responsavel.dart';
import 'package:brinquedoteca_flutter/events/image_preview_dialog.dart';
import 'package:brinquedoteca_flutter/model/crianca.dart';
import 'package:brinquedoteca_flutter/model/responsavel.dart';
import 'package:brinquedoteca_flutter/repository/generic/generic_repository.dart';
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

  void _onChipTapped(Responsavel responsavel, bool selected) {
    setState(() {
      if (selected) {
        _selected.add(responsavel);
      } else {
        _selected.removeWhere((r) => r.id == responsavel.id);
      }
    });

    if (widget.onChanged != null) {
      widget.onChanged!(_selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: widget.responsaveis.map((responsavel) {
        final isSelected = _selected
            .any((r) => r.id == responsavel.id);

        return FilterChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(responsavel.nome ?? ''),
                  Row(
                    children: [
                      const Icon(Icons.phone, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        UtilBrasilFields.obterTelefone(responsavel.celular??''),
                        // responsavel.celular??'',
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
              if (isSelected) ...[
                const SizedBox(width: 6),
                const Icon(
                  Icons.check,
                  size: 18,
                  color: Colors.green,
                ),
              ],
            ],
          ),
          selected: isSelected,
          onSelected: widget.enabled
              ? (bool selected) =>
              _onChipTapped(responsavel, selected)
              : null,
          avatar: InkWell(
            onTap: responsavel.urlImage != null && responsavel.urlImage!.isNotEmpty
                ? () => ImagePreviewDialog.show(context, imageUrl: responsavel.urlImage!)
                : null,
            child: CircleAvatar(
              radius: 30,
              backgroundImage: responsavel.urlImage != null && responsavel.urlImage!.isNotEmpty
                  ? NetworkImage(responsavel.urlImage!)
                  : null,
              child: responsavel.urlImage == null || responsavel.urlImage!.isEmpty
                  ? const Icon(Icons.person, size: 30)
                  : null,
            ),
          ),
        );
      }).toList(),
    );
  }
}