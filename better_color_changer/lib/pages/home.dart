import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// Nota: Non serve più importare toggle_switch qui
import '../providers/app_state_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);
    final appNotifier = ref.read(appStateProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Arcobaleno di idee"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.go('/settings'),
          ),
        ],
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        color: appState.backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Scegli il colore in base al tuo stato d'animo",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 40),

              // Riga dei 3 bottoni rapidi
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _ColorButton(
                    color: Colors.red,
                    onTap: () => appNotifier.changeColor(Colors.redAccent),
                  ),
                  const SizedBox(width: 20),
                  _ColorButton(
                    color: Colors.purple,
                    onTap: () => appNotifier.changeColor(Colors.purpleAccent),
                  ),
                  const SizedBox(width: 20),
                  _ColorButton(
                    color: Colors.blue,
                    onTap: () => appNotifier.changeColor(Colors.blueAccent),
                  ),
                ],
              ),
              // Qui c'era lo switch, ora rimosso
            ],
          ),
        ),
      ),

      // Floating Action Buttons in basso
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton.extended(
            heroTag: "btn1",
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            onPressed: appNotifier.reset,
            label: const Text('Reset'),
            icon: const Icon(Icons.refresh),
          ),
          const SizedBox(width: 20),
          FloatingActionButton.extended(
            heroTag: "btn2",
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            onPressed: appNotifier.setRandomColor,
            label: const Text('Random'),
            icon: const Icon(Icons.shuffle),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

// Widget helper privato per i pulsanti
class _ColorButton extends StatelessWidget {
  final Color color;
  final VoidCallback onTap;

  const _ColorButton({required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
      backgroundColor: color,
      onPressed: onTap,
      child: const Icon(Icons.colorize, color: Colors.white),
    );
  }
}