import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController(); // Controlador para o título
  final _amountController = TextEditingController(); // Controlador para o valor
  DateTime? _selectedDate; // Data selecionada
  Category _selectedCategory = Category.travel; // Categoria selecionada

  // Função que apresenta o seletor de data
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    // Exibe o calendário para selecionar uma data
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate; // Atualiza a data selecionada
    });
  }

  // Função para submeter os dados da despesa
  void _submitExpenseData() {
    final enteredAmount = double.tryParse(
        _amountController.text); // Tenta converter o valor inserido para double

    final amountIsInvalid = enteredAmount == null ||
        enteredAmount <= 0; // Verifica se o valor é válido

    // Verifica se todos os campos estão corretamente preenchidos
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      // Exibe um alerta caso algum campo esteja vazio ou inválido
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Error!'),
          content: const Text(
              'Por favor verifica se todos os dados estão a ser inseridos de forma correta ou se todos os espaços foram inseridos'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx); // Fecha o alerta
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
      return; // Interrompe a execução caso algum dado seja inválido
    }

    // Chama a função onAddExpense para adicionar a despesa
    widget.onAddExpense(Expense(
        tittle: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory));

    Navigator.pop(context); // Fecha a tela de inserção de despesa
  }

  // Limpa os controladores quando a tela é fechada
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          // Campo para inserir o título da despesa
          TextField(
            controller: _titleController,
            maxLength: 50, // Limita o número de caracteres
            decoration: const InputDecoration(
              label: Text('Tittle'),
            ),
          ),
          Row(
            children: [
              // Campo para inserir o valor da despesa
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number, // Só permite números
                  decoration: const InputDecoration(
                    prefixText: '€', // Exibe o símbolo do euro antes do valor
                    label: Text('Amount'),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Exibe a data selecionada
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'No date selected'
                          : formatter.format(_selectedDate!), // Formata a data
                    ),
                    // Ícone para abrir o seletor de data
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(
                        Icons.calendar_month,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              // Dropdown para selecionar a categoria da despesa
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name
                              .toUpperCase(), // Exibe a categoria em maiúsculas
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory =
                        value; // Atualiza a categoria selecionada
                  });
                },
              ),
              const Spacer(),
              // Botão para cancelar e voltar à tela anterior
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Fecha a tela de adicionar despesa
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed:
                    _submitExpenseData, // Chama a função para submeter os dados
                child: const Text('Save Expense'),
              )
            ],
          )
        ],
      ),
    );
  }
}
