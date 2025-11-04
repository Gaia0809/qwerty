import 'package:flutter/material.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'package:toggle_switch/toggle_switch.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color _backgroundColor = Colors.white;
  bool _isLight = true;
  Brightness brightness = Brightness.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Entra nel tuo arcobaleno di idee. Oppure scegli il colore in base al tuo stato d'animo"),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),

        body: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          color: _backgroundColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      backgroundColor: Colors.red,
                      onPressed: () => _changeColor(Colors.redAccent),
                    ),
                    const SizedBox(width: 20),
                    FloatingActionButton(
                      backgroundColor: Colors.green,
                      onPressed: () => _changeColor(Colors.greenAccent),
                    ),
                    const SizedBox(width: 20),
                    FloatingActionButton(
                      backgroundColor: Colors.blue,
                      onPressed: () => _changeColor(Colors.blueAccent),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                ToggleSwitch(
                  minWidth: 90.0,
                  minHeight: 70.0,
                  initialLabelIndex: _isLight ? 1 : 0,
                  cornerRadius: 20.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.white,
                  totalSwitches: 2,
                  icons: [
                    Icons.dark_mode,
                    Icons.light_mode,
                  ],
                  iconSize: 30.0,
                  activeBgColors: [
                    [Colors.black],
                    [Colors.yellow],
                  ],
                  animate: true,
                  curve: Curves.bounceInOut,
                  onToggle: (index) {
                    setState(() {
                      if (index == 0) {
                        brightness = Brightness.dark;
                        _isLight = false;
                        _backgroundColor = Colors.black;
                      } else {
                        brightness = Brightness.light;
                        _isLight = true;
                        _backgroundColor = Colors.white;
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ),

        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton.extended(
              backgroundColor: Colors.white,
              onPressed: _resetColor,
              label: const Text('Reset'),
              icon: const Icon(Icons.refresh),
            ),
            const SizedBox(width: 20),
            FloatingActionButton.extended(
              backgroundColor: Colors.white,
              onPressed: _randomColor,
              label: const Text('Colore Random'),
              icon: const Icon(Icons.shuffle),
            ),
          ],
        ),
      ),
    );
  }

  void _changeColor(Color newColor) {
    setState(() {
      _backgroundColor = newColor;
    });
  }

  void _resetColor() {
    setState(() {
      _backgroundColor = Colors.white;
      brightness = Brightness.light;
    });
  }

  void _randomColor() {
    setState(() {
      _backgroundColor = RandomColor.getColorObject(
        Options(
          colorType: ColorType.random,
          luminosity: Luminosity.light,
          format: Format.rgb,
        ),
      );
    });
  }
}
