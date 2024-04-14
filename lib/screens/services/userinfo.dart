import 'package:cloud_firestore/cloud_firestore.dart';

class UserData
{
  static final collection = FirebaseFirestore.instance.collection("Users");
  static fetchUserDataUsingUid(String uid)
  async{
    final get = await collection.doc(uid).get();
    final data = get.data();
    return data;
  }
}