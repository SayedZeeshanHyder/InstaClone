import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LikesScreen extends StatelessWidget
{
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

          if(snapshot.connectionState == ConnectionState.waiting)
            {
              return const Center(child: CircularProgressIndicator(),);
            }
          final data = snapshot.data!.data();
          print(data!['notification']);
          return Column(
            children: [

            ],
          );
        }
      ),
    );
  }

}