import 'package:firebase_auth/firebase_auth.dart';

class UserAuthentication {
  static Future signup(email, password) async {
    try {
      UserCredential user =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("User: $user");
      if (user != null) {
        return "user";
      }
    } catch (e) {
      print(e.code);
      if (e.code == "email-already-in-use") {
        return "user exists";
      }
      return null;
    }
  }

  static login(email, password) async {
    try {
      UserCredential user =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (user != null) {
        return "user found";
      }
    } catch (e) {
      if (e.code == 'user-not-found') {
        return 'no record found';
      } else if (e.code == 'wrong-password') {
        return "incorrect password";
      }
      print(e);
      print(e.code + '---------------------' + e.message);
      return false;
    }
  }
}
