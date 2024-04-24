import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:instaclone/screens/home/exploreuser.dart';
import 'package:instaclone/screens/services/postoperations.dart';
import 'package:instaclone/widgets/post/followcard.dart';

class Home extends StatelessWidget {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.15,
            child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
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
          Divider(),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("AllPosts")
                  .doc("AllPosts")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(),);
                }
                List listOfAllPosts;
                try {
                  listOfAllPosts = snapshot.data!.data()!["posts"];
                } catch (e) {
                  return const Center(child: Text("No Posts Available"),);
                }

                return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: listOfAllPosts.length,
                    itemBuilder: (context, index) {
                      if (listOfAllPosts[index]['uid'] ==
                          auth.currentUser!.uid) {
                        return const SizedBox();
                      }
                      if ((index + 1) % 5 == 0) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: size.width * 0.07),
                              child: Text(
                                "Suggested For You",
                                style: TextStyle(
                                    fontSize: size.width * 0.05,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.25,
                              child: ListView.builder(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.035),
                                  itemCount: 10,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return FollowCard();
                                  }),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                          ],
                        );
                      }
                      final postData = listOfAllPosts[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.05,
                              ),
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(postData["profileUrl"]),
                              ),
                              SizedBox(
                                width: size.width * 0.04,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(
                                          () => ExploreUser(
                                                userUid: postData['uid'],
                                              ),
                                          transition: Transition.rightToLeft);
                                    },
                                    child: Text(
                                      postData['by'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: size.width * 0.045),
                                    ),
                                  ),
                                  Text("Location"),
                                ],
                              ),
                              SizedBox(
                                width: size.width * 0.03,
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.more_horiz),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          SizedBox(
                            height: size.height * 0.3,
                            child: ListView.builder(
                              itemCount: postData['images'].length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final images = postData["images"][index];
                                return SizedBox(
                                  width: size.width,
                                  child: Image.network(
                                    images,
                                    fit: BoxFit.fill,
                                  ),
                                );
                              },
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  if (postData['likes']
                                      .contains(auth.currentUser!.uid)) {
                                    PostOperations.unlikeAPost(postData);
                                  } else {
                                    PostOperations.likeAPost(postData);
                                  }
                                },
                                icon: Icon(
                                  postData['likes']
                                          .contains(auth.currentUser!.uid)
                                      ? CupertinoIcons.heart_fill
                                      : CupertinoIcons.heart,
                                  color: postData['likes']
                                          .contains(auth.currentUser!.uid)
                                      ? Colors.red
                                      : Colors.black,
                                  fill: 1,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  showFlexibleBottomSheet(
                                    initHeight: 0.8,
                                    maxHeight: 0.9,
                                      bottomSheetBorderRadius: BorderRadius.vertical(top: Radius.circular(size.width*0.05),),
                                      context: context,
                                      builder: (context, controller, offset) {
                                        return Column(
                                          children: [
                                            SizedBox(
                                              height: size.height*0.015,
                                            ),
                                            Text("Comments",style: TextStyle(fontWeight: FontWeight.bold,fontSize: size.width*0.05),),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: size.width*0.06,
                                                ),
                                                Expanded(child: Divider(),),
                                                SizedBox(
                                                  width: size.width*0.06,
                                                ),
                                              ],
                                            ),
                                            Expanded(
                                              child: ListView.builder(itemCount: 20,itemBuilder: (context,index){
                                                return ListTile(
                                                  leading: CircleAvatar(
                                                    radius: size.width*0.05,
                                                  ),
                                                  title: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text("thelegend101z",style: TextStyle(fontWeight: FontWeight.bold),),
                                                          SizedBox(
                                                            width: size.width*0.02,
                                                          ),
                                                          Text("8w",style: TextStyle(fontSize: size.width*0.0375,color: Colors.grey),),
                                                        ],
                                                      ),
                                                      Text("Just writing the Comment trying zyada ",style: TextStyle(fontSize: size.width*0.0375),),
                                                      Text("Reply",style: TextStyle(fontSize: size.width*0.0375,color: Colors.grey),)
                                                    ],
                                                  ),
                                                  trailing: IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.heart),),
                                                );
                                              }),
                                            ),
                                          ],
                                        );
                                      });
                                },
                                icon: FaIcon(FontAwesomeIcons.comment),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: FaIcon(FontAwesomeIcons.share),
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.bookmark_border),
                              ),
                            ],
                          ),
                          postData["likes"].isNotEmpty
                              ? Row(
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.04,
                                    ),
                                    CircleAvatar(
                                      radius: 15,
                                    ),
                                    SizedBox(
                                      width: size.width * 0.03,
                                    ),
                                    Text("Liked by "),
                                    Text(
                                      "User1",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("and "),
                                    Text(
                                      "12 others",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              : const SizedBox(),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.04,
                                vertical: size.height * 0.01),
                            child: RichText(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "${postData['by']} ",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(text: postData["caption"]),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: size.width * 0.04),
                            child: Text(
                              "${postData['comments'].length} comments",
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                        ],
                      );
                    });
              }),
          SizedBox(
            height: size.height * 0.02,
          ),
        ],
      ),
    );
  }
}
