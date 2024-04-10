import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:instaclone/controllers/loadingcontroller.dart';
import 'package:instaclone/controllers/obscurecontroller.dart';
import 'package:instaclone/screens/auth/signup.dart';

import '../../navigationfile.dart';

class Login extends StatelessWidget {

  final auth = FirebaseAuth.instance;
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final loadingController = Get.put(LoadingController());
  final obscureController = Get.put(ObscureController());

  @override
  Widget build(BuildContext context) {
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
                padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                child: TextField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: "Enter Email",
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
                padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                child: Obx(
                  ()=> TextField(
                    obscureText: obscureController.showText.value,
                    obscuringCharacter: '*',
                    controller: passwordController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: obscureController.showText.value ? IconButton(icon: Icon(FontAwesomeIcons.eye),onPressed: (){obscureController.showText.value = false;},) : IconButton(icon: Icon(FontAwesomeIcons.eyeSlash),onPressed: (){obscureController.showText.value = true;},),
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
                  ()=> InkWell(
                  onTap: () async{
                    loadingController.isLoading.value = true;
                    if(userNameController.text.isNotEmpty && passwordController.text.isNotEmpty)
                      {
                        auth.signInWithEmailAndPassword(
                            email: userNameController.text,
                            password: passwordController.text).then((value){

                          //SuccessFul Sign IN
                          print("User Signed IN");
                          loadingController.isLoading.value = false;
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> NavigationFile()));

                        }).onError((error, stackTrace){

                          //Failed Sign In
                          loadingController.isLoading.value = false;
                          print("Error While Signing In ${error.toString()}");
                        });
                      }
                    else{
                      loadingController.isLoading.value = false;
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: size.height*0.01),
                    alignment: Alignment.center,
                    width: size.width * 0.8,
                    height: size.height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(size.width * 0.03),
                    ),
                    child: loadingController.isLoading.value ? Center(child: CircularProgressIndicator(color: Colors.white,),) : Text(
                      "Log in",
                      style: TextStyle(color: Colors.white,fontSize: size.width*0.05,fontWeight: FontWeight.w500),
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
                  Text("OR",style: TextStyle(color: Colors.grey),),
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
                  Get.to(SignUp(),transition: Transition.rightToLeft);
                },
                child: RichText(
                  text:
                      TextSpan(style: TextStyle(color: Colors.grey), children: [
                    TextSpan(text: "Dont have a Account?"),
                    TextSpan(
                        text: "  Sign in", style: TextStyle(color: Colors.blue)),
                  ]),
                ),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              Text("Instagram OT Facebook",style: TextStyle(color: Colors.grey,fontSize: size.width*0.05),),
            ],
          ),
        ),
      ),
    );
  }
}
