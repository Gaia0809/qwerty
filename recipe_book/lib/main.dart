import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'ricetta.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Ricetta> ricette = [
    Ricetta(
      titolo: 'Pasta al Pomodoro',
      ingredienti: ['- Pasta', '- Pomodoro', '- Olio', '- Sale', '- Basilico'],
      passaggi: [
        '- Cuoci la pasta',
        '- Prepara il sugo con pomodoro e basilico',
        '- Mescola pasta e sugo',
        '- Servi caldo'
      ],
      url: 'https://www.google.com/search?q=Pasta+al+Pomodoro',
    ),
    Ricetta(
      titolo: 'Tiramisu',
      ingredienti: ['- Mascarpone', '- Uova', '- Zucchero', '- Caffe', '- Savoiardi'],
      passaggi: [
        '- Prepara il caffè',
        '- Mescola mascarpone, uova e zucchero',
        '- Fai strati con savoiardi e crema',
        '- Metti in frigo per 4 ore'
      ],
      url: 'https://www.google.com/search?q=Tiramisu',
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
                        padding: const EdgeInsets.all(16.0),
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
                            Text(ricetta.ingredienti[0]),
                            Text(ricetta.ingredienti[1]),
                            Text(ricetta.ingredienti[2]),
                            Text(ricetta.ingredienti[3]),
                            Text(ricetta.ingredienti[4]),
                            SizedBox(height: 10),
                            Text('Passaggi:'),
                            Text(ricetta.passaggi[0]),
                            Text(ricetta.passaggi[1]),
                            Text(ricetta.passaggi[2]),
                            Text(ricetta.passaggi[3]),
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
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}
}
