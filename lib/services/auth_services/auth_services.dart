import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  static Future<String> signUp(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      final response = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (response.user != null) {
        showInSnackBar(context, "The user signed  in successfully");
        return "The user signed in successfully";
      } else {
        showInSnackBar(context, "Something went wrong");
        return "Something went wrong";
      }
    } catch (e) {
      showInSnackBar(context, e.toString());
      return e.toString();
    }
  }

  static Future<String> signInMethod(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      final response = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (response.user != null) {
        showInSnackBar(context, "The user logged in successfully");
        return "The user logged in successfully";
      } else {
        showInSnackBar(context, "something went wrong");
        return "Something went wrong";
      }
    } catch (e) {
      showInSnackBar(context, e.toString());
      return e.toString();
    }
  }

  static void showInSnackBar(BuildContext context, String value) {
    var snackBar = SnackBar(content: Text(value));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static Future<Map<String, dynamic>?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      print(userCredential.user!.email);
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<void> signOut() async {
    await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }

  static final GoogleSignIn googleSignIn = GoogleSignIn();

  static Future<Map<String, dynamic>?> signInGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn
          .signIn();
      if (googleSignInAccount == null) {
        return null;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(oAuthCredential);
      print(userCredential.user?.email!);
      return null;
    } catch (e) {
      return null;
    }
  }
}
