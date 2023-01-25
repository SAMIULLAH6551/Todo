import 'package:flutter/material.dart';
import 'package:todo/constants/color_constant.dart';
import 'package:get/get.dart';

class ElevatedButtonWidget extends StatelessWidget {
  ElevatedButtonWidget({Key? key, required this.function,required this.child}) : super(key: key);

  VoidCallback function;
  Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width / 2,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorConstant.green,
            elevation: 0, //elevation of button
          ),
          onPressed: function, child: child),
    );
  }
}
