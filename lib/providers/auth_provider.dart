import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_recipedia/models/user.dart' as local;
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider with ChangeNotifier {
  final GoogleSignIn _googleSignIn;
  final auth.FirebaseAuth _firebaseAuth;
  local.User? user;

  AuthProvider(this._firebaseAuth, this._googleSignIn);

  Stream<auth.User?> get authStateChanges => _firebaseAuth.userChanges();

  Future<auth.UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    final credentials = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credentials;
  }

  Future<void> deleteUser({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.currentUser!.reauthenticateWithCredential(
      auth.EmailAuthProvider.credential(
        email: email,
        password: password,
      ),
    );

    await _firebaseAuth.currentUser!.delete();
    setCurrentUser(null);
  }

  void setCurrentUser(local.User? user) {
    this.user = user;
    notifyListeners();
  }

  Future<auth.UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    final credentials = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credentials;
  }

  Future<String> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return "signed out";
    } on auth.FirebaseAuthException catch (e) {
      return e.message!;
    }
  }

  Future<void> signInGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;
      final credentials = auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credentials);
      debugPrint(_firebaseAuth.currentUser?.email);
      notifyListeners();
    } on auth.FirebaseAuthException catch (err) {
      debugPrint(err.message);
    }
  }

  Future<bool> isUserAlreadyExists(String email) async {
    // check if the user is already registered in firebase auth
    final methods = await _firebaseAuth.fetchSignInMethodsForEmail(email);
    debugPrint(methods.toString());
    return methods.isNotEmpty;
  }

  Future<void> confirmResetPassword(String code, String newPassword) async {
    await _firebaseAuth.confirmPasswordReset(
      code: code,
      newPassword: newPassword,
    );
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on auth.FirebaseAuthException catch (e) {
      debugPrint("Failed to send email: ${e.code}");
      debugPrint("${e.message}");
    }
  }
}
