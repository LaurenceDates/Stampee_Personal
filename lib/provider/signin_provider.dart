//==============================
// SignIN State Provider Component
// Version 1.0
// LastUpdate: Apr-25-2021
//==============================
// This Provider Component is Designed to be embedded as a StreamProvider.
//==============================

// Code for Provider (Streamed as User class)
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class SignInStateProvider {
  static final SignInStateProvider instance = SignInStateProvider();
  static final User? initialData = null;

  final StreamController<User?> user = StreamController<User?>.broadcast();
  Stream<User?> get stream => user.stream;

  SignInStateProvider() {
    watchSignInState();
  }

  void watchSignInState() {
    FirebaseAuth.instance.authStateChanges().listen((User? newUser) {
      if (newUser == null) {
        user.sink.add(null);
        print("User is NOT SignedIN");
      } else {
        user.sink.add(newUser);
        print("User is SignedIN. Current user: $newUser");
      }
    });
  }

  void dispose() {
    user.close();
  }
}
