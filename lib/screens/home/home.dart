import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instaclone/widgets/post/followcard.dart';
import 'package:instaclone/widgets/post/homeposts.dart';

class Home extends StatelessWidget {
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
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                if((index+1)%5 == 0){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: size.width*0.07),
                        child: Text("Suggested For You",style: TextStyle(fontSize: size.width*0.05,fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(
                        height: size.height*0.25,
                        child: ListView.builder(padding: EdgeInsets.symmetric(horizontal: size.width*0.035),itemCount: 10,scrollDirection: Axis.horizontal,itemBuilder: (context,index){
                          return FollowCard();
                        }),
                      ),
                      SizedBox(
                        height: size.height*0.02,
                      ),
                    ],
                  );
                }
                return HomePosts();
              }),

          SizedBox(
            height: size.height*0.02,
          ),
        ],
      ),
    );
  }
}
