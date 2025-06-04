import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
}
