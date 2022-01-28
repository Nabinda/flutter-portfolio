import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationProvider extends ChangeNotifier {
  bool logInStatus = false;
  Future<String> login(String email, String password) async {
    String result = "";
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        result = "Success";
        logInStatus = true;
      });
    } on FirebaseAuthException catch (e) {
      result = e.code;
    }
    notifyListeners();
    return result;
  }

  bool getLogInStatus(){
    return logInStatus;
}
}
