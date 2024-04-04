import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instaclone/widgets/post/postcard.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.camera_alt,size: size.width*0.08,),
        title: Text("Instagram"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.live_tv_rounded,size: size.width*0.07,),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.telegram,size: size.width*0.08,),
          ),
        ],
      ),



      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height*0.15,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: size.width*0.02),
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(size.width*0.015),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.pinkAccent,
                            radius: size.width * 0.1,
                            child: CircleAvatar(
                              radius: size.width*0.093,
                            ),
                          ),
                          SizedBox(
                            height: size.height*0.01,
                          ),
                          Text("User$index")
                        ],
                      ),
                    );
                  }),
            ),
            PostCard(),
          ],
        ),
      ),
    );
  }
}
