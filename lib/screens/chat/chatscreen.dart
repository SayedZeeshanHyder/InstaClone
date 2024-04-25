import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class ChatScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        title: Row(
          children: [
            CircleAvatar(
              radius: size.width*0.05,
            ),
            SizedBox(
              width: size.width*0.05,
            ),
            Text("Chat Name"),
          ],
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.phone),),
          IconButton(onPressed: (){}, icon: Icon(Icons.videocam_outlined),),
        ],
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(reverse: true,itemCount: 5,itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: size.width*0.02,
                    ),
                    CircleAvatar(),
                    SizedBox(
                      width: size.width*0.02,
                    ),
                    Container(
                      height: size.height*0.34,
                      width: size.width*0.4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(size.width*0.04)
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          SizedBox(
            height: size.height*0.074,
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width*0.02),
        height: size.height*0.065,
        width: size.width*0.95,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(size.width*0.07),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              child: Icon(Icons.camera_alt_outlined,),
            ),
            SizedBox(
              width: size.width*0.04,
            ),
            Expanded(child: TextField(
              decoration: InputDecoration(
                hintText: "Message",
                border: InputBorder.none,
              ),
            ),),
            IconButton(onPressed: (){}, icon: Icon(Icons.mic),),
            IconButton(onPressed: (){}, icon: Icon(Icons.photo),),
            IconButton(onPressed: (){}, icon: Icon(Icons.sticky_note_2),),
          ],
        ),
      ),
    );
  }
}
