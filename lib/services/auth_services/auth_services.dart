import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthServices {
  static Future<String> signUp(String email, String password) async {
    try {
      final response = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (response.user != null) {
        return "The user logged in successfully";
      } else {
        return "Something went wrong";
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> signInMethod(String email, String password) async {
    try {
      final response = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (response.user != null) {
        return "The user logged in successfully";
      } else {
        return "Something went wrong";
      }
    } catch (e) {
      return e.toString();
    }
  }
}
