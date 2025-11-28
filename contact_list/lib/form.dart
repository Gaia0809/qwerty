import 'package:flutter/material.dart'; 
import 'models/contatti.dart';

class FormContattoDialog extends StatefulWidget {
  
  final Persona? contattoDaModificare;

  const FormContattoDialog({super.key, this.contattoDaModificare});

  @override
  State<FormContattoDialog> createState() => _FormContattoDialogState();
}

class _FormContattoDialogState extends State<FormContattoDialog> {

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nomeController;
  late final TextEditingController _cognomeController;
  late final TextEditingController _telefonoController;

  @override
  void initState() {
    super.initState();

    final persona = widget.contattoDaModificare;

    //riempimento del form se la persona esiste già
    _nomeController = TextEditingController(text: persona?.nome);
    _cognomeController = TextEditingController(text: persona?.cognome);

    String telefonoIniziale = "";
    if (persona != null && persona.telefoni.isNotEmpty) {
      telefonoIniziale = persona.telefoni.first;
    }
    _telefonoController = TextEditingController(text: telefonoIniziale);
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _cognomeController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }
//creao la persona
    final contatto = Persona(
      nome: _nomeController.text,
      cognome: _cognomeController.text,
      telefoni: [_telefonoController.text],
    );

    Navigator.pop(context, contatto);
  }

  @override
  Widget build(BuildContext context) {
    //attentooo
    final theme = Theme.of(context);

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
            child: Column( 
            mainAxisSize: MainAxisSize.min, 
            
            children: [
                Text(
                widget.contattoDaModificare == null
                    ? "Nuovo contatto"
                    : "Modifica contatto",
              ),
              const SizedBox(height: 40),

              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(hintText: "Nome"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Il nome è obbligatorio";
                  }
                  if (value.length < 2) {
                    return "Almeno 2 caratteri";
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 20),

              TextFormField(
                controller: _cognomeController,
                decoration: const InputDecoration(hintText: "Cognome"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Il cognome è obbligatorio";
                  }
                  if (value.length < 2) {
                    return "Almeno 2 caratteri";
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 20),

              TextFormField(
                controller: _telefonoController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(hintText: "Numero telefono"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Il telefono è obbligatorio";
                  }
                  return null;
                },
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
}