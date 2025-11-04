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
  String _displayText = "mi piacciono le donne"; 
  final todos = <Personal>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            if (todos.isEmpty)
              Text(
                _displayText,
                textAlign: TextAlign.center,
              ),
            for (final (i, todo) in todos.indexed)
              CheckboxListTile(
                value: todo.isDone,
                title: Text(todo.task),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    todos[i].isDone = value;
                  });
                },
              ),
          ],
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
                  todos.clear();
                  _displayText =
                      "mi piacciono le donne";
                });
              },
              label: const Text('Cancella'),
            ),
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: 200,
            child: FloatingActionButton.extended(
              onPressed: _createTodo,
              icon: const Icon(Icons.maps_ugc_outlined),
              label: const Text('Aggiungi una nuova task'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _createTodo() async {
    final result = await showDialog<Personal>(
      context: context,
      builder: (context) {
        return const AddFormDialog();
      },
    );

    if (result == null) return;

    setState(() {
      todos.add(result);
      _displayText = "";
    });
  }
}
