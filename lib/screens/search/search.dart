import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: size.height*0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(size.width*0.02),
                ),
                width: size.width*0.8,
                height: size.height*0.05,
                padding: EdgeInsets.symmetric(horizontal: size.width*0.02),
                child: TextField(
                  style: TextStyle(fontSize: size.width*0.035),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search)
                  ),
                ),
              ),
              IconButton(onPressed: (){}, icon: Icon(Icons.dirty_lens_outlined))
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: size.width*0.03),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Chip(label: Text("IGTV"),avatar: Icon(Icons.tv),),
                  SizedBox(width: size.width*0.02,),
                  Chip(label: Text("IGTV"),avatar: Icon(Icons.tv),),
                  SizedBox(width: size.width*0.02,),
                  Chip(label: Text("IGTV"),avatar: Icon(Icons.tv),),
                  SizedBox(width: size.width*0.02,),
                  Chip(label: Text("IGTV"),avatar: Icon(Icons.tv),),
                  SizedBox(width: size.width*0.02,),
                  Chip(label: Text("IGTV"),avatar: Icon(Icons.tv),),
                  SizedBox(width: size.width*0.02,),
                ],
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: size.width*0.35,mainAxisExtent: size.height*0.17),
              itemCount: 20,
              itemBuilder: (context,index){
            return Container(
              margin: EdgeInsets.all(3),
              color: Colors.grey.shade200,
              child: Text(""),
            );
          })
        ],
      ),
    );
  }

}