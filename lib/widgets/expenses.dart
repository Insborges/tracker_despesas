import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  // Lista inicial de despesas registadas
  final List<Expense> _registeredExpenses = [
    Expense(
        tittle: 'Flutter Course',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        tittle: 'Cinema',
        amount: 15.69,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  // Abre um modal para adicionar uma nova despesa
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        isScrollControlled:
            true, // Permite que o modal ocupe mais espaço ao ser apresentado
        context: context,
        builder: (ctx) {
          return NewExpense(
              onAddExpense:
                  _addExpense); // Passa a função para adicionar despesas
        });
  }

  // Adiciona uma nova despesa à lista
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  // Remove uma despesa da lista
  void _removeExpense(Expense expense) {
    final expenseIndex =
        _registeredExpenses.indexOf(expense); // Guarda o índice da despesa

    setState(() {
      _registeredExpenses.remove(expense); // Remove a despesa da lista
    });

    // Limpa qualquer SnackBar ativo
    ScaffoldMessenger.of(context).clearSnackBars();
    // Mostra um SnackBar com a opção de desfazer a remoção
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3), // Duração da mensagem
      content: const Text('Despesa Eliminada.'),
      action: SnackBarAction(
        label: 'Desfazer', // Botão para desfazer
        onPressed: () {
          setState(() {
            _registeredExpenses.insert(expenseIndex,
                expense); // Reinsere a despesa na posição original
          });
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    // Conteúdo principal mostrado quando não existem despesas
    Widget mainContent = const Center(
      child: Text(
          'Nenhumas despesas foram encontradas. Começa a adicionar algumas!'),
    );

    // Substitui o conteúdo principal se houver despesas
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses:
            _registeredExpenses, // Passa as despesas para o widget de lista
        onRemoveExpense: _removeExpense, // Função para remover despesas
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expenses Tracker'), // Título no topo do ecrã
        actions: [
          IconButton(
            onPressed:
                _openAddExpenseOverlay, // Abre o modal para adicionar despesas
            icon: const Icon(Icons.add), // Ícone de adicionar
          )
        ],
      ),
      body: Column(
        children: [
          Chart(
              expenses:
                  _registeredExpenses), // Gráfico para representar as despesas
          Expanded(
            child: mainContent, // Mostra a lista ou a mensagem padrão
          )
        ],
      ),
    );
  }
}
