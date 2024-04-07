import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatList extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  final friendSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(auth.currentUser!.displayName.toString()),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.add),),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(size.width * 0.02),
              ),
              height: size.height * 0.06,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: TextField(
                onChanged: (val) {},
                style: TextStyle(fontSize: size.width * 0.035),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search)),
              ),
            ),
            SizedBox(
              height: size.height*0.01,
            ),
            ListView.builder(
              shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 15,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width*0.04,vertical: size.height*0.01),
                    child: Row(
                      children:[
                        CircleAvatar(
                          radius: size.width*0.08,
                        ),
                        SizedBox(
                          width: size.width*0.03,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("UserName",style: TextStyle(fontWeight: FontWeight.w500),),
                            Row(
                              children: [
                                Text("Have a Nice Day Bro!",style: TextStyle(color: Colors.grey.shade500),),
                                SizedBox(
                                  width: size.width*0.1,
                                ),
                                Text("20m",style: TextStyle(color: Colors.grey),),
                              ],
                            )
                          ],
                        ),
                        Spacer(),
                        IconButton(onPressed: (){}, icon: Icon(Icons.camera_alt_outlined,color: Colors.blue,),),
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        height: size.height*0.06,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt_outlined,color: Colors.blue,),
            SizedBox(
              width: size.width*0.02,
            ),
            Text(
              "Camera",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
      ),
    );
  }
}
