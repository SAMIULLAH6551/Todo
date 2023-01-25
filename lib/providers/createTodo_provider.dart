import 'package:flutter/material.dart';

class CreateTodoProvider with ChangeNotifier{

  bool? titleElegible;
  bool? descriptionElegible;

  String titleMessage = "";
  String descriptionMessage = "";



  void titleValidation(String title){

    if(title.isNotEmpty){
      titleElegible = true;
      titleMessage = "Ok";
      notifyListeners();
    }else{
      titleElegible = false;
      titleMessage = "Title cannot be Empty";
      notifyListeners();
    }
  }


  void descriptionValidation(String description){

    if(description.isNotEmpty){
      descriptionElegible = true;
      descriptionMessage = "Ok";
      notifyListeners();
    }else{
      descriptionElegible = false;
      descriptionMessage = "description cannot be Empty";
      notifyListeners();
    }
  }




}