import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:todo/utils/message_boxes/message_box.dart';

class ForgotPasswordController extends GetxController{

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Utils utils = Utils();
  RxBool loading = false.obs;



  void forgotPasswordMail(String email){
    loading.value = true;
    auth.sendPasswordResetEmail(email: email).then((value){
      loading.value = false;
      utils.snackBarMessage("Success", "Password Reset Mail Send");
    }).onError((error, stackTrace){
      loading.value = false;
     utils.snackBarMessage('Error', error.toString());
    });
  }
}