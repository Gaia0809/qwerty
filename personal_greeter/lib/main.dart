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
      title: 'TODO App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purpleAccent),
      ),
      home: const MyHomePage(title: 'TODO'),
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
  final _list = <Todo>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          ElevatedButton.icon(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _list.clear();
              });
            },
            label: const Text('Reset All'),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Center(
        child: ListView(
          children: [
            if (_list.isEmpty) //
              const Text("non c'è niente"),
            for (final todo in _list)
              ListTile(
                title: Text(todo.title),
                subtitle: Text(todo.description),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createTodo,
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _createTodo() async {
    final result = await showDialog<Todo>(
      context: context,
      builder: (context) {
        return AddTodoFormDialog();
      },
    );

    if (result == null) return; // significa che il dialog è stato annullato

    setState(() {
      _list.add(result);
    });
  }
}