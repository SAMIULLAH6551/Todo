
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/constants/color_constant.dart';
import 'package:get/get.dart';
import 'package:todo/constants/image_constant.dart';
import 'package:todo/controller/auth_controller.dart';
import 'package:todo/controller/todo_controller.dart';
import 'package:todo/extentions/extentions.dart';
import 'package:todo/view/all_tasks/see_all_tasks.dart';
import 'package:todo/view/login/login_screen.dart';
import '../../utils/message_box.dart';
import '../create/create_note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthController authController = AuthController();
  TodoController todoController = TodoController();
  FirebaseAuth auth = FirebaseAuth.instance;
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
          TextButton(onPressed: (){
             auth.signOut().then((value){
               utils.snackBarMessage("Logging out" ,"See you Soon");
               Get.offAll(LoginScreen());
             });
          }, child: const Text("Logout",style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: ColorConstant.white,
          ),)),
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
                  child: Lottie.asset('assets/animation/avatar.json',
                  fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 5,),
              Obx((){
                return   Text("Hi, ${authController.name.value.firstLetterCapital()}",style: const TextStyle(fontSize: 20,
                  fontWeight: FontWeight.w100,
                  color: Colors.white,
                ),);
              }),
              ],
            ),
          ),
              Padding(
                padding: const EdgeInsets.only(top: 150),
                child: Image(
                    width: Get.width * 100,
                    height: Get.height / 4,
                    image: const AssetImage(ImageConstant.womenWithCycle)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                const Text("Todo Tasks",style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),),
                TextButton(onPressed: (){

                  Get.to(const SeeAll());
                }, child: const Text("See All",style: TextStyle(
                  color: ColorConstant.green,
                ),)),
              ],
            ),
          ),
           Padding(
             padding: const EdgeInsets.all(5.0),
             child: Scrollbar(
               trackVisibility: true,
               child: SingleChildScrollView(
                 child: Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text("Today Tasks (${DateTime.now().customDate()})",style: const TextStyle(
                 fontSize: 13,
                 fontWeight: FontWeight.w600,
               ),),
               const Text("Note : Hold to change your task Status",style: TextStyle(
                 fontSize: 10,
                 color: ColorConstant.green,
               ),),
             ],
           ),
           IconButton(onPressed: (){
             Get.to(CreateNote());
           }, icon: const Icon(Icons.add_circle_rounded)),
          ],
        ),
      ),

    ],
    ),
               ),
             ),
           ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: todoController.getTodayTodo(),
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
                                            utils.dialogBoxMessage("Confirmation", "Task Completed", () {
                                              //confirm
                                              todoController.updateNoteStatus(snapshot.data!.docs[index]['ProductId'].toString(),true);
                                              Get.back();
                                            }, () {
                                              //concel
                                              Get.back();
                                            }, "Completed", "Cancel");
                                          },
                                        trailing: Icon(snapshot.data!.docs[index]['Completed'] ? Icons.task_alt : Icons.circle_outlined),
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
                  return const Center(child: Text("No Task for Today"));
                } else {
                  return const Center(child: Text("Connection Error"));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
