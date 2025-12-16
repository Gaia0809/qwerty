import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'router/router.dart';
import 'providers/app_state_provider.dart';

void main() {
  // ProviderScope è necessario per far funzionare Riverpod
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Ascoltiamo lo stato per cambiare il ThemeMode (Chiaro/Scuro)
    final appState = ref.watch(appStateProvider);

    return MaterialApp.router(
      routerConfig: router,
      title: 'Better Color Changer',
      debugShowCheckedModeBanner: false,
      
      // Definiamo il tema chiaro
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
      ),
      
      // Definiamo il tema scuro
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple, 
          brightness: Brightness.dark
        ),
      ),
      
      // Questo switcha il tema globale dell'app basandosi sullo stato di Riverpod
      themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
    );
  }
}