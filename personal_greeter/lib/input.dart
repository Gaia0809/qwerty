class Todo {
  Todo({ // serve per inizializzare le variabili create sotto
    required this.createAt,
    required this.title,
    required this.description, 
    this.expiresAt,
  });
  String title;
  String description;
  DateTime createAt;
  DateTime? expiresAt;
}

void f(){
  // costruisci un todo
  final todo = Todo(createAt: DateTime.now(), title: 'ciaooo', description: 'presentazione',  expiresAt: DateTime(2026, 01, 01));
  
}