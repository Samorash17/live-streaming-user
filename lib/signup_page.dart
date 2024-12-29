import 'package:flutter/material.dart';
import 'navigation_controller.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _aadharController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _fieldsNotEmpty = false;

  @override
  void initState() {
    super.initState();
    void checkFields() => _checkFields();
    
    _usernameController.addListener(checkFields);
    _fullNameController.addListener(checkFields);
    _emailController.addListener(checkFields);
    _phoneController.addListener(checkFields);
    _aadharController.addListener(checkFields);
    _passwordController.addListener(checkFields);
    _confirmPasswordController.addListener(checkFields);
  }

  void _checkFields() {
    setState(() {
      _fieldsNotEmpty = _usernameController.text.isNotEmpty &&
          _fullNameController.text.isNotEmpty &&
          _emailController.text.isNotEmpty &&
          _phoneController.text.isNotEmpty &&
          _aadharController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _aadharController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: SingleChildScrollView(
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
              controller: _fullNameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
                prefixText: '+91 ',
              ),
              keyboardType: TextInputType.phone,
              maxLength: 10,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _aadharController,
              decoration: const InputDecoration(
                labelText: 'Aadhar Number',
                border: OutlineInputBorder(),
                hintText: 'XXXX XXXX XXXX',
              ),
              keyboardType: TextInputType.number,
              maxLength: 12,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Enter Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _fieldsNotEmpty
                  ? () {
                      if (_passwordController.text != _confirmPasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Passwords do not match!'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }
                      // Navigate to HomePage after successful signup
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NavigationController(initialIndex: 0),
                        ),
                      );
                    }
                  : null,
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
} 