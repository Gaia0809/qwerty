import 'package:flutter/material.dart';
import 'package:personal_greeter/input.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AddFormDialog extends StatefulWidget {
  const AddFormDialog({super.key});

  @override
  State<AddFormDialog> createState() => _AddFormDialogState();
}

class _AddFormDialogState extends State<AddFormDialog> {
  late final FormGroup _form;

  @override
  void initState() {
    super.initState();
    _form = FormGroup({
      'saluto': FormControl<String>(
        validators: [RequiredValidator(), MinLengthValidator(2)],
      ),
      'nome': FormControl<String>(
        validators: [RequiredValidator(), MinLengthValidator(2)],
      ),
    });
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ReactiveForm(
          formGroup: _form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Nuovo saluto!", style: theme.textTheme.headlineSmall),
              const SizedBox(height: 40),
              ReactiveTextField(
                formControlName: "saluto",
                decoration: const InputDecoration(hintText: "Aggiungi il tipo di saluto"),
              ),
              const SizedBox(height: 20),
              ReactiveTextField(
                formControlName: "nome",
                decoration: const InputDecoration(hintText: "Aggiungi il nome da salutare"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text("Crea saluto"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (!_form.valid) return;
    final todo = Personal(
      createAt: DateTime.now(),
      saluto: _form.control("saluto").value,
      nome: _form.control("nome").value,
    );

    Navigator.pop(context, todo);
  }
}
