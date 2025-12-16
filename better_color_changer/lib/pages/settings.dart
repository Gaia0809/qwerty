import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Necessario per leggere lo stato
import 'package:go_router/go_router.dart';
import 'package:toggle_switch/toggle_switch.dart'; // Necessario per lo switch
import '../providers/app_state_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Ascoltiamo lo stato per sapere se siamo in Dark Mode
    final appState = ref.watch(appStateProvider);
    // 2. Otteniamo il notifier per cambiare il tema
    final appNotifier = ref.read(appStateProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Impostazioni'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Gestione Tema",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            // IL TOGGLE SWITCH ORA È QUI
            ToggleSwitch(
              minWidth: 90.0,
              minHeight: 70.0,
              // Logica inversa: se è DarkMode (true) l'indice è 0, altrimenti 1
              initialLabelIndex: appState.isDarkMode ? 0 : 1,
              cornerRadius: 20.0,
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              totalSwitches: 2,
              icons: const [
                Icons.dark_mode,
                Icons.light_mode,
              ],
              iconSize: 30.0,
              activeBgColors: const [
                [Colors.black],
                [Colors.orange], // Arancione/Giallo per il sole
              ],
              animate: true,
              curve: Curves.bounceInOut,
              onToggle: (index) {
                if (index != null) {
                  appNotifier.toggleTheme(index);
                }
              },
            ),
            
            const SizedBox(height: 20),
            const Text("Scegli la modalità che preferisci"),
          ],
        ),
      ),
    );
  }
}