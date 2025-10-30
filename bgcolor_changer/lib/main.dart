import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Esercizio 1.3',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Background Color Changer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   Color _sfondo = Colors.white;
  bool light0 = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded( 
            child: Container(
              color:_sfondo,
              child: Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text('Gioca con i colori!', style: TextStyle(fontSize: 20),),
                Text('Qua puoi scegliere se visualizzare la schermata in "Light" o in "Dark" mode.'),
                Switch(
                  value: light0,
                  onChanged: (bool value) {
                    setState(() {
                      _switch();
                    });
                  },
                ),
                  ],
                )
                
              ),
            ),
          ),
        ],
      ),
      
      floatingActionButton: 
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: [
        FloatingActionButton(
          onPressed: clickverde,
          backgroundColor: Colors.greenAccent,
          child: const Icon(Icons.color_lens),
        ),
        SizedBox(width: 10,),
        FloatingActionButton(
          onPressed: clickblu,
          backgroundColor: Colors.blueAccent,
          child: const Icon(Icons.color_lens),
        ),
        SizedBox(width: 10,),
        FloatingActionButton(
          onPressed: clickviola,
          backgroundColor: Colors.pinkAccent,
          child: const Icon(Icons.color_lens),
        ),
        // SizedBox(width: 10,),
        // FloatingActionButton( 
        //   onPressed: _switch,
        //   child: const Icon(Icons.light_mode),
  
        // ),
        SizedBox(width: 10,),
        FloatingActionButton(
          onPressed: _random,
          backgroundColor: Colors.white,
          child: const Icon(  Icons.casino)//Text('Random'),
        ),
        SizedBox(width: 10,),
        FloatingActionButton(
          onPressed: _reset,
          backgroundColor: Colors.white,
          child: const Icon(Icons.refresh),
        ),
      ],
      ),
      
    );
  }

  void _switch() {
    setState(() {
      light0 = !light0;
      if (light0 == true) {
        _sfondo = const Color.fromARGB(255, 252, 244, 170); //per alleggerire il colore basta cliccare il quadratino colorato e spostarsi in una tonaltà diversa
      } else {
        _sfondo = const Color.fromARGB(255, 67, 67, 67);
      }
    });
  }
  void clickverde () {
    setState(() {
      _sfondo = Colors.greenAccent;
      
    });
  }
  void clickblu () {
    setState(() {
      _sfondo = Colors.blueAccent;
      
    });
  }
  void clickviola () {
    setState(() {
      _sfondo = Colors.pinkAccent;
      
    });
  }

  void _random() {
    final colorirandom = [ // dico i colori che gireranno nel random
      Colors.greenAccent,
      Colors.blueAccent,
      Colors.pinkAccent,
      Colors.purpleAccent,
      Colors.cyanAccent,
      Colors.lightGreenAccent,
      Colors.amberAccent
    ];
    setState(() {
      //come funziona il random: in questo caso richiamo la variabile dello sfondo(variabile che subirà il cambiamento),
      //prendiamo la lista dei colori che abbiamo creato
      //e gli diciamo di sceglie uno tra i colori della lista
      //l'altro modo di fare un random è utilizzare il Colors.values[Random().nextInt(Colors.values.length)];
      // il colors.values è una lista che contiene tutti i colori disponibili.
      _sfondo = colorirandom[Random().nextInt(colorirandom.length)]; 
    });
  }

  void _reset() {
    setState(() {
       _sfondo = Colors.white;
    });
  }
  
}
