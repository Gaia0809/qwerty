import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. Stato
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

// 2. Notifier (Nota: Usiamo 'Notifier', NON 'StateNotifier')
class AppStateNotifier extends Notifier<AppState> {
  
  @override
  AppState build() {
    // Stato iniziale
    return AppState(backgroundColor: Colors.white, isDarkMode: false);
  }

  void changeColor(Color newColor) {
    state = state.copyWith(backgroundColor: newColor);
  }

  void setRandomColor() {
    final random = Random();
    final double hue = random.nextDouble() * 360;
    final double saturation = 0.5 + (random.nextDouble() * 0.5);
    
    double lightness;
    if (state.isDarkMode) {
       lightness = 0.6 + (random.nextDouble() * 0.3); 
    } else {
       lightness = 0.2 + (random.nextDouble() * 0.6);
    }

    final color = HSLColor.fromAHSL(1.0, hue, saturation, lightness).toColor();
    state = state.copyWith(backgroundColor: color);
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

// 3. Provider (Nota: Usiamo 'NotifierProvider')
final appStateProvider = NotifierProvider<AppStateNotifier, AppState>(() {
  return AppStateNotifier();
});