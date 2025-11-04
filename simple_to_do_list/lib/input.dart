class Personal {
  Personal({ // serve per inizializzare le variabili create sotto
    required this.createAt,
    required this.task,
    this.isDone = false,
    this.expiresAt,
  });
  String task;
  DateTime createAt;
  bool isDone;
  DateTime? expiresAt;
}

void f(){
  // costruisci un todo  
}