import 'package:flutter/material.dart';
import 'package:todo/constants/color_constant.dart';
import 'package:todo/constants/image_constant.dart';
import 'package:get/get.dart';
import '../widgets/elevated_button.dart';
import '../widgets/text_field.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({Key? key}) : super(key: key);

  TextEditingController email = TextEditingController();

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text("Forgot Password !",style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),),
            const SizedBox(height: 20,),
            Image(
              width: Get.width * 100,
              height: Get.height / 5,
              image: AssetImage(ImageConstant.youngManExplaningLesson),),
            const SizedBox(height: 50,),
            TextFieldWidget(controller: email, hintText: 'Enter Your Email Address', onchanged: (String ) { }, action: TextInputAction.done,),
            const SizedBox(height: 30,),
            ElevatedButtonWidget(child: Text('Forgot Password'), function: () {
            },),
            SizedBox(height: 20,),
            const Text("Provide your registered email Address"),

          ],
        ),
      ),
    );
  }
}



