import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:todo/utils/message_box.dart';

class ForgotPasswordController extends GetxController{

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Utils utils = Utils();






  void forgotPasswordMail(String email){
    auth.sendPasswordResetEmail(email: email).then((value){
      utils.snackBarMessage("Success", "Password Reset Mail Send");
    }).onError((error, stackTrace){
     utils.snackBarMessage('Error', error.toString());
    });


  }

}