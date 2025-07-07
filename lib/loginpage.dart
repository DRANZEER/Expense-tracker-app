import 'package:flutter/material.dart';
import 'signup.dart';
import 'package:expense_tracker/widgets/expenses.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      if (email == 'testuser@gmail.com' && password == 'Test@1234') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Expenses()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid email or password'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter password';
    }

    List<String> errors = [];

    if (value.length < 6) {
      errors.add('• Minimum 6 characters');
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      errors.add('• Must contain at least one uppercase letter');
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      errors.add('• Must contain at least one lowercase letter');
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      errors.add('• Must contain at least one number');
    }
    if (!RegExp(r'[!@#\$&*~%^(),.?":{}|<>]').hasMatch(value)) {
      errors.add('• Must contain at least one special character');
    }

    if (errors.isNotEmpty) {
      return errors.join('\n');
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Image.asset(
                'lib/widgets/cash-flow.png',
                width: 200,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              const SizedBox(height: 16),
              Text(
                'Expense Tracker',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _emailController,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Email address',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter email';
                          }
                          final emailRegex =
                              RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Invalid email format';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        validator: _validatePassword,
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpPage(),
                            ),
                          );
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                            children: [
                              TextSpan(
                                text: 'Sign up',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}