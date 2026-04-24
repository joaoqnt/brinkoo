import 'package:brinquedoteca_flutter/component/atividade/alert_atividade.dart';
import 'package:brinquedoteca_flutter/component/custom/custom_selectable_card.dart';
import 'package:brinquedoteca_flutter/model/atividade.dart';
import 'package:brinquedoteca_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../style.dart';

class ListAtividade extends StatefulWidget {
  final List<Atividade> atividades;
  final List<Atividade> atividadesSelected;
  final Function(Atividade atividade, bool selected) onSelected;

  const ListAtividade({
    super.key,
    required this.atividades,
    required this.atividadesSelected,
    required this.onSelected,
  });

  @override
  State<ListAtividade> createState() => _ListAtividadeState();
}

class _ListAtividadeState extends State<ListAtividade> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {

        return Column(
          spacing: 10,
          children: [
            for(int index = 0; index < widget.atividades.length; index++ )
              Builder(
                  builder: (context) {
                    final atividade = widget.atividades[index];
                    final isSelected = widget.atividadesSelected.any((a) => a.id == atividade.id);
                    final iconeData = Utils().getIconeAtividadeByName(atividade.icone ?? "");
                    return SelectableCard(
                      selected: isSelected,
                      title: atividade.nome ?? '',
                      onTap: () {
                        widget.onSelected(atividade, !isSelected);
                        setState(() {});
                      },
                      leading: SizedBox(
                        width: 35,
                        height: 35,
                        child: iconeData != null
                            ? Image.asset("assets/${iconeData.pathImage}")
                            : const Icon(Icons.toys),
                      ),
                      subtitle: Text(
                        atividade.descricao ?? '',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      trailing: atividade.padrao == false
                          ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AlertAtividade(),
                          const SizedBox(width: 6),
                          Text(isSelected ? "Sim" : "Não"),
                        ],
                      )
                          : null,
                    );
                  },
              )
          ],
        );
      },
    );
  }
}