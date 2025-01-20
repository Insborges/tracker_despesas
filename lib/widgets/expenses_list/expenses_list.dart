import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses, // Lista de despesas
    required this.onRemoveExpense, // Função para remover a despesa
  });

  final List<Expense> expenses; // Lista de despesas
  final void Function(Expense expense)
      onRemoveExpense; // Função que remove uma despesa

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length, // Conta o número de itens (despesas)
      itemBuilder: (ctx, index) => Dismissible(
        // Dismissible permite deslizar para remover
        key: ValueKey(expenses[index]), // A chave única para identificar o item
        background: Container(
          color: Theme.of(context)
              .colorScheme
              .error
              .withOpacity(0.75), // Cor de fundo para o deslizar (vermelho)
          margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context)
                  .cardTheme
                  .margin!
                  .horizontal), // Margem horizontal conforme o tema
        ),
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]); // Remove a despesa quando deslizada
        },
        child: ExpenseItem(expenses[index]), // Exibe o item de despesa
      ),
    );
  }
}
