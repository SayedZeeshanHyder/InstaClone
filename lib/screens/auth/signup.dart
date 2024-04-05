import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:instaclone/models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instaclone/navigationfile.dart';
import '../../controllers/loadingcontroller.dart';
import '../../controllers/obscurecontroller.dart';

class SignUp extends StatelessWidget {

  final auth = FirebaseAuth.instance;
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final loadingController = Get.put(LoadingController());
  final obscureController = Get.put(ObscureController());
  final userCollection = FirebaseFirestore.instance.collection("Users");

  @override
  Widget build(BuildContext context) {
    print(UserModel().toJson());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              SizedBox(
                height: size.height * 0.07,
                width: size.width * 0.6,
                child: Image.asset(
                  'assets/icons/iglogo.jpg',
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: size.height * 0.07,
              ),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.9,
                height: size.height * 0.07,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.width * 0.03),
                  color: Colors.grey.shade200,
                ),
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                child: TextField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: "Enter Username",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.9,
                height: size.height * 0.07,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.width * 0.03),
                  color: Colors.grey.shade200,
                ),
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                child: Obx(
                  () => TextField(
                    obscureText: obscureController.showText.value,
                    obscuringCharacter: '*',
                    controller: passwordController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: obscureController.showText.value
                          ? IconButton(
                              icon: Icon(FontAwesomeIcons.eye),
                              onPressed: () {
                                obscureController.showText.value = false;
                              },
                            )
                          : IconButton(
                              icon: Icon(FontAwesomeIcons.eyeSlash),
                              onPressed: () {
                                obscureController.showText.value = true;
                              },
                            ),
                      hintText: "Enter Password",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: size.width * 0.07),
                  child: Text(
                    "Forgot Password ?",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Obx(
                () => InkWell(
                  onTap: () async {
                    loadingController.isLoading.value = true;
                    if (userNameController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      auth
                          .createUserWithEmailAndPassword(
                              email: "${userNameController.text}@gmail.com",
                              password: passwordController.text)
                          .then((value) async {

                        final map = {"name": userNameController.text, "profileUrl": "", "followers": [], "following": [], "createdAt": DateTime.now(), "searchHistory": [],'posts':[],'heartAct':[],'bio':"Hello I am ${userNameController.text}"};
                        UserModel userModel = UserModel.fromJson(map);
                        await userCollection.doc(userNameController.text).set(userModel.toJson());
                        value.user!
                            .updateDisplayName(userNameController.text)
                            .then((value) {
                              Get.back();
                              Get.off(NavigationFile(),transition: Transition.rightToLeft);
                        })
                            .onError((error, stackTrace) {
                          print("Error in DisplayName ${error.toString()}");
                          loadingController.isLoading.value = false;
                        });
                      }).onError((error, stackTrace) {
                        print("Error in Creating User ${error.toString()}");
                        loadingController.isLoading.value = false;
                      });
                    } else {
                      loadingController.isLoading.value = false;
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                    alignment: Alignment.center,
                    width: size.width * 0.8,
                    height: size.height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(size.width * 0.03),
                    ),
                    child: loadingController.isLoading.value
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            "Sign up",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: size.width * 0.05,
                                fontWeight: FontWeight.w500),
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.facebook,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: size.width * 0.04,
                  ),
                  Text(
                    "Login with Facebook",
                    style: TextStyle(color: Colors.blue),
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  Expanded(
                    child: Divider(),
                  ),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  Text(
                    "OR",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  Expanded(
                    child: Divider(),
                  ),
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              InkWell(
                onTap: (){
                  Get.back();
                },
                child: RichText(
                  text: TextSpan(style: TextStyle(color: Colors.grey), children: [
                    TextSpan(text: "Already have a Account?"),
                    TextSpan(
                        text: "  Log in", style: TextStyle(color: Colors.blue)),
                  ]),
                ),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              Text(
                "Instagram OT Facebook",
                style:
                    TextStyle(color: Colors.grey, fontSize: size.width * 0.05),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
