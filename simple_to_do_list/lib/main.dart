import 'package:flutter/material.dart';
import 'package:simple_to_do_list/form.dart';
import 'package:simple_to_do_list/input.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Esercizio 2.1',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purpleAccent),
      ),
      home: const MyHomePage(title: 'A simple To-Do List'),
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
  String _displayText = "Aggiungi nuove tasks!";

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
          FloatingActionButton.extended(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _displayText = "Complimenti hai risolto tutte le tasks, ora puoi crearne di nuove";
              });
            },
            label: const Text('Elimina Task'),
          ),
          const SizedBox(width: 20),
          FloatingActionButton.extended(
            onPressed: _createTodo,
            icon: const Icon(Icons.maps_ugc_outlined),
            label: const Text('Aggiungi una nuova tasks'),
          ),
        ],
      ),
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
      _displayText = result.task;
    });
  }
}
