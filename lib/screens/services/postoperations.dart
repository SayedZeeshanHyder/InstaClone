import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostOperations extends GetxController
{
  static final auth = FirebaseAuth.instance;
  static final doc = FirebaseFirestore.instance.collection("AllPosts").doc("AllPosts");

  static likeAPost(updatePost)
  async{
    final get = await doc.get();
    List listOfAllPosts = get.exists ? get.data()!["posts"] : [];
    for(dynamic i in listOfAllPosts)
      {
        if(i["postId"] == updatePost["postId"])
          {
            List likes = i['likes'];
            likes.add(auth.currentUser!.uid);
            print("Post Liked");
            break;
          }
      }

    await doc.update({
      "posts":listOfAllPosts
    });
  }

  static unlikeAPost(updatePost)
  async{
    final get = await doc.get();
    List listOfAllPosts = get.exists ? get.data()!["posts"] : [];
    for(dynamic i in listOfAllPosts)
    {
      if(i["postId"] == updatePost["postId"])
      {
        List likes = i['likes'];
        likes.remove(auth.currentUser!.uid);
        print("Post Like Removed");
        break;
      }
    }

    await doc.update({
      "posts":listOfAllPosts
    });
  }

  static followUser(String userUid)
  async{
    final get = await FirebaseFirestore.instance.collection("Users").doc(userUid).get();
    List listOfFollowers = get.data()!["followers"];
    listOfFollowers.add(auth.currentUser!.uid);
    await FirebaseFirestore.instance.collection("Users").doc(userUid).update(
      {
        "followers":listOfFollowers
      }
    );
    print("followed");
  }

  static unFollow(String userUid)
  async{
    final get = await FirebaseFirestore.instance.collection("Users").doc(userUid).get();
    List listOfFollowers = get.data()!["followers"];
    listOfFollowers.remove(auth.currentUser!.uid);
    await FirebaseFirestore.instance.collection("Users").doc(userUid).update(
        {
          "followers":listOfFollowers
        }
    );
    print("Unfollowed");
  }
}