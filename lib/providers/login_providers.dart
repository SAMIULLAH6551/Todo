import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';

class LoginProvider with ChangeNotifier {
  bool? emailElegible;
  bool? passwordElegible;
  String emailMessage = "";
  String passwordMessage = "";

  void emailValidation(String email) {
    if (EmailValidator.validate(email)) {
      emailElegible = true;
      emailMessage = 'Ok';
      notifyListeners();
    } else {
      emailElegible = false;
      emailMessage = 'Invalid Email Address';
      notifyListeners();
    }
  }

  void passswordValidation(String value) {
    if (value.length < 8) {
      passwordElegible = false;
      passwordMessage = 'Weak Password';
      notifyListeners();
    } else {
      passwordElegible = true;
      passwordMessage = 'Ok';
      notifyListeners();
    }
  }
}
