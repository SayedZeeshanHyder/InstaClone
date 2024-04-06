import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:instaclone/screens/likes/following.dart';
import 'package:instaclone/screens/likes/you.dart';

class LikesScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height*0.05,
        ),
        Expanded(
          child: ContainedTabBarView(
              tabs: [
                Text("Following"),
                Text("You")
              ],
              views: [
                Following(),
                You(),
              ],
          ),
        ),
      ],
    );
  }

}