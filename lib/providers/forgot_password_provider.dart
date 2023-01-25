import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class ForgotPasswordProvider with ChangeNotifier{

 bool? forgotPasswordElegible;
 String? forgotPasswordMessage = "";



 void forgotPasswordValidation(String email){

   if(EmailValidator.validate(email)){

     forgotPasswordElegible = true;
     forgotPasswordMessage = "Ok";
     notifyListeners();

   }else{
     forgotPasswordElegible = false;
     forgotPasswordMessage = "Invalid Email Address";
     notifyListeners();

   }


 }



}