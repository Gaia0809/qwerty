import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../provider.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = FormGroup({
      'email': FormControl<String>(
        validators: [Validators.required, Validators.email],
      ),
      'password': FormControl<String>(
        validators: [Validators.required],
      ),
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: ReactiveForm(
        formGroup: form,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            ReactiveTextField(
              formControlName: 'email',
              decoration: const InputDecoration(labelText: 'Email'),
              validationMessages: {
                ValidationMessage.required: (_) => 'Email richiesta',
                ValidationMessage.email: (_) => 'Email non valida',
              },
            ),
            const SizedBox(height: 20),
            ReactiveTextField(
              formControlName: 'password',
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
              validationMessages: {
                ValidationMessage.required: (_) => 'Password richiesta',
              },
            ),
            const SizedBox(height: 40),
            ReactiveFormConsumer(
              builder: (context, form, child) {
                return ElevatedButton(
                  onPressed: form.valid
                      ? () {
                          final email = form.control('email').value as String;
                          final password = form.control('password').value as String;
                          ref.read(authProvider.notifier).login(email, password);
                          context.go('/');
                        }
                      : null,
                  child: const Text("Entra"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}