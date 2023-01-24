import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:todo/constants/color_constant.dart';
import 'package:todo/providers/login_screen_provider.dart';
import 'package:todo/view/splash/splash_screen.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context)=> LoginProvider()),
    ]
    ,
    child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo',
      theme: ThemeData(
        iconTheme: const IconThemeData(
          color: ColorConstant.black,
        ),
        fontFamily: "Poppins",
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    ),);
  }
}
