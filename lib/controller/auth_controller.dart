
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:todo/extentions/extentions.dart';
import 'package:todo/utils/message_box.dart';
import 'package:todo/view/home/home_screen.dart';
import '../view/login/login_screen.dart';
class AuthController extends GetxController{
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Utils utils = Utils();
  RxString name = "".obs;

  void registerUser(String name,email,password){
   auth.createUserWithEmailAndPassword(email: email, password: password).then((value){
     firestore.collection('Users').doc(auth.currentUser!.uid).set({
       "Id" : auth.currentUser!.uid.toString(),
       "Name" : name,
       "Email" : email,
       "Password" : password,
       "CreationDate" : DateTime.now().customDate(),
     });
     utils.snackBarMessage("Success", "Account Created Success");
     Get.off(const HomeScreen());
   }).onError((error, stackTrace){
     utils.snackBarMessage("Error", error.toString());
   });
   update();
  }

  void loginUser(String email,password){
    auth.signInWithEmailAndPassword(email: email, password: password).then((value){
      utils.snackBarMessage("Success", "Logged in Successfully");
      Get.off(const HomeScreen());
    }).onError((error, stackTrace){
      utils.snackBarMessage("Error", error.toString());
    });
  }


  currentUserData(){
    var collection = firestore.collection('Users').where('Id',isEqualTo: auth.currentUser!.uid).get().then((value){
      name.value = value.docs[0].data()["Name"];
    });
    update();
  }

  void checkUserIsLoggedIn(){

    final user = auth.currentUser;
    if(user != null){
      Timer(const Duration(seconds: 3), () {
        Get.off(const HomeScreen());
      });


    }else{
      Timer(const Duration(seconds: 3), () {
        Get.off(LoginScreen());
      });
    }

  }


}
