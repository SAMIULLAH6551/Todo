import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/constants/color_constant.dart';
import 'package:get/get.dart';
import 'package:todo/controller/auth_controller.dart';
import 'package:todo/controller/todo_controller.dart';
import 'package:todo/extentions/extentions.dart';
import 'package:todo/view/login/login_screen.dart';
import '../../utils/message_box.dart';

class SeeAll extends StatefulWidget {
  const SeeAll({Key? key}) : super(key: key);

  @override
  State<SeeAll> createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {
  bool checkBoxValue = false;
  AuthController authController = AuthController();
  FirebaseAuth auth = FirebaseAuth.instance;
  TodoController todoController = TodoController();
  Utils utils = Utils();

  @override
  void initState() {
    authController.currentUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                auth.signOut().then((value) {
                  utils.snackBarMessage("Logging out", "See you Soon");
                  Get.offAll(LoginScreen());
                });
              },
              child: const Text(
                "Logout",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: ColorConstant.white,
                ),
              )),
        ],
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
                          () => Text(
                        "Hi, ${authController.name.value.firstLetterCapital()}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w100,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const <Widget>[
                Text(
                  "Todo Tasks",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
         Expanded(
           child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
             stream: TodoController().getStream(),
             builder: (context, snapshot) {
               if (snapshot.data!.docs.isNotEmpty) {
                 return ListView.builder(
                     itemCount: snapshot.data!.docs.length,
                     itemBuilder: (context,index){
                       return  Padding(
                         padding: const EdgeInsets.all(5.0),
                         child: Card(
                           elevation: 0,
                           shape: const RoundedRectangleBorder(
                             borderRadius: BorderRadius.all(Radius.circular(20)),
                           ),
                           child: Container(
                             decoration: BoxDecoration(
                               color: ColorConstant.white,
                               borderRadius: BorderRadius.circular(30),
                             ),
                             child: Scrollbar(
                               trackVisibility: true,
                               child: SingleChildScrollView(
                                 child: Column(
                                   children: [
                                     ListTile(
                                         onLongPress: (){
                                           utils.dialogBoxMessage("Delete", "Do You Want to Delete", () {
                                             // yes
                                           todoController.deleteNote(snapshot.data!.docs[index]['ProductId'].toString());
                                           Navigator.pop(context);
                                           }, () {
                                             Navigator.pop(context);
                                           }, "Yes", "No");
                                         },
                                       trailing: Column(
                                         children: [
                                           Icon(snapshot.data!.docs[index]['Completed'] ? Icons.task_alt : Icons.circle_outlined),
                                           Text(snapshot.data!.docs[index]['CreationDate'].toString()),
                                         ],
                                       ),
                                       title: Text(snapshot.data!.docs[index]['Title']),
                                       subtitle:  Text(
                                           overflow: TextOverflow.ellipsis,
                                           snapshot.data!.docs[index]['Description'].toString()),
                                     ),
                                   ],
                                 ),
                               ),
                             ),
                           ),
                         ),
                       );
                     });
               } else if (snapshot.connectionState == ConnectionState.waiting) {
                 return const Center(child: CircularProgressIndicator());
               } else if (snapshot.data!.docs.isEmpty) {
                 return const Center(child: Text("No Previous History"));
               } else {
                 return const Center(child: Text("Connection Error"));
               }
             },
           ),
         ),
          // main column
        ],
      ),
    );
  }
}




