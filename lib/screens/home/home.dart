import 'package:flutter/material.dart';
import 'package:instaclone/widgets/post/homeposts.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
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
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, index) {
                return HomePosts();
              })
        ],
      ),
    );
  }
}
