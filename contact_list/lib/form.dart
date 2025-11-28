import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'models/contatti.dart';

class FormContattoDialog extends StatefulWidget {
  final Persona? contattoDaModificare;

  const FormContattoDialog({super.key, this.contattoDaModificare});

  @override
  State<FormContattoDialog> createState() => _FormContattoDialogState();
}

class _FormContattoDialogState extends State<FormContattoDialog> {
  late final FormGroup _form;

  @override
  void initState() {
    super.initState();

    String telefonoIniziale = "";
    if (widget.contattoDaModificare != null) {
      if (widget.contattoDaModificare!.telefoni.isNotEmpty) {
        telefonoIniziale = widget.contattoDaModificare!.telefoni.first;
      }
    }

    _form = FormGroup({
      'nome': FormControl<String>(
        value: widget.contattoDaModificare?.nome,
        validators: [RequiredValidator(), MinLengthValidator(2)],
      ),
      'cognome': FormControl<String>(
        value: widget.contattoDaModificare?.cognome,
        validators: [RequiredValidator(), MinLengthValidator(2)],
      ),
      'telefono': FormControl<String>(
        value: telefonoIniziale,
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.contattoDaModificare == null ? "Nuovo contatto" : "Modifica contatto",
                style: theme.textTheme.headlineSmall
              ),
              const SizedBox(height: 40),
              
              ReactiveTextField(
                formControlName: "nome",
                decoration: const InputDecoration(hintText: "Nome"),
              ),
              const SizedBox(height: 20),
              
              ReactiveTextField(
                formControlName: "cognome",
                decoration: const InputDecoration(hintText: "Cognome"),
              ),
              const SizedBox(height: 20),

              ReactiveTextField(
                formControlName: "telefono",
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(hintText: "Numero telefono"),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _submit,
                child: const Text("Salva"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (!_form.valid) return;

    final contatto = Persona(
      nome: _form.control("nome").value,
      cognome: _form.control("cognome").value,
      telefoni: [_form.control("telefono").value],
    );

    Navigator.pop(context, contatto);
  }
}