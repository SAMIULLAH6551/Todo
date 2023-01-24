import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/constants/color_constant.dart';
import 'package:todo/constants/image_constant.dart';
import 'package:get/get.dart';
import 'package:todo/controller/auth_controller.dart';
import 'package:todo/providers/login_screen_provider.dart';
import 'package:todo/view/signup/signup_screen.dart';
import '../password/forgot_password.dart';
import '../widgets/elevated_button.dart';
import '../widgets/text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color: ColorConstant.black,
        ),
        backgroundColor: ColorConstant.grey,
        elevation: 0.0,
      ),
      backgroundColor: ColorConstant.grey,
      body: Center(
          child: Consumer<LoginProvider>(builder: (context,provider,child){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text("Welcome Back !",style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),),
                const SizedBox(height: 20,),
                Image(
                  width: Get.width * 100,
                  height: Get.height / 5,
                  image: const AssetImage(ImageConstant.youngManExplaningLesson),),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 30,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [ Padding(
                          padding: const EdgeInsets.only(right: 50),
                          child: Text(provider.emailMessage.toString(), style: const TextStyle(
                            color: ColorConstant.red,
                          ),),
                        ),
                          TextFieldWidget(
                            suffix: "",
                            secureText: false,
                            controller: email, hintText: 'Enter Your Email Address', onchanged: (value) {
                            provider.emailValidation(value);
                          }, action: TextInputAction.next,),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 40),
                            child: Text(provider.passwordMessage.toString(),style: const TextStyle(color: ColorConstant.red),),
                          ),
                          TextFieldWidget(
                            suffix: "show",
                            secureText: true,
                            maxlines: 1,
                            controller: password, hintText: 'Enter Your Password', onchanged: (value) {
                            provider.passwordVallidation(value);
                          }, action: TextInputAction.done,),
                        ],
                      ),
                      const SizedBox(height: 30,),
                      TextButton(onPressed: (){
                        Get.to(ForgotPassword());
                      }, child: const Text("Forgot Password ?",style: TextStyle(
                        color: ColorConstant.green,
                      ),)),
                      const SizedBox(height: 10,),
                      ElevatedButtonWidget(child: const Text('Sign In'), function: () {
                        Timer(const Duration(seconds: 3), () {
                          authController.loginUser(email.text.toString(), password.text.toString());
                        });
                      },),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("Don't Have an Account?"),
                          TextButton(onPressed: (){
                            Get.to(SignUpScreen());
                          }, child: const Text("Sign Up",style: TextStyle(
                            color: ColorConstant.green,
                          ),)),
                        ],
                      ),
                    ],
                  ),
                ),

              ],
            );
          }),
        ),
    );
  }
}



