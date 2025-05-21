import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'login_page.dart';
import 'dashboard_page.dart';
import 'expense_form_page.dart';
import 'expense_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion de dépenses',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/form': (context) => const ExpenseFormPage(),
        '/list': (context) => const ExpenseListPage(),
      },
    );
  }
}
