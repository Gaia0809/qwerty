import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppState {
  final Color backgroundColor;
  final bool isDarkMode;

  AppState({required this.backgroundColor, required this.isDarkMode});

  AppState copyWith({Color? backgroundColor, bool? isDarkMode}) {
    return AppState(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}

class AppStateNotifier extends Notifier<AppState> {
  
  @override
  AppState build() {
    return AppState(backgroundColor: Colors.white, isDarkMode: false);
  }

  void changeColor(Color newColor) {
    state = state.copyWith(backgroundColor: newColor);
  }

  void setRandomColor() {
    final random = Random();
<<<<<<< HEAD
    final color = Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
    state = state.copyWith(backgroundColor: color);
=======
    final r = random.nextInt(256);
    final g = random.nextInt(256);
    final b = random.nextInt(256);
    
    state = state.copyWith(backgroundColor: Color.fromARGB(255, r, g, b));
>>>>>>> 7907d237befb2bb90aa19b4d33c5de33754d2e29
  }

  void setDarkMode(bool enabled) {
    state = state.copyWith(
      isDarkMode: enabled,
      backgroundColor: enabled ? Colors.black : Colors.white
    );
  }

  void reset() {
    state = AppState(backgroundColor: Colors.white, isDarkMode: false);
  }
}

final appStateProvider = NotifierProvider<AppStateNotifier, AppState>(() {
  return AppStateNotifier();
});