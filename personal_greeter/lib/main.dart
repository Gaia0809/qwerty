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
  String _displayText = "Personalizza il tuo saluto"; //rendere questo testo una variabile

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          ElevatedButton.icon(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _displayText = "Personalizza il tuo saluto"; //rendere questo testo una variabile
              });
            },
            label: const Text('Reset All'),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Center(
        child: Text(
          _displayText,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createTodo,
        icon: Icon(Icons.maps_ugc_outlined),
        label: Text('Aggiungi un nuovo saluto'),
      ),
    );
  }

  Future<void> _createTodo() async {
    final result = await showDialog<Personal>(
      context: context,
      builder: (context) {
        return AddTodoFormDialog();
      },
    );

    if (result == null) return; // dialog annullato

    setState(() {
      // il nuovo testo sostituisce il testo precedente
      _displayText = "${result.saluto}, ${result.nome}";
    });
  }
}
