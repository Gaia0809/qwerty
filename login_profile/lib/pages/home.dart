import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../models/input.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _displayName = "ospite";

  void _openLoginDialog() async {
    final result = await showDialog<UserLogin>(
      context: context,
      builder: (context) => const LoginDialog(),
    );

    if (result != null) {
      setState(() {
        _displayName = result.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ciao $_displayName!',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => context.push('/profile'),
              child: const Text("Vai al Profilo"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _openLoginDialog,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[200]),
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginDialog extends StatefulWidget {
  const LoginDialog({super.key});

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  late final FormGroup form;

  @override
  void initState() {
    super.initState();
    form = FormGroup({
      'name': FormControl<String>(validators: [Validators.required]),
      'email': FormControl<String>(validators: [Validators.required, Validators.email]),
      'password': FormControl<String>(validators: [Validators.required, Validators.minLength(6)]),
    });
  }

  @override
  void dispose() {
    form.dispose();
    super.dispose();
  }

  void _submit() {
    if (form.valid) {
      final user = UserLogin(
        name: form.control('name').value,
        email: form.control('email').value,
        password: form.control('password').value,
      );
      Navigator.pop(context, user);
    } else {
      form.markAllAsTouched();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Login", style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 20),
              ReactiveTextField(
                formControlName: 'name',
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              const SizedBox(height: 10),
              ReactiveTextField(
                formControlName: 'email',
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 10),
              ReactiveTextField(
                formControlName: 'password',
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _submit,
                child: const Text("Entra"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}   