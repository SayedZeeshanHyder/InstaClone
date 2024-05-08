import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LikesScreen extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  final userCollection = FirebaseFirestore.instance.collection("Users");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Likes"),
      ),
      body: StreamBuilder(
          stream: userCollection.doc(auth.currentUser!.uid).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final data = snapshot.data!.data();
            List listOfNotifications = data!['notification'];
            if(listOfNotifications.isEmpty)
              {
                return Center(child: Text("No Notifications Yet"),);
              }
            return ListView.builder(
                itemCount: listOfNotifications.length,
                itemBuilder: (context, index) {
                  final notification = listOfNotifications[index];

                  final String message = notification['message'];
                  final time = notification['time'].toDate();
                  final String oppUser = notification['oppUser'];
                  final String oppUserName = notification['oppUserName'];
                  final String oppUserProfileUrl =
                      notification['oppUserProfileUrl'];
                  final String postImageUrl = notification['postImageUrl'];
                  final String postId = notification['postId'];
                  return Row(
                    children: [
                      SizedBox(
                        width: size.width*0.03,
                      ),
                      CircleAvatar(
                        backgroundImage: NetworkImage(oppUserProfileUrl),
                      ),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: oppUserName,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width * 0.05),
                              ),
                              TextSpan(
                                text: "  ",
                                style: TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                text: message,
                                style: TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                text: "  ",
                                style: TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                text: "2d",
                                style: TextStyle(color: Colors.grey.shade400),
                              ),
                            ],
                          ),
                        ),
                      ),
                      postId != "" ? CircleAvatar(
                        backgroundImage: NetworkImage(postImageUrl),
                      ) : SizedBox(),
                      SizedBox(
                        width: size.width*0.03,
                      ),
                    ],
                  );
                });
          }),
    );
  }
}
