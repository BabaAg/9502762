
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fixedEmail = 'devoir@gmail.com';
  final _fixedPassword = 'babaag123';

  void _login() async {
    if (_emailController.text == _fixedEmail &&
        _passwordController.text == _fixedPassword) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('loggedIn', true);
      if (!prefs.containsKey('expenses')) {
        prefs.setStringList('expenses', []);
      }
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const DashboardPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Email ou mot de passe incorrect."),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Connexion")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: "Email"),
          ),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: "Mot de passe"),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: _login, child: const Text("Se connecter")),
        ]),
      ),
    );
  }
}
