import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:instaclone/screens/Post/addpost.dart';
import 'package:instaclone/screens/auth/login.dart';
import 'package:instaclone/screens/chat/chatlist.dart';
import 'package:instaclone/screens/home/home.dart';
import 'package:instaclone/screens/likes/likes.dart';
import 'package:instaclone/screens/profile/profile.dart';
import 'package:instaclone/screens/reels/reelssection.dart';
import 'package:instaclone/screens/search/search.dart';

class NavigationFile extends StatefulWidget
{
  @override
  State<NavigationFile> createState() => _NavigationFileState();
}

class _NavigationFileState extends State<NavigationFile> {
  int currentIndex = 0;

  static final auth = FirebaseAuth.instance;
  final List<PreferredSizeWidget?> appBars = [
    AppBar(
      title: Text("Instagram",style: TextStyle(fontWeight: FontWeight.bold),),
      centerTitle: true,
      leading: Icon(
        Icons.camera_alt_outlined,
        size: 24,
      ),
      actions: [
        IconButton(
          onPressed: () {
            Get.to(()=>LikesScreen(),transition: Transition.rightToLeft);
          },
          icon: Icon(
            CupertinoIcons.heart,
            size: 24,
          ),
        ),
        IconButton(
          onPressed: () {
            Get.to(()=>ChatList(),transition: Transition.rightToLeft);
          },
          icon: Icon(
            FontAwesomeIcons.paperPlane,
            size: 22,
          ),
        ),
      ],
    ),
    null,
    null,
    null,
    AppBar(
      centerTitle: true,
      title: Text(auth.currentUser!.displayName.toString()),
    ),
  ];


  final bottomNavItems = [
    const BottomNavigationBarItem(icon: SizedBox(width: 20,height: 20,child: Icon(Icons.home),),activeIcon: SizedBox(width: 20,height: 20,child: Icon(Icons.home),),label: ""),
    const BottomNavigationBarItem(icon: Icon(CupertinoIcons.search),label: "",),
    const BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined),label: ''),
    const BottomNavigationBarItem(icon: Icon(Icons.slow_motion_video_sharp),label: ""),
    BottomNavigationBarItem(icon: CircleAvatar(radius: 16,backgroundImage: NetworkImage(auth.currentUser!.photoURL.toString()),),label: "",),
  ];

  final List<Widget> Screens = [
    Home(),
    SearchScreen(),
    AddPost(),
    ReelsSection(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: false,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        items: bottomNavItems,
        currentIndex: currentIndex,
        onTap: (index){
          if(index == 2)
            {
              Get.to(()=>AddPost(),transition: Transition.downToUp);
            }
          else {
            setState(() {
              currentIndex = index;
            });
          }
        },
      ),
      body: Screens[currentIndex],
      appBar: appBars[currentIndex],
      endDrawer: currentIndex == 4 ? Drawer(
        child: Column(
          children: [
            SizedBox(
              height: size.height*0.05,
            ),
            ListTile(
              title: Text(auth.currentUser!.displayName.toString()),
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text("Archieve"),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.clock),
              title: Text("Your Activity"),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.userTag),
              title: Text("NameTag"),
            ),
            ListTile(
              leading: Icon(Icons.bookmark_border),
              title: Text("Saved"),
            ),
            ListTile(
              leading: Icon(Icons.format_list_bulleted),
              title: Text("Close Friends"),
            ),
            ListTile(
              leading: Icon(Icons.person_add),
              title: Text("Discover People"),
            ),
            ListTile(
              leading: Icon(Icons.facebook),
              title: Text("Open Facebook"),
            ),
            Spacer(),
            ListTile(
              onTap: (){
                auth.signOut().then((value){
                  Get.back();
                  Get.off(()=> Login());
                });
              },
              leading: Icon(Icons.logout),
              title: Text("LogOut"),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
            ),
          ],
        ),
      ) : null,
    );
  }
}