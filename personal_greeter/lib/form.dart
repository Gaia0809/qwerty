import 'package:flutter/material.dart';
import 'package:personal_greeter/input.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AddTodoFormDialog extends StatefulWidget {
  const AddTodoFormDialog({super.key});

  @override
  State<AddTodoFormDialog> createState() => _AddTodoFormDialogState();
}

class _AddTodoFormDialogState extends State<AddTodoFormDialog> {
  late final FormGroup _form;

  @override
  void initState() {
    super.initState();
    _form = FormGroup({
      'title': FormControl<String>(
        validators: [RequiredValidator(), MinLengthValidator(2)],
      ),
      'description': FormControl<String>(
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
                formControlName: "title",
                decoration: const InputDecoration(hintText: "Aggiungi il tipo di saluto"),
              ),
              const SizedBox(height: 20),
              ReactiveTextField(
                formControlName: "description",
                decoration: const InputDecoration(hintText: "Aggiungi il nome da salutare"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text("Crea!"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (!_form.valid) return;
    final todo = Todo(
      createAt: DateTime.now(),
      title: _form.control("title").value,
      description: _form.control("description").value,
    );

    Navigator.pop(context, todo);
  }
}
