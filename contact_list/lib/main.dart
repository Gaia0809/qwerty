import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'models/contatti.dart';
import 'form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista Contatti',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purpleAccent),
      ),
      home: const MyHomePage(title: 'I Miei Contatti'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Persona> listaContatti = [
    Persona(nome: 'Pippo', cognome: 'Qualcosa', telefoni: ['345 179 8967']),
    Persona(nome: 'Thomas', cognome: 'Ehehe', telefoni: ['123 456 7890', '123 456 7890'])
  ];
  @override
  Widget build(BuildContext context) {
    List<Widget> righeDellaLista = [];

    for (int index = 0; index < listaContatti.length; index++) {
      final persona = listaContatti[index];

      final rigaContatto = ListTile(
        title: Text('${persona.nome} ${persona.cognome}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {
                _condividiContatto(persona);
              },
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                _modificaContatto(index);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _eliminaContatto(index);
              },
            ),
          ],
        ),
        onTap: () {
          _mostraDettaglio(persona);
        },
      );

      righeDellaLista.add(rigaContatto);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: listaContatti.isEmpty
          ? const Center(
              child: Text(
                "Nessun contatto, aggiungine uno",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            )
          : 
            ListView(
              children: righeDellaLista,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _creaContatto,
        child: const Icon(Icons.add),
      ),
    );
  }
  Future<void> _creaContatto() async {
    final result = await showDialog<Persona>(
      context: context,
      builder: (context) {
        return const FormContattoDialog();
      },
    );

    if (result == null) return;

    setState(() {
      listaContatti.add(result);
    });
  }

  Future<void> _modificaContatto(int indice) async {
    final personaDaModificare = listaContatti[indice];

    final result = await showDialog<Persona>(
      context: context,
      builder: (context) {
        return FormContattoDialog(contattoDaModificare: personaDaModificare);
      },
    );

    if (result == null) return;

    setState(() {
      listaContatti[indice] = result;
    });
  }

  void _condividiContatto(Persona persona) {
    Share.share(
      'Nome: ${persona.nome}\n'
      'Cognome: ${persona.cognome}\n'
      'Telefono: ${persona.telefoni}',
    );
  }

  void _mostraDettaglio(Persona persona) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('${persona.nome} ${persona.cognome}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: persona.telefoni.map((numero) {
              return ListTile(
                title: Text(numero),
                trailing: IconButton(
                  icon: const Icon(Icons.call),
                  onPressed: () => _chiamaNumero(numero),
                ),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Chiudi"),
            ),
          ],
        );
      },
    );
  }

  void _chiamaNumero(String numero) async {
    final Uri uri = Uri.parse('tel:$numero');
    await launchUrl(uri);
  }

  void _eliminaContatto(int indice) {
    setState(() {
      listaContatti.removeAt(indice);
    });
  }
}