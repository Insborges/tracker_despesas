import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/chart/chart_bar.dart';
import 'package:expense_tracker/models/expense.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  // Lista de despesas recebida como argumento
  final List<Expense> expenses;

  // Cria uma lista de "buckets" (categorias) para as despesas
  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(
          expenses, Category.food), // Categoria: Alimentação
      ExpenseBucket.forCategory(expenses, Category.leisure), // Categoria: Lazer
      ExpenseBucket.forCategory(
          expenses, Category.travel), // Categoria: Viagens
      ExpenseBucket.forCategory(expenses, Category.work), // Categoria: Trabalho
    ];
  }

  // Calcula o valor máximo gasto entre todas as categorias
  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      // Atualiza o valor máximo se a despesa total do bucket for maior
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses;
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    // Verifica se o modo escuro está ativo no sistema
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.all(16), // Margens externas ao redor do gráfico
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity, // Ocupa toda a largura disponível
      height: 180, // Altura fixa do gráfico
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8), // Bordas arredondadas
        gradient: LinearGradient(
          // Gradiente de cores para o fundo
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter, // Começa no fundo
          end: Alignment.topCenter, // Termina no topo
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end, // Alinha ao fundo
              children: [
                for (final bucket in buckets) // Itera sobre os "buckets"
                  ChartBar(
                    fill: bucket.totalExpenses == 0
                        ? 0 // Se não há despesas, não preenche a barra
                        : bucket.totalExpenses /
                            maxTotalExpense, // Percentagem preenchida
                  )
              ],
            ),
          ),
          const SizedBox(height: 12), // Espaço entre o gráfico e os ícones
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4), // Espaço lateral entre ícones
                      child: Icon(
                        categoryIcons[bucket.category], // Ícone da categoria
                        color: isDarkMode
                            ? Theme.of(context)
                                .colorScheme
                                .secondary // Cor para modo escuro
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7), // Cor para modo claro
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
