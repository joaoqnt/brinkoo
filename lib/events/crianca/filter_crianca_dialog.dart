import 'package:brinquedoteca_flutter/component/custom_textformfield.dart';
import 'package:brinquedoteca_flutter/controller/crianca/crianca_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FilterCriancaDialog{
  void show(BuildContext context,CriancaListController controller) {
    showDialog(
      context: context,
      builder: (_) {
        return Observer(
          builder: (context) {
            return AlertDialog(
              title: Row(
                children: [
                  Expanded(child: Text("Filtros")),
                  TextButton(
                      onPressed: () async{
                        await controller.resetarFiltros();
                      },
                      child: Text("Limpar filtros")
                  )
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: controller.filtersConfig.entries.map((entry) {
                    String label = entry.key;
                    String campo = entry.value.keys.first;
                    TextEditingController tec = entry.value.values.first;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: CustomTextFormField(
                        controller: tec,
                        labelText: label,
                        suffixIcon: IconButton(
                          tooltip: "Limpar texto",
                          onPressed: controller.isLoading ? null : () {
                            tec.clear();
                          },
                          icon: Icon(Icons.clear,color: Colors.grey),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancelar"),
                ),
                FilledButton(
                  onPressed: controller.isLoading ? null : () async{
                    await controller.getCriancas(reset: true);
                    // aplicarFiltros();
                    Navigator.pop(context);
                  },
                  child: controller.isLoading
                      ? SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ) : Text("Aplicar"),
                ),
              ],
            );
          }
        );
      },
    );
  }
}