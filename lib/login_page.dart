import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'navigation_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _fieldsNotEmpty = false;

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_checkFields);
    _passwordController.addListener(_checkFields);
  }

  void _checkFields() {
    setState(() {
      _fieldsNotEmpty = _usernameController.text.isNotEmpty && 
                       _passwordController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _fieldsNotEmpty
                  ? () {
                      // Add login validation here
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NavigationController(initialIndex: 0),
                        ),
                      );
                    }
                  : null,
              child: const Text('Login'),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignupPage()),
                );
              },
              child: const Text('Don\'t have an account? Sign up'),
            ),
          ],
        ),
      ),
    );
  }
} 