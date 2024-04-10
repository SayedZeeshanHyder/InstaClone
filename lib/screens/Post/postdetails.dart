import 'dart:io';

import 'package:flutter/material.dart';
import 'package:instaclone/controllers/postcontroller.dart';
import 'package:get/get.dart';

class PostDetailsScreen extends StatelessWidget
{
  final tagsController = TextEditingController();
  final postController = Get.put(PostController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {

          },
          child: Text("Prev"),
        ),
        title: Text("Post"),
        actions: [
          TextButton(
            onPressed: () {

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
            postController.postImages.length>1 ?SizedBox(
              height: size.height*0.2,
              child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: postController.postImages.length,itemBuilder: (context,index){
                File file = postController.postImages[index];
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
              child: Image.file(File(postController.postImages[0].path),fit: BoxFit.cover,),
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
