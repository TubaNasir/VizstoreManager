import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vizstore_manager/models/notification_json.dart';
import 'package:vizstore_manager/models/user_json.dart';


class UserRepository {
  final db = FirebaseFirestore.instance;
  FirebaseAuth firebaseauth = FirebaseAuth.instance;

  UserJson _user = UserJson.empty();

  Future<UserJson> getUser(String id) async {
    await db.collection("user").doc(id).get().then((event) {
      _user = UserJson.fromJson(event.data() as Map<String, dynamic>, event.id);
    }).catchError(
            (error) => print("Failed to fetch user. Error : ${error}"));
    return _user;
  }

  Future<void> sendNotification(NotificationItemJson notification, String id) async {
    print(notification.notificationId);
    print(id);
    await db.collection("user").doc(id).update({"notifications": FieldValue.arrayUnion([notification.toJson()])}).catchError(
            (error) => print("Failed to add notification. Error : ${error}"));
  }




}
