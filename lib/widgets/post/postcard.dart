import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostCard extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Divider(color: Colors.grey.shade300,),
        Row(
          children: [
            SizedBox(
              width: size.width*0.05,
            ),
            CircleAvatar(),
            SizedBox(
              width: size.width*0.04,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name",style: TextStyle(fontWeight: FontWeight.w600,fontSize: size.width*0.045),),
                Text("Location"),
              ],
            ),
            Spacer(),
            IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz),),
          ],
        ),
        SizedBox(
          height: size.height*0.02,
        ),
        SizedBox(
          height: size.height*0.35,
          child: Image.network("https://img.freepik.com/free-photo/painting-mountain-lake-with-mountain-background_188544-9126.jpg?size=626&ext=jpg",fit: BoxFit.cover,),
        ),
        Row(
          children: [
            IconButton(onPressed: (){}, icon: FaIcon(FontAwesomeIcons.heart),),
          ],
        ),
      ],
    );
  }

}