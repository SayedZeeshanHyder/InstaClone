import 'package:flutter/material.dart';

class FollowCard extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: size.width*0.1,
            ),
            Text("Username",style: TextStyle(fontSize: size.width*0.05),),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width*0.03,vertical: size.height*0.008),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.circular(size.width*0.02),
              ),
              child: Text("Follow",style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }

}