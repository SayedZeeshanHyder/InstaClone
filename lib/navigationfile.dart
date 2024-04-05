import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:instaclone/screens/Post/addpost.dart';
import 'package:instaclone/screens/auth/login.dart';
import 'package:instaclone/screens/home/home.dart';
import 'package:instaclone/screens/likes/likes.dart';
import 'package:instaclone/screens/profile/profile.dart';
import 'package:instaclone/screens/search/search.dart';

class NavigationFile extends StatefulWidget
{
  @override
  State<NavigationFile> createState() => _NavigationFileState();
}

class _NavigationFileState extends State<NavigationFile> {
  int currentIndex = 0;

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
          onPressed: () {},
          icon: Icon(
            Icons.live_tv_rounded,
            size: 24,
          ),
        ),
        IconButton(
          onPressed: () {},
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
      title: Text("thelegend101z"),
    ),
  ];

  final bottomNavItems = [
    BottomNavigationBarItem(icon: SizedBox(width: 20,height: 20,child: SvgPicture.asset('assets/icons/homeOutline.svg',fit: BoxFit.contain,),),activeIcon: SizedBox(width: 20,height: 20,child: SvgPicture.asset('assets/icons/homeFilled.svg')),label: ""),
    const BottomNavigationBarItem(icon: Icon(CupertinoIcons.search),label: "",),
    const BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined),label: ''),
    const BottomNavigationBarItem(icon: Icon(CupertinoIcons.heart),activeIcon: Icon(CupertinoIcons.heart_fill),label: ""),
    const BottomNavigationBarItem(icon: CircleAvatar(radius: 16,backgroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/6/6e/Shah_Rukh_Khan_graces_the_launch_of_the_new_Santro.jpg'),),label: "",),
  ];

  final List<Widget> Screens = [
    Home(),
    SearchScreen(),
    AddPost(),
    LikesScreen(),
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
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: Screens[currentIndex],
      appBar: appBars[currentIndex],
      endDrawer: currentIndex == 4 ? Drawer(
        child: Column(
          children: [
            ListTile(
              onTap: (){
                Get.back();
                Get.off(()=>Login(),transition: Transition.fade);
              },
              title: Text("Logout"),
            ),
          ],
        ),
      ) : null,
    );
  }
}