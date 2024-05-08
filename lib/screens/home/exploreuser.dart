import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclone/screens/services/postoperations.dart';
import '../../controllers/profilescreencontroller.dart';
import '../profile/profile.dart';

class ExploreUser extends StatelessWidget {
  final String userUid;
  final profileScreenController = Get.put(ProfileScreenController());
  final auth = FirebaseAuth.instance;

  ExploreUser({required this.userUid});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("z@gmail.com"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Users")
              .doc(userUid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final data = snapshot.data!.data();
            List followers = data!['followers'];
            List posts = data['posts'];
            List following = data['following'];
            final String bio = data['bio'];
            final String name = data['name'];
            final String profileUrl = data['profileUrl'];

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
                          backgroundImage: NetworkImage(profileUrl),
                          radius: size.width * 0.125,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            posts.length.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.06),
                          ),
                          Text("Posts")
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            followers.length.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.06),
                          ),
                          Text("Followers")
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            following.length.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.06),
                          ),
                          Text("Following"),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.1, top: size.height * 0.015),
                    child: Text(
                      name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.055),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    child: Text(
                      bio,
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: size.width * 0.035,
                      ),
                      Expanded(
                        flex: 6,
                        child: InkWell(
                          onTap: () {
                            if (followers.contains(auth.currentUser!.uid)) {
                              PostOperations.unFollow(data['uid']);
                            } else {
                              PostOperations.followUser(data["uid"]);
                              PostOperations.sendFollowNotification(data);
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: size.height * 0.06,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.circular(size.width * 0.035)),
                            child: followers.contains(auth.currentUser!.uid)
                                ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.check,color: Colors.white,),
                                      SizedBox(
                                        width: size.width*0.03,
                                      ),
                                      Text(
                                        "Following",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )
                                : Text(
                                    "Follow",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      Expanded(
                        flex: 6,
                        child: Container(
                          alignment: Alignment.center,
                          height: size.height * 0.06,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(size.width * 0.035),
                            border: Border.all(width: 2),
                          ),
                          child: Text(
                            "Subscribe",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
                          height: size.height * 0.06,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(size.width * 0.035),
                            border: Border.all(width: 2),
                          ),
                          child: Icon(Icons.person_add),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  SizedBox(
                    height: size.height * 0.15,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ListView.builder(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.02),
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
                    ),
                  ),
                  Obx(
                    () => Row(
                      children: [
                        Expanded(
                          child: InkWell(
                              splashFactory: NoSplash.splashFactory,
                              onTap: () {
                                profileScreenController.index.value = 0;
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: size.height * 0.01),
                                decoration: BoxDecoration(
                                    border:
                                        profileScreenController.index.value == 0
                                            ? Border(bottom: BorderSide())
                                            : null),
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.grid_on,
                                  size: size.width * 0.08,
                                ),
                              )),
                        ),
                        Expanded(
                          child: InkWell(
                              splashFactory: NoSplash.splashFactory,
                              onTap: () {
                                profileScreenController.index.value = 1;
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: size.height * 0.01),
                                decoration: BoxDecoration(
                                    border:
                                        profileScreenController.index.value == 1
                                            ? Border(bottom: BorderSide())
                                            : null),
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.person_pin_outlined,
                                  size: size.width * 0.08,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                  ProfileTabs(
                    posts: posts,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
