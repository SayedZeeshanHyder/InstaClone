import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {

  final Map<String,dynamic> data;
  EditProfile({required this.data});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final storageRef = FirebaseStorage.instance.ref("profilePhoto");

  final firestoreRef = FirebaseFirestore.instance.collection("Users");

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Center(
            child: Text("Cancel"),
          ),
        ),
        actions: [
          TextButton(
            onPressed: updateUserInfo,
            child: const Text("Done"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              CircleAvatar(
                radius: size.width * 0.2,
                backgroundImage: NetworkImage(widget.data['profileUrl']),
              ),
              SizedBox(
                height: size.height * 0.023,
              ),
              InkWell(
                splashFactory: NoSplash.splashFactory,
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
                    widget.data['profileUrl'] = downloadUrl;
                    await auth.currentUser!.updatePhotoURL(downloadUrl);
                    Get.back();
                  }
                  setState(() {});
                },
                child: Text(
                  "Change Profile Photo",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: size.width * 0.04),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  SizedBox(
                    width: size.width * 0.26,
                    child: Text(
                      "Name",
                      style: TextStyle(fontSize: size.width * 0.04),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      initialValue: widget.data['name'],
                      onChanged: (value)async{
                        widget.data['name']=value;
                      },
                      maxLines: null,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width*0.09,
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  SizedBox(
                    width: size.width * 0.26,
                    child: Text(
                      "Website",
                      style: TextStyle(fontSize: size.width * 0.04),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      onChanged: (value){
                        widget.data['webLink']=value;
                      },
                      initialValue: widget.data['webLink'],
                      maxLines: null,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width*0.09,
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  SizedBox(
                    width: size.width * 0.26,
                    child: Text(
                      "Bio",
                      style: TextStyle(fontSize: size.width * 0.04),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      onChanged: (value){
                        widget.data['bio']=value;
                      },
                      initialValue: widget.data['bio'],
                      maxLines: null,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width*0.09,
                  ),
                ],
              ),

              SizedBox(
                height: size.height*0.02,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: size.width*0.05),
                  child: Text(
                    "Switch to Professional Account",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: size.width * 0.04),
                  ),
                ),
              ),


              SizedBox(
                height: size.height*0.03,
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: size.width*0.05),
                  child: Text(
                    "Private Information",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: size.width * 0.043),
                  ),
                ),
              ),


              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  SizedBox(
                    width: size.width * 0.26,
                    child: Text(
                      "Email",
                      style: TextStyle(fontSize: size.width * 0.04),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      onChanged: (value){
                        widget.data['email']=value;
                      },
                      initialValue: widget.data['email'],
                      maxLines: null,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width*0.09,
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  SizedBox(
                    width: size.width * 0.26,
                    child: Text(
                      "Phone",
                      style: TextStyle(fontSize: size.width * 0.04),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      onChanged: (value){
                        widget.data['phone']=value;
                      },
                      initialValue: widget.data['phone'],
                      maxLines: null,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width*0.09,
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  SizedBox(
                    width: size.width * 0.26,
                    child: Text(
                      "Gender",
                      style: TextStyle(fontSize: size.width * 0.04),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      onChanged: (value){
                        widget.data['gender']=value;
                      },
                      initialValue: widget.data['gender'],
                      maxLines: null,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width*0.09,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  updateUserInfo()
  async{
    await auth.currentUser!.updateDisplayName(widget.data['name']);
    FirebaseFirestore.instance.collection("Users").doc(widget.data['uid']).update(widget.data).then((value){
      Get.back();
    }).onError((error, stackTrace){
      print(error.toString());
    });
  }
}
