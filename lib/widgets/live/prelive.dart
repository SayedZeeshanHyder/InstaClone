import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instaclone/widgets/live/livescreen.dart';

class PreLive extends StatefulWidget {

  @override
  State<PreLive> createState() => _PreLiveState();
}

class _PreLiveState extends State<PreLive> {

  final auth = FirebaseAuth.instance;
  TextEditingController liveId = TextEditingController();
  bool isHost = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Section"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width*0.2),
              child: TextField(
                controller: liveId,
                decoration: InputDecoration(
                  hintText: "Enter Live Id",
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Sign As Host"),
                SizedBox(
                  width: size.width*0.05,
                ),
                Switch(value: isHost, onChanged: (val){
                  setState(() {
                    isHost = !isHost;
                  });
                }),
              ],
            ),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> LivePage(liveID: liveId.text, userId: auth.currentUser!.uid, userName: auth.currentUser!.displayName.toString(),isHost: isHost,),),);
            }, child: Text(isHost ? "Create Live" : "Join Live"),),
          ],
        ),
      ),
    );
  }
}
