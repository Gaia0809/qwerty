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
    List<String> telefonoIniziale = [""];

    if (persona != null) {
      nomeIniziale = persona.nome;
      cognomeIniziale = persona.cognome;
      
      if (persona.telefoni.isNotEmpty) {
        telefonoIniziale = persona.telefoni;
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
      'telefoni': FormArray( // formControl<String> gestisce un singolo elemento mentre FormArray gestisce una lista di valori
        telefonoIniziale.map((tel) => FormControl<String>(
          value: tel,
          validators: [Validators.required, Validators.minLength(2)],
        )).toList(),
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

    final telefonoArray = _form.control('telefoni') as FormArray;
    final telefoni = telefonoArray.controls
      .map((control) => control.value as String)
      .where((tel) => tel.isNotEmpty)
      .toList();

    final contatto = Persona(
      nome: _form.control('nome').value,
      cognome: _form.control('cognome').value,
      telefoni: telefoni,
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
              ReactiveFormArray(
                formArrayName: 'telefoni',
                builder: (context, formArray, child) {
                  return Column(
                    children: [
                      ...List.generate(formArray.controls.length, (index) {
                        return Row(
                          children: [
                            Expanded(
                              child: ReactiveTextField(
                                formControlName: index.toString(),
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  hintText: "Telefono ${index + 1}",
                                ),
                              ),
                            ),
                            if (formArray.controls.length > 1)
                              IconButton(
                                icon: Icon(Icons.remove_circle),
                                onPressed: () => _rimuoviTelefono(index),
                              ),
                          ],
                        );
                      }),
                      ElevatedButton.icon(
                        onPressed: _aggiungiTelefono,
                        icon: Icon(Icons.add),
                        label: Text("Aggiungi numero"),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 16),
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

  void _aggiungiTelefono() {
    final telefonoArray = _form.control('telefoni') as FormArray;
    telefonoArray.add(FormControl<String>(
      validators: [Validators.required, Validators.minLength(2)],
    ));
    setState(() {});
  }

  void _rimuoviTelefono(int index) {
  final telefonoArray = _form.control('telefoni') as FormArray;
  if (telefonoArray.controls.length > 1) {  // Non rimuovere se è l'unico
    telefonoArray.removeAt(index);
    setState(() {});
  }
}
}