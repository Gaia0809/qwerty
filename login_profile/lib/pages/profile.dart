import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profilo")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Questa è la pagina del profilo"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.pop(),
              child: const Text("Torna indietro"),
            ),
          ],
        ),
      ),
    );
  }
}