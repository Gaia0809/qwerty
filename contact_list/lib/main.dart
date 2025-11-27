import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'models/contatti.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final List<Persona> contatti = [
    Persona(nome: 'Nome', cognome: 'Cognome', telefoni: ['123 456 7890', '123 456 7890']),
    Persona(nome: 'Nome', cognome: 'Cognome', telefoni: ['123 456 7890']),
    Persona(nome: 'Nome', cognome: 'Cognome', telefoni: ['123 456 7890', '123 456 7890']),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contatti',
      home: Scaffold(
        appBar: AppBar(title: Text('Contatti')),
        body: ListView.builder(
          itemCount: contatti.length,
          itemBuilder: (context, index) {
            final persona = contatti[index];
            return ListTile(
              title: Text('${persona.nome} ${persona.cognome}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {
                      _condividi(persona);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _modifica(persona);
                    },
                  ),
                ],
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    List<Widget> listaTelefoni = [];
                    for (int i = 0; i < persona.telefoni.length; i++) {
                      String numero = persona.telefoni[i];
                      listaTelefoni.add(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(numero),
                            IconButton(
                              icon: Icon(Icons.call),
                              onPressed: () {
                                _chiama(numero);
                              },
                            ),
                          ],
                        ),
                      );
                    }

                    return Dialog(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${persona.nome} ${persona.cognome}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 12), 
                            Column(
                              children: listaTelefoni,
                            ),
                            SizedBox(height: 16),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _chiama(String numero) async {
    final Uri uri = Uri(scheme: 'tel', path: numero);
    await launchUrl(uri);
  }

  void _condividi(Persona persona) {
    Share.share(
      'Contatto: ${persona.nome} ${persona.cognome} ${persona.telefoni}',
    );
  }

  void _modifica(Persona persona) {
  }
}