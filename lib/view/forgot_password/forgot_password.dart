import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/constants/color_constant.dart';
import 'package:todo/constants/image_constant.dart';
import 'package:get/get.dart';
import 'package:todo/providers/forgot_password_provider.dart';
import '../../controller/forgot_password_controller.dart';
import '../../utils/message_box.dart';
import '../widgets/elevated_button.dart';
import '../widgets/text_field.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({Key? key}) : super(key: key);

  TextEditingController email = TextEditingController();
  ForgotPasswordController forgot = ForgotPasswordController();
  Utils utils = Utils();

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
        child: SingleChildScrollView(
          child: Consumer<ForgotPasswordProvider>(
              builder: (context, provider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Forgot Password !",
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
                  image:
                      const AssetImage(ImageConstant.youngManExplaningLesson),
                ),
                const SizedBox(
                  height: 80,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 50),
                          child: Text(
                            provider.forgotPasswordMessage.toString(),
                            style: TextStyle(
                              color: provider.forgotPasswordElegible == true
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
                            provider.forgotPasswordValidation(value);
                          },
                          action: TextInputAction.done,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    provider.forgotPasswordElegible == true
                        ? ElevatedButtonWidget(
                            child: const Text('Forgot Password'),
                            function: () {
                              forgot.forgotPasswordMail(email.text.toString());
                              Get.back();
                            },
                          )
                        : ElevatedButtonWidget(
                            child: const Text('Forgot Password'),
                            function: () {
                              utils.snackBarMessage(
                                  'Error', "Fields Cannot be Empty");
                            },
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Provide your registered email Address"),
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
