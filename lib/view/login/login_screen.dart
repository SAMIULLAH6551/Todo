import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/constants/color_constant.dart';
import 'package:todo/constants/image_constant.dart';
import 'package:get/get.dart';
import 'package:todo/controller/auth_controller.dart';
import 'package:todo/providers/login_providers.dart';
import 'package:todo/utils/message_boxes/message_box.dart';
import 'package:todo/view/signup/signup_screen.dart';
import '../forgot_password/forgot_password.dart';
import '../widgets/elevated_button.dart';
import '../widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  AuthController authController = AuthController();

  Utils utils = Utils();

  bool secure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
        child: Consumer<LoginProvider>(builder: (context, provider, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Welcome Back !",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Image(
                width: Get.width * 100,
                height: Get.height / 5,
                image: const AssetImage(ImageConstant.youngManExplaningLesson),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 60,
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
                            controller: email,
                            hintText: 'Enter Your Email Address',
                            onchanged: (value) {
                              provider.emailValidation(value);
                            },
                            action: TextInputAction.next,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 40),
                            child: Text(
                              provider.passwordMessage.toString(),
                              style: TextStyle(
                                  color: provider.passwordElegible == true
                                      ? ColorConstant.green
                                      : ColorConstant.red),
                            ),
                          ),
                          TextFieldWidget(
                            suffix: secure ? "show" : "Hide",
                            suffixtap: () {
                              setState(() {
                                secure = !secure;
                              });
                            },
                            secureText: secure,
                            maxlines: 1,
                            controller: password,
                            hintText: 'Enter Your Password',
                            onchanged: (value) {
                              provider.passswordValidation(value);
                            },
                            action: TextInputAction.done,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextButton(
                          onPressed: () {
                            Get.to(ForgotPassword());
                          },
                          child: const Text(
                            "Forgot Password ?",
                            style: TextStyle(
                              color: ColorConstant.green,
                            ),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      provider.emailElegible == true &&
                              provider.passwordElegible == true
                          ? Obx((){
                            return  ElevatedButtonWidget(
                              child: authController.loading.value == true ? const SizedBox(
                                width: 25,
                                height: 25,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    color: ColorConstant.white,
                                  ),
                                ),
                              ) : const Text("Sign In"),
                              function: () {
                                Timer(const Duration(seconds: 3), () {
                                  authController.loginUser(
                                    email.text.toString(),
                                    password.text.toString(),);
                                });
                              },
                            );
                      })
                          : ElevatedButtonWidget(
                              child: const Text('Sign In'),
                              function: () {
                                utils.snackBarMessage(
                                    'Error', "Fields Cannot be Empty");
                              },
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Text("Don't Have an Account?"),
                          TextButton(
                              onPressed: () {
                                email.clear();
                                password.clear();
                                Get.to(SignUpScreen());
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: ColorConstant.green,
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
