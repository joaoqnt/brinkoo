import 'package:flutter/material.dart';

class AlertAtividade extends StatelessWidget {
  const AlertAtividade({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        // Um fundo laranja bem suave para não agredir a vista
        color: Colors.orange.shade50.withOpacity(0.8),
        borderRadius: BorderRadius.circular(8),
        // Uma borda fina ajuda a definir o limite do aviso
        border: Border.all(
          color: Colors.orange.shade200,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Ocupa apenas o espaço necessário
        children: [
          Icon(
            Icons.warning_amber_rounded, // Ícone arredondado costuma ser mais amigável
            size: 16, // Aumentei levemente para equilibrar com o texto
            color: Colors.orange.shade800, // Tom mais escuro para melhor contraste/leitura
          ),
          const SizedBox(width: 8), // Espaçamento maior entre ícone e texto
          Text(
            "Verificar permissão",
            style: TextStyle(
              color: Colors.orange.shade900, // Quase um marrom-laranja para acessibilidade
              fontSize: 12,
              fontWeight: FontWeight.w600, // Semi-bold fica mais limpo que o Bold total
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
