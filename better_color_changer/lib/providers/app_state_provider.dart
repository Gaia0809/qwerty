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
    final r = random.nextInt(256);
    final g = random.nextInt(256);
    final b = random.nextInt(256);
    
    state = state.copyWith(backgroundColor: Color.fromARGB(255, r, g, b));
  }

  void toggleTheme(int index) {
    if (index == 0) {
      state = AppState(backgroundColor: Colors.black, isDarkMode: true);
    } else {
      state = AppState(backgroundColor: Colors.white, isDarkMode: false);
    }
  }

  void reset() {
    state = AppState(backgroundColor: Colors.white, isDarkMode: false);
  }
}

final appStateProvider = NotifierProvider<AppStateNotifier, AppState>(() {
  return AppStateNotifier();
});