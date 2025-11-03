import 'package:flutter/material.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'package:toggle_switch/toggle_switch.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cambio Colore',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ColorChangerPage(title: 'Cambio Colore'),
    );
  }
}

class ColorChangerPage extends StatefulWidget {
  const ColorChangerPage({super.key, required this.title});
  final String title;

  @override
  State<ColorChangerPage> createState() => _ColorChangerPageState();
}

class _ColorChangerPageState extends State<ColorChangerPage> {
  Color _backgroundColor = Colors.white;
  bool _isYellow = true;

  void _changeColor(Color newColor) {
    setState(() {
      _backgroundColor = newColor;
    });
  }

  void _resetColor() {
    setState(() {
      _backgroundColor = Colors.white;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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
                  // button rosso
                  FloatingActionButton(
                    backgroundColor: Colors.red,
                    onPressed: () => _changeColor(Colors.red),
                  ),
                  const SizedBox(width: 20),
                  // button verde
                  FloatingActionButton(
                    backgroundColor: Colors.green,
                    onPressed: () => _changeColor(Colors.green),
                  ),
                  const SizedBox(width: 20),
                  // button blu
                  FloatingActionButton(
                    backgroundColor: Colors.blue,
                    onPressed: () => _changeColor(Colors.blue),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              ToggleSwitch(
                minWidth: 90.0,
                minHeight: 70.0,
                initialLabelIndex: _isYellow ? 1 : 0,
                cornerRadius: 20.0,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                totalSwitches: 2,
                icons: [
                  Icons.cloud, // nuvola
                  Icons.sunny, // sole  scegliete voi l icona preferita
                ],
                iconSize: 30.0,
                activeBgColors: [[Colors.grey], [Colors.yellow]],
                animate: true,
                curve: Curves.bounceInOut,
                onToggle: (index) {
                  setState(() {
                    if (index == 0) {
                      _backgroundColor = Colors.grey;
                      _isYellow = false;
                    } else {
                      _backgroundColor = Colors.yellow;
                      _isYellow = true;
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
          // button reset
          FloatingActionButton.extended(
            backgroundColor: Colors.white,
            onPressed: _resetColor,
            label: const Text('Reset'),
            icon: const Icon(Icons.refresh),
          ),
          const SizedBox(width: 20),
          // button random
          FloatingActionButton.extended(
            backgroundColor: Colors.white,
            onPressed: _randomColor,
            label: const Text('Colore Random'),
            icon: const Icon(Icons.shuffle),
          ),
        ],
      ),
    );
  }
}
