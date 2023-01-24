import 'package:flutter/material.dart';
import 'package:todo/constants/color_constant.dart';
import 'package:get/get.dart';
import 'package:todo/controller/auth_controller.dart';
import 'package:todo/view/login/login_screen.dart';
import '../widgets/elevated_button.dart';
import '../widgets/text_field.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  bool isLoading = false;
  TextEditingController name = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController confirmPassword = TextEditingController();

  AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(
          color: ColorConstant.black,
        ),
        backgroundColor: ColorConstant.grey,
        elevation: 0.0,
      ),
      backgroundColor: ColorConstant.grey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text("Welcome Back !",style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),),
            const SizedBox(height: 20,),
            const Text("Let’s help you meet up your task",style: TextStyle(fontSize: 13,
              color: ColorConstant.green,
              fontWeight: FontWeight.w300,
            ),),
            const SizedBox(height: 50,),
            TextFieldWidget(
              suffix: "",
              secureText: false,
              controller: name, hintText: 'Enter Your Name', onchanged: (String ) {  }, action: TextInputAction.next,),
            TextFieldWidget(
              suffix: "",
              secureText: false,
              controller: email, hintText: 'Enter Your Email Address', onchanged: (String ) {  }, action: TextInputAction.next,),
            TextFieldWidget(
              suffix: "",
              maxlines: 1,
              secureText: true,
              controller: password, hintText: 'Create a Password', onchanged: (String ) {  }, action: TextInputAction.next,),
            TextFieldWidget(
              suffix: "",
              maxlines: 1,
              secureText: true,
              controller: confirmPassword, hintText: 'Confirm your Password', onchanged: (String ) {  }, action: TextInputAction.done,),
            const SizedBox(height: 40,),
            ElevatedButtonWidget(child:const Text("Sign Up")  , function: () {
              authController.registerUser(name.text.toString(), email.text.toString(), password.text.toString());

            },),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Already Have an Account?"),
                TextButton(onPressed: (){
                 Get.back();
                }, child: const Text("Sign In",style: TextStyle(
                  color: ColorConstant.green,
                ),)),
              ],
            ),

          ],
        ),
      ),
    );
  }
}



