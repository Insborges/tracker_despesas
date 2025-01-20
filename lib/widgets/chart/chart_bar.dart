import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({
    super.key,
    required this.fill,
  });

  // Percentagem de preenchimento da barra (valor entre 0 e 1)
  final double fill;

  @override
  Widget build(BuildContext context) {
    // Verifica se o modo escuro está ativo no sistema
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 4), // Espaço lateral para cada barra
        child: FractionallySizedBox(
          heightFactor: fill, // Define a altura proporcional ao valor de "fill"
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle, // Forma retangular
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8)), // Arredonda apenas o topo
              color: isDarkMode
                  ? Theme.of(context)
                      .colorScheme
                      .secondary // Cor para modo escuro
                  : Theme.of(context)
                      .colorScheme
                      .primary
                      .withOpacity(0.65), // Cor para modo claro
            ),
          ),
        ),
      ),
    );
  }
}
