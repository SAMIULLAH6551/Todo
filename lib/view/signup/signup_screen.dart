import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/constants/color_constant.dart';
import 'package:get/get.dart';
import 'package:todo/controller/auth_controller.dart';
import 'package:todo/providers/signup_providers.dart';
import 'package:todo/utils/message_boxes/message_box.dart';
import 'package:todo/view/login/login_screen.dart';
import '../widgets/elevated_button.dart';
import '../widgets/text_field.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {


  TextEditingController name = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController confirmPassword = TextEditingController();

  AuthController authController = AuthController();

  Utils utils = Utils();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
        child: SingleChildScrollView(
          child: Consumer<SignupProvider>(builder: (context,provider,child){
            return Column(
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
                Column(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                         Padding(
                          padding: const EdgeInsets.only(right: 50),
                          child: Text(
                            provider.nameMessage.toString(),
                            style: TextStyle(
                              color: provider.nameElegible == true
                                  ? ColorConstant.green
                                  : ColorConstant.red,
                            ),
                          ),
                        ),
                        TextFieldWidget(
                          suffix: "",
                          secureText: false,
                          controller: name, hintText: 'Enter Your Name', onchanged: (value) {
                            provider.nameValidation(value);
                        }, action: TextInputAction.next,),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                         Padding(
                          padding: const EdgeInsets.only(right: 50),
                          child: Text(
                            provider.emailMessage.toString(),
                            style: TextStyle(
                              color: provider.emailElegible == true
                                  ? ColorConstant.green
                                  : ColorConstant.red,
                            ),
                          ),
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
                          padding: const EdgeInsets.only(right: 50),
                          child: Text(
                            provider.passwordMessage.toString(),
                            style: TextStyle(
                              color: provider.passwordElegible == true
                                  ? ColorConstant.green
                                  : ColorConstant.red,
                            ),
                          ),
                        ),
                        TextFieldWidget(
                          suffix: "",
                          maxlines: 1,
                          secureText: true,
                          controller: password, hintText: 'Create a Password', onchanged: (value) {
                            provider.passswordValidation(value);
                        }, action: TextInputAction.next,),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                         Padding(
                          padding: const EdgeInsets.only(right: 50),
                          child: Text(
                            provider.confirmPasswordMessage.toString(),
                            style: TextStyle(
                              color: provider.confirmPasswordElegible == true
                                  ? ColorConstant.green
                                  : ColorConstant.red,
                            ),
                          ),
                        ),
                        TextFieldWidget(
                          suffix: "",
                          maxlines: 1,
                          secureText: true,
                          controller: confirmPassword, hintText: 'Confirm your Password', onchanged: (value) {
                            provider.confirmPasswordValidation(value);
                        }, action: TextInputAction.done,),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 40,),

                provider.nameElegible == true && provider.emailElegible == true && provider.passwordElegible == true && provider.confirmPasswordElegible == true ?
               Obx((){
                 return  ElevatedButtonWidget(child:authController.loading.value == true ? const SizedBox(
                   width: 25,
                   height: 25,
                   child: Center(
                     child: CircularProgressIndicator(
                       strokeWidth: 3,
                       color: ColorConstant.white,
                     ),
                   ),
                 ) : const Text("Sign Up") , function: () {
                   authController.registerUser(name.text.toString(), email.text.toString(), password.text.toString());
                 },);
               })  :     ElevatedButtonWidget(child:const Text("Sign Up")  , function: () {
                  utils.snackBarMessage("Error", "Fields cannot be Empty");
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
            );
          }),
        ),
      ),
    );
  }
}



