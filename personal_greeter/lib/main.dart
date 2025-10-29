import 'package:flutter/material.dart';
import 'package:personal_greeter/form.dart';
import 'package:personal_greeter/input.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Esercizio 1.2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purpleAccent),
      ),
      home: const MyHomePage(title: 'Personal Greeter'),
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
  String _displayText = "Crea il tuo saluto personalizzato!"; //rendere questo testo una variabile

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(
          _displayText,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        SizedBox(
          width: 150,
        child: FloatingActionButton.extended(
         icon: const Icon(Icons.refresh),
          onPressed: () {
          setState(() {
             _displayText = "Crea il tuo saluto personalizzato!"; //rendere questo testo una variabile
           });
          },
            label: const Text('Cancella'),
          ),
          ), 
         const SizedBox (width: 20),
         SizedBox(
      width: 150,
        child: FloatingActionButton.extended(
        onPressed: _createTodo,
        icon: Icon(Icons.maps_ugc_outlined),
        label: Text('Crea'),
      ),
         ),
        ]
    )
    );
  }

  Future<void> _createTodo() async {
    final result = await showDialog<Personal>(
      context: context,
      builder: (context) {
        return AddFormDialog();
      },
    );

    if (result == null) return; // dialog annullato

    setState(() {
      // il nuovo testo sostituisce il testo precedente
      _displayText = "${result.saluto}, ${result.nome}";
    });
  }
}
