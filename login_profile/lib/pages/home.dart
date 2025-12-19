import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Ciao ospite!',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30), // Spazio tra testo e bottoni
            
            // Bottone per il Profilo
            ElevatedButton(
              onPressed: () => context.push('/profile'),
              child: const Text("Vai al Profilo"),
            ),
            
            const SizedBox(height: 10),
            
            // Bottone predisposto per future implementazioni
            ElevatedButton(
              onPressed: () {
                print("Azione futura cliccata");
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[200]),
              child: const Text("Azione Futura"),
            ),
          ],
        ),
      ),
    );
  }
}