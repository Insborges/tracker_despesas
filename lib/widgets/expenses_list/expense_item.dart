import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, //faz com que estes elementos vão para o inicio do widget
          children: [
            Text(
              expense.tittle,
              //Foi buscar as configurações que meti no main para o tittle large
              style: Theme.of(context).textTheme.titleLarge, //posso acrescentar o .copywith() se quiser mudar algo só neste widget
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                //Show um text no formato "€[valor]", onde o valor é o número expense.amount arredondado para duas casas decimais
                Text('${expense.amount.toStringAsFixed(2)}€'),
                //O Spacer() dentro de um Row cria um espaço flexível que distribui os widgets lado a lado uniformemente
                const Spacer(),

                //Show a data dos gastos
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(width: 8),
                    Text(expense.formattedDate),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
