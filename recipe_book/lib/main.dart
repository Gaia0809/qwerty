import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'ricetta.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final List<Ricetta> ricette = [

    Ricetta(
      titolo: 'Frullato alla Banana',
      ingredienti: ['- Banana', '- Latte', '- Yogurt bianco', '- Miele', '- Ghiaccio'],
      passaggi: [
        '- Taglia a pezzi la banana',
        '- Metti banana, latte, yogurt e miele nel frullatore',
        '- Aggiungi il ghiaccio',
        '- Frulla a piacimento'
      ],
      url: 'https://www.google.com',
    ),
    Ricetta(
      titolo: 'Mojito',
      ingredienti: ['- Rum bianco', '- Menta fresca', '- Zucchero', '- Lime', '- Soda','- Ghiaccio'],
      passaggi: [
        '- Mescolare zucchero e lime e aggiungere la menta',
        '- Aggiungere rum e mescolare bene',
        '- Trita il ghiaccio',
        '- Riempire il bicchiere di ghiaccio (pilè)',
        '- Top di soda'
      ],
      url: 'https://www.google.com/',
    ),
    Ricetta(
      titolo: 'Minestra di Verdure',
      ingredienti: ['- Carote', '- Patate', '- Zucchine', '- Cipolla', '- Brodo vegetale'],
      passaggi: [
        '- Taglia tutte le verdure a pezzi',
        '- Rosola la cipolla in una pentola con un filo olio',
        '- Aggiungi le altre verdure e copri con il brodo',
        '- Cuoci finché le verdure sono morbide'
      ],
      url: 'https://www.google.com/',
    ),
    Ricetta(
      titolo: 'Insalata Caprese',
      ingredienti: ['- Mozzarelle di bufala', '- Pomodori', '- Basilico fresco','- Olio', '- Origano', '- Sale'],
      passaggi: [
        '- Taglia la mozzarella e i pomodori a fette',
        '- Disponi le fette alternate su un piatto',
        '- Condisci con sale, origano e un filo d\'olio',
      ],
      url: 'https://www.google.com/',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ricette',
      home: Scaffold(
        appBar: AppBar(title: Text('Ricette')),
        body: ListView.builder(
          itemCount: ricette.length,
          itemBuilder: (context, index) {
            final ricetta = ricette[index];
            return ListTile(
              title: Text(ricetta.titolo),
              trailing: IconButton(
                icon: Icon(Icons.link),
                onPressed: () => _apriLink(ricetta.url),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ricetta.titolo,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text('Ingredienti:'),
                            ...ricetta.ingredienti.map((ingrediente) => Text(ingrediente)).toList(),
                            SizedBox(height: 10),
                            Text('Passaggi:'),
                            ...ricetta.passaggi.map((passaggio) => Text(passaggio)).toList(),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('Chiudi'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _apriLink(String url) async {
    final Uri uri = Uri.parse(url);
    await launchUrl(uri);
  }
}
