import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Center(
            child: Text("Cancel"),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text("Done"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              CircleAvatar(
                radius: size.width * 0.2,
              ),
              SizedBox(
                height: size.height * 0.023,
              ),
              InkWell(
                splashFactory: NoSplash.splashFactory,
                onTap: () {},
                child: Text(
                  "Change Profile Photo",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: size.width * 0.04),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  SizedBox(
                    width: size.width * 0.26,
                    child: Text(
                      "Name",
                      style: TextStyle(fontSize: size.width * 0.04),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      maxLines: null,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width*0.09,
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  SizedBox(
                    width: size.width * 0.26,
                    child: Text(
                      "Username",
                      style: TextStyle(fontSize: size.width * 0.04),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      maxLines: null,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width*0.09,
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  SizedBox(
                    width: size.width * 0.26,
                    child: Text(
                      "Website",
                      style: TextStyle(fontSize: size.width * 0.04),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      maxLines: null,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width*0.09,
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  SizedBox(
                    width: size.width * 0.26,
                    child: Text(
                      "Bio",
                      style: TextStyle(fontSize: size.width * 0.04),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      maxLines: null,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width*0.09,
                  ),
                ],
              ),

              SizedBox(
                height: size.height*0.02,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: size.width*0.05),
                  child: Text(
                    "Switch to Professional Account",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: size.width * 0.04),
                  ),
                ),
              ),


              SizedBox(
                height: size.height*0.03,
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: size.width*0.05),
                  child: Text(
                    "Private Information",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: size.width * 0.043),
                  ),
                ),
              ),


              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  SizedBox(
                    width: size.width * 0.26,
                    child: Text(
                      "Email",
                      style: TextStyle(fontSize: size.width * 0.04),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      maxLines: null,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width*0.09,
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  SizedBox(
                    width: size.width * 0.26,
                    child: Text(
                      "Phone",
                      style: TextStyle(fontSize: size.width * 0.04),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      maxLines: null,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width*0.09,
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  SizedBox(
                    width: size.width * 0.26,
                    child: Text(
                      "Gender",
                      style: TextStyle(fontSize: size.width * 0.04),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      maxLines: null,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width*0.09,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
