class Personal {
  Personal({ // serve per inizializzare le variabili create sotto
    required this.createAt,
    required this.saluto,
    required this.nome, 
    this.expiresAt,
  });
  String saluto;
  String nome;
  DateTime createAt;
  DateTime? expiresAt;
}

void f(){
  // costruisci un todo
  final personal = Personal(createAt: DateTime.now(), saluto: 'ciaooo', nome: 'presentazione',  expiresAt: DateTime(2026, 01, 01));
  
}