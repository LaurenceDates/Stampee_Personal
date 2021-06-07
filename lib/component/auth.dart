//==============================
// Firebase Auth Component
// Version 0.1
// LastUpdate: Apr-24-2021
//==============================

import 'package:firebase_auth/firebase_auth.dart';

class AuthComponent {
  static Future<EmailSignUpResult> emailSignUp(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('Email Registration: Registration Succeeded.');
      return EmailSignUpResult.success;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('Email Registration: Error Code: ${e.code} \n The password provided is too weak.');
        return EmailSignUpResult.weakPassword;
      } else if (e.code == 'email-already-in-use') {
        print('Email Registration: Error Code: ${e.code} \n The account already exists for that email.');
        return EmailSignUpResult.alreadyRegistered;
      } else {
        print('Email Registration: Registration Attempt finished with result unknown.');
        return EmailSignUpResult.unknownDatabaseError;
      }
    } catch (e) {
      print('Email Registration: Unexpected Error happened. Error: $e');
      return EmailSignUpResult.nonDatabaseError;
    }
  }

  static Future<EmailSignInResult> emailSignIn(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return EmailSignInResult.success;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Email SignIn: No user found for that email.');
        return EmailSignInResult.noUser;
      } else if (e.code == 'wrong-password') {
        print('Email SignIn: Wrong password provided for that user.');
        return EmailSignInResult.wrongPassword;
      } else {
        print('Email SignIn: SignIn Attempt finished with result unknown.');
        return EmailSignInResult.unknownDatabaseError;
      }
    } catch (e) {
      print('Email SignIn: Unexpected Error happened. Error: $e');
      return EmailSignInResult.nonDatabaseError;
    }
  }

  // static Future<UserCredential> signInWithGoogle() async {
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //   final GoogleSignInAuthentication googleAuth =
  //   await googleUser!.authentication;
  //   final OAuthCredential credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );
  //
  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  static Future<SignOutResult> signOut() async {
    await FirebaseAuth.instance.signOut();
    return SignOutResult.finished;
  }
}

enum EmailSignUpResult {
  success,
  alreadyRegistered,
  weakPassword,
  unknownDatabaseError,
  nonDatabaseError,
}

enum EmailSignInResult {
  success,
  noUser,
  wrongPassword,
  unknownDatabaseError,
  nonDatabaseError,
}

enum SignOutResult {
  finished,
}
