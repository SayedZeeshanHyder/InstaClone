import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:instaclone/controllers/postcontroller.dart';
import 'package:get/get.dart';
import 'package:instaclone/models/usermodel.dart';
import 'package:uuid/uuid.dart';

class PostDetailsScreen extends StatelessWidget
{
  var uuid = Uuid();
  final auth = FirebaseAuth.instance;
  final tagsController = TextEditingController();
  final postController = Get.put(PostController());
  final captionController = TextEditingController();
  final allPostDoc = FirebaseFirestore.instance.collection("AllPosts").doc("AllPosts");
  final userCollection = FirebaseFirestore.instance.collection("Users");
  final storage = FirebaseStorage.instance;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("Prev"),
        ),
        title: const Text("Post"),
        actions: [
          TextButton(
            onPressed: () async{

              showDialog(context: context, builder: (context){
                return AlertDialog(
                  content: SizedBox(
                    width: size.width*0.7,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircularProgressIndicator(color: Colors.blue,),
                        Text("Uploading Post"),
                      ],
                    ),
                  ),
                );
              });

              final getAllPosts = await allPostDoc.get();
              final List listOfPosts = getAllPosts.exists ? getAllPosts["posts"] : [];

              final getAllUserPosts = await userCollection.doc(auth.currentUser!.uid).get();
              final List listOfUserPosts = getAllUserPosts['posts'];
              
              if(postController.postImagesFiles.length == 1){
                final filePath = postController.postImagesFiles[0].path;
                final putFile = await storage.ref(auth.currentUser!.uid).child("Post${listOfUserPosts.length.toString()}").putFile(File(filePath));
                final downloadUrl = await putFile.ref.getDownloadURL();
                postController.postImages.add(downloadUrl);
              }
              else {
                for (File i in postController.postImagesFiles) {
                  final filePath = i.path;
                  final putFile = await storage.ref(auth.currentUser!.uid)
                      .child("Post${listOfUserPosts.length.toString()}").child("image${postController.postImagesFiles.indexOf(i)}")
                      .putFile(File(filePath));
                  final downloadUrl = await putFile.ref.getDownloadURL();
                  postController.postImages.add(downloadUrl);
                }
              }
              Map<String,dynamic> postData = {
                "tags": postController.tags,
                "by": auth.currentUser!.displayName,
                "uid": auth.currentUser!.uid,
                "isImage": true,
                "images" : postController.postImages,
                "caption": captionController.text,
                "comments":[],
                "likes": [],
                "profileUrl" : auth.currentUser!.photoURL,
                "time" : DateTime.now(),
                "postId": uuid.v4(),
              };
              Posts newPost = Posts.fromJson(postData);
              //Updating All Posts
              listOfPosts.add(newPost.toJson());
              await allPostDoc.set({
                "posts":listOfPosts
              });


              print("Updated All Posts");
              //Update User Posts
              
              listOfUserPosts.add(newPost.toJson());
              await userCollection.doc(auth.currentUser!.uid).update({
                "posts":listOfUserPosts
              });
              print("All Functions Done");
              await Get.delete<PostController>();
              print("postController deleted");
              Get.back();
              Get.back();
              Get.back();
            },
            child: Text("Next"),
          ),
        ],
      ),
      
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: size.height*0.01,
            ),
            postController.postImagesFiles.length>1 ?SizedBox(
              height: size.height*0.2,
              child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: postController.postImagesFiles.length,itemBuilder: (context,index){
                File file = postController.postImagesFiles[index];
                return Container(
                  margin: EdgeInsets.only(left: size.width*0.03),
                  width: size.width*0.2,
                  child: Image.file(File(file.path),fit: BoxFit.cover,),
                );
              }),
            ) : Container(
              margin: EdgeInsets.symmetric(horizontal: size.width*0.04),
              width: size.width,
              height: size.height*0.25,
              child: Image.file(File(postController.postImagesFiles[0].path),fit: BoxFit.cover,),
            ),
            SizedBox(
              height: size.height*0.01,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width*0.055),
              child: Align(alignment: Alignment.centerLeft,child: Text("Caption",style: TextStyle(fontWeight: FontWeight.bold,fontSize: size.width*0.06),),),
            ),
            SizedBox(
              height: size.height*0.01,
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(size.width*0.03)
              ),
              width: size.width*0.9,
              child: TextField(
                cursorColor: Colors.grey.shade500,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Enter Caption",
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: size.height*0.01,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width*0.055),
              child: Align(alignment: Alignment.centerLeft,child: Text("Tag People",style: TextStyle(fontWeight: FontWeight.bold,fontSize: size.width*0.06),),),
            ),
            SizedBox(
              height: size.height*0.01,
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(size.width*0.03)
              ),
              width: size.width*0.9,
              child: TextField(
                controller: tagsController,
                cursorColor: Colors.grey.shade500,
                maxLines: null,
                decoration: InputDecoration(
                  suffixIcon: IconButton(onPressed: (){
                    if(!postController.tags.contains(tagsController.text)) {
                      postController.tags.add(tagsController.text);
                    }
                  },icon: Icon(Icons.add),),
                  hintText: "Enter Usernames",
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: size.height*0.02,
            ),
            postController.tags.isNotEmpty ? Obx(
              ()=> Container(
                height: size.height*0.05,
                child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: postController.tags.length,itemBuilder: (context,index){
                  return Container(
                    margin: EdgeInsets.only(left: size.width*0.04),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size.width*0.03),
                      color: Colors.red.shade400,
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: size.width*0.03,),
                        InkWell(onTap: (){
                          postController.tags.remove(postController.tags[index]);
                        },child: Icon(Icons.close,color: Colors.white,),),
                        SizedBox(
                          width: size.width*0.03,
                        ),
                        Text(postController.tags[index],style: TextStyle(color: Colors.white),),
                        SizedBox(width: size.width*0.03,),
                      ],
                    ),
                  );
                }),
              ),
            ) : SizedBox(),
          ],
        ),
      ),
    );
  }

}
