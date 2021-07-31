import 'package:clean_achitecture/sigin_signup/domain/entities/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool get isSigningIn => isSigningIn;
  late String _errorMessage;

  // UserEntity? _userFromFirebaseUser(User user) {
  //   // ignore: unnecessary_null_comparison
  //   return user != null ? UserEntity(uid) : null;
  // }

//dang nhap
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
      //_userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//dang ki
  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      setMessage('No internet');
    } catch (e) {
      print(e.toString());
    }
  }

  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  void setMessage(message) {
    _errorMessage = message;
    notifyListeners();
  }

  Stream<User?> get user =>
      FirebaseAuth.instance.authStateChanges().map((event) => event);
}
