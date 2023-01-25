import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:todo/constants/color_constant.dart';
import 'package:todo/providers/createTodo_provider.dart';
import 'package:todo/providers/forgot_password_provider.dart';
import 'package:todo/providers/login_providers.dart';
import 'package:todo/providers/signup_providers.dart';
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
      ChangeNotifierProvider<LoginProvider>(create: (context)=>LoginProvider()),
      ChangeNotifierProvider<SignupProvider>(create: (context)=>SignupProvider()),
      ChangeNotifierProvider<CreateTodoProvider>(create: (context)=> CreateTodoProvider()),
      ChangeNotifierProvider<ForgotPasswordProvider>(create: (context)=> ForgotPasswordProvider()),
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
