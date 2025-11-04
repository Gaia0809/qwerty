class Personal {
  Personal({ // serve per inizializzare le variabili create sotto
    required this.createAt,
    required this.task,
    this.expiresAt,
  });
  String task;
  DateTime createAt;
  DateTime? expiresAt;
}

void f(){
  // costruisci un todo  
}