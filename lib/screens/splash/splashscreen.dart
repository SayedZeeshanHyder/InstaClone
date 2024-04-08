import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclone/navigationfile.dart';
import 'package:instaclone/screens/auth/login.dart';
class SplashScreen extends StatelessWidget
{
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context)
  {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 4),(){
          if(auth.currentUser!=null)
            {
              Get.off(NavigationFile(),transition: Transition.fadeIn);
            }
          else{
            Get.off(Login(),transition: Transition.fadeIn);
          }
        }),
        builder: (context,snapshot){
          return Center(
            child: Column(
              children: [
                Spacer(),
                SizedBox(
                  width: size.width*0.5,
                  height: size.height*0.15,
                  child: Image.asset('assets/images/appIcon.jpg',fit: BoxFit.contain,),
                ),
                SizedBox(
                  height: size.height*0.03,
                ),
                SizedBox(
                  width: size.width*0.75,
                  height: size.height*0.07,
                  child: Image.asset('assets/icons/iglogo.jpg',fit: BoxFit.contain,),
                ),
                Spacer(),
                Text("By Meta",style: TextStyle(color: Colors.grey,fontSize: size.width*0.05),),
                SizedBox(
                  height: size.height*0.07,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}