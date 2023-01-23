import 'package:flutter/cupertino.dart';
import 'package:email_validator/email_validator.dart';

class LoginProvider with ChangeNotifier{
   bool? emailElegible;
   bool? passwordElegible;
   String? emailMessage;
   String? passwordMessage;

   void emailValidation(String email){

     if(EmailValidator.validate(email)){
       emailElegible = true;
       emailMessage = "ok";
       notifyListeners();
     }else{
       emailElegible = false;
       emailMessage = "Invalid Email";
       notifyListeners();
     }
   }


   void passwordVallidation(String password){
     if (password.length < 8) {
       passwordElegible = false;
       passwordMessage = 'Weak Password';
       notifyListeners();
     } else {
       passwordElegible = true;
       passwordMessage = '';
       notifyListeners();
     }

   }


}