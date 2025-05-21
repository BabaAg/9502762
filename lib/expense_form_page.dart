import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/expense.dart';

class ExpenseFormPage extends StatefulWidget {
  const ExpenseFormPage({super.key});
  @override
  State<ExpenseFormPage> createState() => _ExpenseFormPageState();
}

class _ExpenseFormPageState extends State<ExpenseFormPage> {
  final _amountController = TextEditingController();
  final _descController = TextEditingController();
  final _catController = TextEditingController();
  DateTime _date = DateTime.now();

  void _save() async {
    final expense = Expense(
      amount: double.tryParse(_amountController.text) ?? 0,
      description: _descController.text,
      category: _catController.text,
      date: _date,
    );
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('expenses') ?? [];
    data.add(expense.toJson());
    prefs.setStringList('expenses', data);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nouvelle dépense")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(
            controller: _amountController,
            decoration: const InputDecoration(labelText: "Montant"),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _catController,
            decoration: const InputDecoration(labelText: "Catégorie"),
          ),
          TextField(
            controller: _descController,
            decoration: const InputDecoration(labelText: "Description"),
          ),
          const SizedBox(height: 10),
          ElevatedButton(onPressed: _save, child: const Text("Ajouter")),
        ]),
      ),
    );
  }
}
