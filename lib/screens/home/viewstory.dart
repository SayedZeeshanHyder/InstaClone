import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
class ViewStory extends StatefulWidget {

  final tag;
  ViewStory({required this.tag});

  @override
  State<ViewStory> createState() => _ViewStoryState();
}

class _ViewStoryState extends State<ViewStory> {
  final storyController = Get.put(StoryController());

  @override
  void initState() {
    super.initState();
    storyController.startTimer();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    height:size.height*0.9,
                    color: Colors.black,
                    child: Hero(tag: widget.tag,child: Image.network("https://t3.ftcdn.net/jpg/06/06/79/70/240_F_606797008_rGPPk6bFWDQydnX7g7w1w9dVVZ4mD22J.jpg",fit: BoxFit.contain,)),
                  ),
                  Obx(
                    ()=> LinearProgressIndicator(
                      value: storyController.progressVal.value,
                      backgroundColor: Colors.grey.shade800,
                      color: Colors.white,
                    ),
                  ),
                  ListTile(
                    tileColor: Colors.black,
                    textColor: Colors.white,
                    leading: CircleAvatar(),
                    title: Text("UserName",style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Text("Something here"),
                    trailing: IconButton(onPressed: (){},icon: Icon(Icons.more_vert,color: Colors.white,),),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black,
              height: size.height*0.1,
              width: size.width,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: size.width*0.04),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size.width*0.08),
                        border: Border.all(color: Colors.white,),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Send Message",
                          hintStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.heart,color: Colors.white,),),
                  IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.paperPlane,color: Colors.white,),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StoryController extends GetxController
{
  RxDouble progressVal = 0.0.obs;
  startTimer()
  {
    Timer.periodic(const Duration(milliseconds: 35), (timer) async {
      if(progressVal.value > 0.99)
        {
          timer.cancel();
          await Get.delete<StoryController>();
          print("Controller Deleted");
          Get.back();
        }
      progressVal.value += 0.01;
    });
  }
}