
import 'package:flutter/material.dart';
import 'package:todo/constants/color_constant.dart';
class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({Key? key,required this.controller, required this.hintText, this.helperText, required this.onchanged, this.maxlines,required this.action, required this.suffix, required this.secureText, this.suffixtap}) : super(key: key);
TextEditingController controller;
String hintText;
String? helperText;
Function(String) onchanged;
int? maxlines;
TextInputAction action;
String suffix;
bool secureText;
VoidCallback? suffixtap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20),
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
                obscureText: secureText,
                textInputAction: action,
                controller: controller,
                maxLines: maxlines,
                onChanged: onchanged,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffix: InkWell(
                    onTap: suffixtap,
                    child: Text(suffix,style: const TextStyle(
                      fontSize: 14,
                    ),),
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
