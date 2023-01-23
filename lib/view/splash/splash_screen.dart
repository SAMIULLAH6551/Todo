import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/constants/color_constant.dart';
import 'package:get/get.dart';
import 'package:todo/controller/auth_controller.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
AuthController authController = AuthController();
  @override
  void initState() {
   authController.checkUserIsLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.grey,
     body: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.center,
       children: <Widget>[

        Container(
            width: Get.width * 100,
            child: Lottie.asset('assets/animation/notes.json')),
         SizedBox(
             width: Get.width / 2,
             child: Lottie.asset('assets/animation/loading.json')),

       ],
     ),
    );
  }
}
