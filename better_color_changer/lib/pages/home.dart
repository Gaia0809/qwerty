import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/app_state_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);
    final appNotifier = ref.read(appStateProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.go('/settings'),
          ),
        ],
      ),
      body: Container(
        color: appState.backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Scegli un colore base:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Radio<Color>(
                      value: Colors.blue, 
                      groupValue: appState.backgroundColor, 
                      onChanged: (Color? value) {
                        if (value != null) appNotifier.changeColor(value);
                      },
                      activeColor: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text("Blue"),
                  const SizedBox(width: 20),
                  
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Radio<Color>(
                      value: Colors.green, 
                      groupValue: appState.backgroundColor, 
                      onChanged: (Color? value) {
                        if (value != null) appNotifier.changeColor(value);
                      },
                      activeColor: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text("Green"),
                  const SizedBox(width: 20),

                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Radio<Color>(
                      value: Colors.purple, 
                      groupValue: appState.backgroundColor, 
                      onChanged: (Color? value) {
                        if (value != null) appNotifier.changeColor(value);
                      },
                      activeColor: Colors.purple,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text("Purple"),
                ],
              ),
              
              const SizedBox(height: 30),

              ElevatedButton.icon(
                onPressed: appNotifier.setRandomColor,
                icon: const Icon(Icons.shuffle),
                label: const Text("Random Color"),
              ),
              
              const SizedBox(height: 10),
              ElevatedButton(
                 onPressed: appNotifier.reset,
                 child: const Text("Reset"),
              )
            ],
          ),
        ),
      ),
    );
  }
}