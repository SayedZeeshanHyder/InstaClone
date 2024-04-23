import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclone/controllers/profilescreencontroller.dart';
import 'package:instaclone/screens/profile/editprofile.dart';

class ProfileScreen extends StatelessWidget {

  final FirebaseAuth auth = FirebaseAuth.instance;
  final profileScreenController = Get.put(ProfileScreenController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Users").doc(auth.currentUser!.uid).snapshots(),
      builder: (context, snapshot) {

        if(snapshot.connectionState == ConnectionState.waiting)
          {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

        final data = snapshot.data!.data();
        List followers = data!['followers'];
        List posts = data!['posts'];
        List following = data!['following'];
        final String bio = data!['bio'];
        final String name = data!['name'];

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    radius: size.width * 0.135,
                    child: CircleAvatar(
                      radius: size.width * 0.125,
                    ),
                  ),
                  Column(
                    children: [
                      Text(posts.length.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: size.width*0.06),),
                      Text("Posts")
                    ],
                  ),
                  Column(
                    children: [
                      Text(followers.length.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: size.width*0.06),),
                      Text("Followers")
                    ],
                  ),
                  Column(
                    children: [
                      Text(following.length.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: size.width*0.06),),
                      Text("Following"),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width*0.1,top: size.height*0.015),
                child: Text(name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: size.width*0.055),),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width*0.1),
                child: Text(bio,maxLines: 2,),
              ),

              SizedBox(
                height: size.height*0.02,
              ),
              InkWell(
                splashFactory: NoSplash.splashFactory,
                onTap: (){
                  Get.to(()=>EditProfile(data: data,),transition: Transition.rightToLeft);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width*0.075),
                  width: double.infinity,
                  height: size.height*0.045,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400)
                  ),
                  child: const Text("Edit Profile",style: TextStyle(fontWeight: FontWeight.w500),),
                ),
              ),

              SizedBox(
                height: size.height*0.02,
              ),
              SizedBox(
                height: size.height * 0.15,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        width: size.width*0.04,
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 0.6,color: Colors.grey.shade500)
                            ),
                            width: size.width*0.25,
                            height: size.height*0.1,
                            child: Icon(Icons.add,size: size.width*0.09,),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          const Text("New Story")
                        ],
                      ),
                      ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(size.width * 0.015),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.pinkAccent,
                                    radius: size.width * 0.1,
                                    child: CircleAvatar(
                                      radius: size.width * 0.093,
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  Text("User$index")
                                ],
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
              Divider(),
              Obx(
                  ()=> Row(
                  children: [
                    Expanded(child: InkWell(splashFactory: NoSplash.splashFactory,onTap: (){profileScreenController.index.value = 0;},child: Container(padding: EdgeInsets.symmetric(vertical: size.height*0.01),decoration: BoxDecoration(border: profileScreenController.index.value == 0 ? Border(bottom: BorderSide()): null),alignment: Alignment.center,child:Icon(Icons.grid_on,size: size.width*0.08,),)),),
                    Expanded(child: InkWell(splashFactory: NoSplash.splashFactory,onTap: (){profileScreenController.index.value = 1;},child: Container(padding: EdgeInsets.symmetric(vertical: size.height*0.01),decoration: BoxDecoration(border: profileScreenController.index.value == 1 ? Border(bottom: BorderSide()): null),alignment: Alignment.center,child: Icon(Icons.person_pin_outlined,size: size.width*0.08,),)),),
                  ],
                ),
              ),
              ProfileTabs(posts: posts,)
            ],
          ),
        );
      }
    );
  }
}

class ProfileTabs extends StatelessWidget
{
  final List posts;
  ProfileTabs({required this.posts});
  final profileScreenController = Get.put(ProfileScreenController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if(profileScreenController.index.value == 0) {
      return GridView.builder(shrinkWrap: true,physics: NeverScrollableScrollPhysics(),gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: size.width * 0.4),itemCount: posts.length, itemBuilder: (BuildContext context, int index) {
        final post = posts[index];
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(post["images"][0]))
          ),
        );
      },);
    }
    else
      {
        return Text("Some Other Content");
      }
  }
}