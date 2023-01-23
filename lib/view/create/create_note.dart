import 'package:flutter/material.dart';
import 'package:todo/constants/color_constant.dart';
import 'package:todo/constants/image_constant.dart';
import 'package:get/get.dart';
import 'package:todo/controller/todo_controller.dart';
import '../widgets/elevated_button.dart';
import '../widgets/text_field.dart';

class CreateNote extends StatelessWidget {
  CreateNote({Key? key}) : super(key: key);

  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TodoController todoController = TodoController();

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
            const Text("Welcome Onboard!",style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),),
            const SizedBox(height: 20,),
            Image(
              width: Get.width * 100,
              height: Get.height / 5,
              image: const AssetImage(ImageConstant.girlBoySitting),),
            const SizedBox(height: 20,),
            const Text("Add What your want to do later on..",style: TextStyle(fontSize: 13,
            fontWeight: FontWeight.w600,
              color: ColorConstant.green,
            ),),
            const SizedBox(height: 30,),
            TextFieldWidget(controller: title, hintText: 'Enter Your Title', onchanged: (String ) { }, action: TextInputAction.next,),
            TextFieldWidget(controller: description,maxlines: 4,hintText: 'Enter Description', onchanged: (String ) {  }, action: TextInputAction.done,),

            const SizedBox(height: 10,),
            ElevatedButtonWidget(child: const Text('Add to List'), function: () {
              todoController.addNote(title.text.toString(), description.text.toString());
              title.clear();
              description.clear();
              Get.back();
            },),

          ],
        ),
      ),
    );
  }
}



