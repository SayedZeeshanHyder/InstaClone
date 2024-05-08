import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostOperations extends GetxController
{
  static final auth = FirebaseAuth.instance;
  static final doc = FirebaseFirestore.instance.collection("AllPosts").doc("AllPosts");

  static likeAPost(updatePost)
  async{

    final userDoc = FirebaseFirestore.instance.collection("Users").doc(updatePost["uid"]);

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

    final get2 = await userDoc.get();
    listOfAllPosts = get2.exists ? get2.data()!["posts"] : [];
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

    await userDoc.update({
      "posts":listOfAllPosts
    });

  }

  static unlikeAPost(updatePost)
  async{
    final userDoc = FirebaseFirestore.instance.collection("Users").doc(updatePost["uid"]);

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

    final get2 = await userDoc.get();
    listOfAllPosts = get2.exists ? get2.data()!["posts"] : [];
    for(dynamic i in listOfAllPosts)
    {
      if(i["postId"] == updatePost["postId"])
      {
        List likes = i['likes'];
        likes.remove(auth.currentUser!.uid);
        print("Post Liked");
        break;
      }
    }

    await userDoc.update({
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

  static sendLikedNotification(postData)
  async {
    final userDoc = FirebaseFirestore.instance.collection("Users").doc(postData["uid"]);
    final get = await userDoc.get();
    List listOfNotification = get.exists ? get.data()!['notification'] : [];
    final notification = {"postId": postData["postId"], "time": DateTime.now(), "postImageUrl": postData['images'][0], "message": "Liked your post", "oppUserProfileUrl": auth.currentUser!.photoURL, "oppUser": auth.currentUser!.uid,"oppUserName":auth.currentUser!.displayName};
    listOfNotification.insert(0,notification);
    await userDoc.update(
      {"notification" : listOfNotification,}
    );
    print("Like Notification sent to User");
  }

  static sendFollowNotification(data)
  async {
    final userDoc = FirebaseFirestore.instance.collection("Users").doc(data["uid"]);
    final get = await userDoc.get();
    List listOfNotification = get.exists ? get.data()!['notification'] : [];
    final notification = {"postId": "", "time": DateTime.now(), "postImageUrl": "", "message": "Started following you", "oppUserProfileUrl": auth.currentUser!.photoURL, "oppUser": auth.currentUser!.uid,"oppUserName":auth.currentUser!.displayName};
    listOfNotification.insert(0,notification);
    await userDoc.update(
        {"notification" : listOfNotification,}
    );
    print("Follow Notification sent to User");
  }
}