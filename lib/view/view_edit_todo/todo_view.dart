import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/constants/color_constant.dart';
import 'package:get/get.dart';
import 'package:todo/controller/auth_controller.dart';
import 'package:todo/controller/todo_controller.dart';
import 'package:todo/extentions/extentions.dart';

class ViewTodo extends StatefulWidget {
  ViewTodo({Key? key, required this.title,required this.description,required this.completed,required this.creationDate, required this.productId}) : super(key: key);

  bool completed;
  String? creationDate;
  String? title;
  String? description;
  String? productId;

  @override
  State<ViewTodo> createState() => _ViewTodoState();
}

class _ViewTodoState extends State<ViewTodo> {

  @override
  void initState() {
    authController.currentUserData();
    titleController.text = widget.title.toString();
    descriptionController.text = widget.description.toString();
    super.initState();
  }
  AuthController authController = AuthController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TodoController todoController = TodoController();
  bool readonly = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        FloatingActionButton(
          backgroundColor: ColorConstant.green,
          onPressed: () {
            // Data Updating
            todoController.updateNote(widget.productId.toString(), titleController.text.toString(), descriptionController.text.toString(),widget.completed);

          },
          heroTag: null,
          child: const Icon(
            Icons.post_add,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        FloatingActionButton(
          backgroundColor: ColorConstant.green,
          onPressed: () {
            // Edit Task from read only to write
            setState(() {
              readonly = !readonly;
            });
          },
          heroTag: null,
          child: readonly ? const Icon(Icons.edit) : const Icon(Icons.cancel),
        )
      ]),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: ColorConstant.green,
        elevation: 0.0,
      ),
      backgroundColor: ColorConstant.grey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: Get.width * 100,
                height: Get.height / 4.3,
                decoration: const BoxDecoration(
                  color: ColorConstant.green,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 150,
                      height: 120,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      child: Lottie.asset(
                        'assets/animation/avatar.json',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Obx(
                      () => AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            'Hi, ${authController.name.value.firstLetterCapital()}',
                            textStyle: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w100,
                              color: ColorConstant.white,
                            ),
                            speed: const Duration(milliseconds: 500),
                          ),
                        ],
                        totalRepeatCount: 4,
                        pause: const Duration(milliseconds: 1000),
                        displayFullTextOnTap: true,
                        stopPauseOnTap: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Last Update (${widget.creationDate})",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Row(
                  children: <Widget>[
                    const Text("Completed : ",style: TextStyle(
                      fontSize: 13,
                    ),),
                    Text(widget.completed.toString(),style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              width: Get.width * 100,
              child: Card(
                color: ColorConstant.grey,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                elevation: 10,
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 50,
                    ),
                    TextFieldCustomWidget(
                      readOnly: readonly,
                      controller: titleController,
                      suffix: "",
                      secureText: false,
                      hintText: "Title",
                      onchanged: (value) {

                      },
                      action: TextInputAction.next,
                    ),
                    TextFieldCustomWidget(
                      readOnly: readonly,
                      controller: descriptionController,
                      suffix: "",
                      secureText: false,
                      maxlines: 10,
                      hintText: "Description",
                      onchanged: (value) {},
                      action: TextInputAction.done,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // main column
        ],
      ),
    );
  }
}

class TextFieldCustomWidget extends StatelessWidget {
  TextFieldCustomWidget(
      {Key? key,
      required this.hintText,
      this.helperText,
      required this.onchanged,
      this.maxlines,
      required this.action,
      required this.suffix,
        required this.controller,
        required this.readOnly,
      required this.secureText})
      : super(key: key);
  String hintText;
  String? helperText;
  Function(String) onchanged;
  int? maxlines;
  TextInputAction action;
  String suffix;
  bool secureText;
  TextEditingController controller;
  bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            color: ColorConstant.white,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextFormField(
                readOnly: readOnly,
                obscureText: secureText,
                textInputAction: action,
                controller: controller,
                maxLines: maxlines,
                // onChanged: onchanged,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffix: Text(
                    suffix,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  hintText: hintText,
                  helperText: helperText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
