import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  double totalAmount = 0.0;
  int totalExpenses = 0;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    final prefs = await SharedPreferences.getInstance();
    final expensesData = prefs.getStringList('expenses') ?? [];

    double amount = 0.0;

    for (String item in expensesData) {
      final expense = jsonDecode(item);
      amount += double.tryParse(expense['amount'].toString()) ?? 0.0;
    }

    setState(() {
      totalAmount = amount;
      totalExpenses = expensesData.length;
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('isLoggedIn');

    // Redirection vers la page de connexion ("/")
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tableau de bord'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'Déconnexion',
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: const Text('Total des dépenses'),
                subtitle: Text('$totalAmount FCFA'),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: ListTile(
                title: const Text('Nombre de dépenses'),
                subtitle: Text('$totalExpenses'),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/form');
              },
              child: const Text('Ajouter une dépense'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/list');
              },
              child: const Text('Voir la liste des dépenses'),
            ),
          ],
        ),
      ),
    );
  }
}
