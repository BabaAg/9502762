
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/expense.dart';

class ExpenseListPage extends StatefulWidget {
  const ExpenseListPage({super.key});
  @override
  State<ExpenseListPage> createState() => _ExpenseListPageState();
}

class _ExpenseListPageState extends State<ExpenseListPage> {
  List<Expense> _expenses = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('expenses') ?? [];
    setState(() {
      _expenses = data.map((e) => Expense.fromJson(e)).toList()
        ..sort((a, b) => b.date.compareTo(a.date));
    });
  }

  void _delete(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('expenses') ?? [];
    data.removeAt(index);
    prefs.setStringList('expenses', data);
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Liste des dépenses")),
      body: ListView.builder(
        itemCount: _expenses.length,
        itemBuilder: (_, i) {
          final e = _expenses[i];
          return ListTile(
            title: Text("${e.amount} FCFA - ${e.category}"),
            subtitle: Text("${e.description} - ${e.date.toLocal()}"),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _delete(i),
            ),
          );
        },
      ),
    );
  }
}
