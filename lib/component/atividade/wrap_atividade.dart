import 'package:brinquedoteca_flutter/model/atividade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class WrapAtividade extends StatefulWidget {
  final List<Atividade> atividades;
  final List<Atividade> atividadesSelected;
  final Function(Atividade atividade, bool selected) onSelected;

  const WrapAtividade({
    super.key,
    required this.atividades,
    required this.atividadesSelected,
    required this.onSelected,
  });

  @override
  State<WrapAtividade> createState() => _WrapAtividadeState();
}

class _WrapAtividadeState extends State<WrapAtividade> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return InputDecorator(
          decoration: InputDecoration(
            labelText: 'Atividades permitidas',
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            // contentPadding: EdgeInsets.all(12),
          ),
          child: Wrap(
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: 12,
            runSpacing: 8,
            children: widget.atividades.map((atividade) {
              final isSelected = widget.atividadesSelected
                  .any((a) => a.id == atividade.id);

              return FilterChip(
                label: Text(atividade.descricao ?? ''),
                selected: isSelected,
                onSelected: (value) {
                  widget.onSelected(atividade, value);
                  setState(() {});
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}