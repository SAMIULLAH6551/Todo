import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class SignupProvider with ChangeNotifier{

  bool? nameElegible;
  bool? emailElegible;
  bool? passwordElegible;
  bool? confirmPasswordElegible;

  String nameMessage = "";
  String emailMessage = "";
  String passwordMessage = "";
  String confirmPasswordMessage = "";
  String? passwordValue;


  void nameValidation(String name){

    final RegExp numberRegex = RegExp(r'\d');
    if(!numberRegex.hasMatch(name)){
      nameElegible = true;
      nameMessage = "Ok";
      notifyListeners();
    }else{
      nameElegible = false;
      nameMessage = "Name don't Contains numbers";
      notifyListeners();
    }
  }

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

  void passswordValidation(String password) {
    passwordValue = password;
    if (password.length < 8) {
      passwordElegible = false;
      passwordMessage = 'Weak Password';
      notifyListeners();
    } else {
      passwordElegible = true;
      passwordMessage = 'Ok';
      notifyListeners();
    }
  }

  void confirmPasswordValidation(String confirmPassword) {
    if (confirmPassword == passwordValue) {
      confirmPasswordElegible = true;
      confirmPasswordMessage = "Ok";
      notifyListeners();
    } else {
      confirmPasswordElegible = false;
      confirmPasswordMessage = "Password Don't Matched";
      notifyListeners();
    }
  }






}