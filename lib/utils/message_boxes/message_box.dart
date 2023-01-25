import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:todo/constants/color_constant.dart';


class Utils{
  void snackBarMessage(String title,message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: ColorConstant.white,
    );
  }

  void dialogBoxMessage(String title,message,VoidCallback confirm,cancel, String buttonconfirm,buttoncancel){
    Get.defaultDialog(
      title: title,
      middleText: message,
      backgroundColor: ColorConstant.white,
      barrierDismissible: false,
      radius: 10,
      titleStyle: const TextStyle(color: ColorConstant.black),
      middleTextStyle: const TextStyle(color: ColorConstant.black),
      confirm: TextButton(onPressed: confirm, child:  Text(buttonconfirm,style: TextStyle(color: ColorConstant.green),)),
      cancel: TextButton(onPressed: cancel, child:  Text(buttoncancel,style: TextStyle(color: ColorConstant.red),)),
    );
  }

  }