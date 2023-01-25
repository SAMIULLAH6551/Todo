import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/constants/color_constant.dart';
import 'package:todo/constants/image_constant.dart';
import 'package:get/get.dart';
import 'package:todo/controller/todo_controller.dart';
import 'package:todo/providers/createTodo_provider.dart';
import '../../utils/message_box.dart';
import '../widgets/elevated_button.dart';
import '../widgets/text_field.dart';

class CreateNote extends StatelessWidget {
  CreateNote({Key? key}) : super(key: key);

  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TodoController todoController = TodoController();
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
          child: Consumer<CreateTodoProvider>(builder: (context,provider,child){
            return Column(
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                     Padding(
                      padding: EdgeInsets.only(right: 50),
                      child: Text(
                        provider.titleMessage.toString(),
                        style: TextStyle(
                          color: provider.titleElegible == true
                              ? ColorConstant.green
                              : ColorConstant.red,
                        ),
                      ),
                    ),
                    TextFieldWidget(
                      suffix: "",
                      secureText: false,
                      controller: title, hintText: 'Enter Your Title', onchanged: (value) {
                        provider.titleValidation(value);
                    }, action: TextInputAction.next,),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 50),
                      child: Text(
                        provider.descriptionMessage.toString(),
                        style: TextStyle(
                          color: provider.descriptionElegible == true
                              ? ColorConstant.green
                              : ColorConstant.red,
                        ),
                      ),
                    ),
                    TextFieldWidget(
                      suffix: "",
                      secureText: false,
                      controller: description,maxlines: 4,hintText: 'Enter Description', onchanged: (value) {
                        provider.descriptionValidation(value);
                    }, action: TextInputAction.done,),
                  ],
                ),

                const SizedBox(height: 10,),

                provider.titleElegible == true && provider.descriptionElegible == true ?
                ElevatedButtonWidget(child: const Text('Add to List'), function: () {
                  todoController.addNote(title.text.toString(), description.text.toString());
                  title.clear();
                  description.clear();
                  Get.back();
                },) :
                ElevatedButtonWidget(child: const Text('Add to List'), function: () {
                  utils.snackBarMessage("Error", "Fields cannot be Empty");
                },),

              ],
            );
          }),
        ),
      ),
    );
  }
}



