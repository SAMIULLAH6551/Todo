import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../constants/color_constant.dart';

class NoInternet extends StatefulWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  State<NoInternet> createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.grey,
      body: Center(
        child: Container(
                child: Lottie.asset('assets/animation/internet-connection.json')),
      ),
    );
  }
}
