import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePosts extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            IconButton(onPressed: (){}, icon: FaIcon(FontAwesomeIcons.comment),),
            IconButton(onPressed: (){}, icon: FaIcon(FontAwesomeIcons.share),),
            Spacer(),
            IconButton(onPressed: (){}, icon: Icon(Icons.bookmark_border))
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: size.width*0.04,
            ),
            CircleAvatar(
              radius: 15,
            ),
            SizedBox(
              width: size.width*0.03,
            ),
            Text("Liked by "),
            Text("User1 ",style: TextStyle(fontWeight: FontWeight.bold),),
            Text("and "),
            Text("12 others",style: TextStyle(fontWeight: FontWeight.bold),)
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width*0.04,vertical: size.height*0.01),
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
                TextSpan(text: 'Name ', style: const TextStyle(fontWeight: FontWeight.bold),),
                TextSpan(text: "Caption of the PostCaption of the PostCaption of the PostCaption of the PostCaption of the PostCaption of the Post"),
              ],
            ),
          ),
        )
      ],
    );
  }

}