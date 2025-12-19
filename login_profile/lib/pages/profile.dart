import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);

    if (user == null) {
      return const Scaffold(body: Center(child: Text("Nessun utente loggato")));
    }

    final form = FormGroup({
      'username': FormControl<String>(
        value: user.username,
        validators: [Validators.required],
      ),
      'email': FormControl<String>(
        value: user.email,
        validators: [Validators.required, Validators.email],
      ),
      'emailConfirmation': FormControl<String>(
        value: user.email,
      ),
    }, validators: [
      Validators.mustMatch('email', 'emailConfirmation'),
    ]);

    return Scaffold(
      appBar: AppBar(title: const Text("Profilo")),
      body: ReactiveForm(
        formGroup: form,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text("Modifica Username", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ReactiveTextField(
              formControlName: 'username',
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 30),
            const Text("Modifica Email (Bonus)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ReactiveTextField(
              formControlName: 'email',
              decoration: const InputDecoration(labelText: 'Nuova Email'),
              validationMessages: {
                ValidationMessage.email: (error) => 'Email non valida',
              },
            ),
            const SizedBox(height: 10),
            ReactiveTextField(
              formControlName: 'emailConfirmation',
              decoration: const InputDecoration(labelText: 'Conferma Email'),
              validationMessages: {
                ValidationMessage.mustMatch: (error) => 'Le email non corrispondono',
              },
            ),
            const SizedBox(height: 40),
            ReactiveFormConsumer(
              builder: (context, form, child) {
                return ElevatedButton(
                  onPressed: form.valid
                      ? () {
                          final newUsername = form.control('username').value as String;
                          final newEmail = form.control('email').value as String;
                          
                          ref.read(authProvider.notifier).updateProfile(newUsername, newEmail);
                          context.pop();
                        }
                      : null,
                  child: const Text("Salva Modifiche"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}