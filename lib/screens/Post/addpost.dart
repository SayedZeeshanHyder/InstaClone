import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclone/controllers/postcontroller.dart';
import 'package:instaclone/screens/Post/postdetails.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';

class AddPost extends StatefulWidget {
  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  List<File> files = [];
  final postController = Get.put(PostController());

  @override
  void initState() {
    super.initState();
    getPost();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.close),
        ),
        title: Text("Next Post"),
        actions: [
          TextButton(
            onPressed: () {
              Get.to(()=>PostDetailsScreen());
            },
            child: Text("Next"),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.5,
            width: double.infinity,
            child: Image.network(
              "https://as2.ftcdn.net/v2/jpg/04/47/04/51/1000_F_447045150_mBUvgsP7J28v5zXCi5hlWU2jD4qdgpVO.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            child: Row(
              children: [
                SizedBox(
                  width: size.width * 0.07,
                ),
                DropdownMenu(
                  initialSelection: "Recents",
                  inputDecorationTheme:
                      InputDecorationTheme(border: InputBorder.none),
                  dropdownMenuEntries: [
                    DropdownMenuEntry(value: "Recents", label: "Recents"),
                  ],
                ),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.camera_alt_outlined),
                ),
              ],
            ),
          ),
          files.isNotEmpty
              ? Expanded(
                  child: GridView.builder(
                      itemCount: files.length,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: size.width * 0.4),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            if(postController.postImages.contains(files[index])){
                              postController.postImages.remove(files[index]);
                            }
                            else{
                              postController.postImages.add(files[index]);
                            }
                          },
                          child: Obx(
                            ()=> Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(2),
                              color: Colors.grey,
                              child: postController.postImages.contains(files[index]) ? const Icon(Icons.check) : Image.file(files[index]),
                            ),
                          ),
                        );
                      }),
                )
              : const CircularProgressIndicator(),
        ],
      ),
    );
  }

  getPost() async {
    if(await Permission.storage.request().isGranted) {
      final List<Album> imageAlbums = await PhotoGallery.listAlbums();
      for (Album i in imageAlbums) {
        final listOfMedia = await i.listMedia();
        for (Medium medium in listOfMedia.items) {
          if (files.length > 40) {
            setState(() {});
            return;
          }
          if(medium.mimeType == 'image/jpeg'){
            files.add(await medium.getFile());
          }
        }
      }
    }
    else{
      print("No Permission");
    }
  }
}
