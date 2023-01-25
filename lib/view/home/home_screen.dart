
import 'package:animated_text_kit/animated_text_kit.dart';
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
import '../../utils/message_boxes/message_box.dart';
import '../create/create_note.dart';
import '../view_edit_todo/todo_view.dart';

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
        automaticallyImplyLeading: false,
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
                return AnimatedTextKit(
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
                );
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
            child: StreamBuilder(
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
                                               Navigator.pop(context);
                                              todoController.updateNoteStatus(snapshot.data!.docs[index]['ProductId'].toString(),true);
                                            }, () {
                                              //cancel
                                              Navigator.pop(context);
                                              todoController.updateNoteStatus(snapshot.data!.docs[index]['ProductId'].toString(),false);
                                            }, "Completed", "InComplete");
                                          },
                                        onTap: (){
                                          Get.to(ViewTodo(title: snapshot.data!.docs[index]['Title'].toString(),
                                              description: snapshot.data!.docs[index]['Description'].toString(),
                                              completed: snapshot.data!.docs[index]['Completed'],
                                              creationDate: snapshot.data!.docs[index]['CreationDate'].toString(),
                                            productId: snapshot.data!.docs[index]['ProductId'].toString(),));
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
