import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instaclone/navigationfile.dart';

class SetDetails extends StatelessWidget {

  final auth = FirebaseAuth.instance;
  final storageRef = FirebaseStorage.instance.ref("profilePhoto");
  final firestoreRef = FirebaseFirestore.instance.collection("Users");
  final userNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            StreamBuilder(
              stream: firestoreRef.doc(auth.currentUser!.uid).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                String pUrl = snapshot.data!.data()!['profileUrl'];
                return CircleAvatar(
                  radius: size.width * 0.2,
                  backgroundImage: pUrl.isNotEmpty
                      ? NetworkImage(pUrl)
                      : null,
                  child: pUrl.isNotEmpty ? null : Icon(
                    Icons.person, size: size.width * 0.15,),
                );
              }
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            InkWell(
              onTap: () async{
                final pickedImg = await ImagePicker.platform.pickImage(source: ImageSource.gallery);

                showDialog(context: context, builder: (context){
                  return AlertDialog(
                    content: SizedBox(
                      width: size.width*0.7,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircularProgressIndicator(color: Colors.blue,),
                          Text("Update Profile Photo"),
                        ],
                      ),
                    ),
                  );
                });

                if(pickedImg!=null)
                  {
                    final uid = auth.currentUser!.uid;
                    final path = pickedImg.path;
                    final uploadTask = await storageRef.child(uid).putFile(File(path));
                    final downloadUrl = await uploadTask.ref.getDownloadURL();
                    await auth.currentUser!.updatePhotoURL(downloadUrl);
                    await firestoreRef.doc(uid).update({
                      "profileUrl":downloadUrl
                    });
                    Get.back();
                  }
              },
              child: Text(
                "Set Profile Photo",
                style: TextStyle(color: Colors.blue, fontSize: size.width * 0.05),
              ),
            ),
            SizedBox(
              height: size.height*0.1,
            ),
            Text("Set a Username",style: TextStyle(color: Colors.blue, fontSize: size.width * 0.05),),
            SizedBox(
              height: size.height*0.01,
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(size.width*0.02),
              ),
              width: size.width*0.8,
              height: size.height*0.07,
              padding: EdgeInsets.symmetric(horizontal: size.width*0.02),
              child: TextField(
                controller: userNameController,
                style: TextStyle(fontSize: size.width*0.04),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.person),
                    hintText: "Enter Username",
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          if(auth.currentUser!.photoURL != null && userNameController.text.isNotEmpty)
            {
              showDialog(context: context, builder: (context){
                return AlertDialog(
                  content: SizedBox(
                    width: size.width*0.7,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircularProgressIndicator(color: Colors.blue,),
                        Text("Updating Profile Info"),
                      ],
                    ),
                  ),
                );
              });
              await firestoreRef.doc(auth.currentUser!.uid).update({
                "name":userNameController.text
              });
              Get.back();
              Get.off(()=>NavigationFile());
            }
          else
            {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Set Personal Info First"),),);
            }
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
