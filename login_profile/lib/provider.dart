import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/input.dart';

class AuthNotifier extends Notifier<User?> {
  @override
  User? build() {
    return null;
  }

  void login(String email, String password) {
    if (password.isNotEmpty) {
      state = User(email: email, username: email);
    }
  }

  void updateProfile(String newUsername, String newEmail) {
    if (state != null) {
      state = state!.copyWith(username: newUsername, email: newEmail);
    }
  }
}

final authProvider = NotifierProvider<AuthNotifier, User?>(() {
  return AuthNotifier();
});