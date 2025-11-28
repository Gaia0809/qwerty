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

    final persona = widget.contattoDaModificare;

    String nomeIniziale = "";
    String cognomeIniziale = "";
    String telefonoIniziale = "";

    if (persona != null) {
      nomeIniziale = persona.nome;
      cognomeIniziale = persona.cognome;
      
      if (persona.telefoni.isNotEmpty) {
        telefonoIniziale = persona.telefoni.first;
      }
    }

    _form = FormGroup({
      'nome': FormControl<String>(
        value: nomeIniziale,
        validators: [Validators.required, Validators.minLength(2)],
      ),
      'cognome': FormControl<String>(
        value: cognomeIniziale,
        validators: [Validators.required, Validators.minLength(2)],
      ),
      'telefono': FormControl<String>(
        value: telefonoIniziale,
        validators: [Validators.required, Validators.minLength(2)]
      ),
    });
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_form.valid) return; 

    final contatto = Persona(
      nome: _form.control('nome').value,
      cognome: _form.control('cognome').value,
      telefoni: [_form.control('telefono').value],
    );

    Navigator.pop(context, contatto);
  }


  @override
  Widget build(BuildContext context) {
    
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        
        child: ReactiveForm(
          formGroup: _form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.contattoDaModificare == null
                    ? "Nuovo contatto"
                    : "Modifica contatto",
              ),

              ReactiveTextField(
                formControlName: 'nome',
                decoration: InputDecoration( hintText: "Nome",),
              ),
              ReactiveTextField(
                formControlName: 'cognome',
                decoration: InputDecoration( hintText: "Cognome",),
              ),
              ReactiveTextField(
                formControlName: 'telefono',
                keyboardType: TextInputType.phone,
                decoration: InputDecoration( hintText: "Numero telefono",),
              ),

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
}