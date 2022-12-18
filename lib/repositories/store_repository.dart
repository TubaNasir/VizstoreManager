import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vizstore_manager/models/store_json.dart';

class StoreRepository {
  final db = FirebaseFirestore.instance;
  FirebaseAuth firebaseauth = FirebaseAuth.instance;
  StoreJson _user = StoreJson.empty();

  Future<StoreJson> getStore() async {
    String? id = firebaseauth.currentUser?.uid;
    print(id);
    await db.collection("store").doc(id).get().then((event) {
      _user =
          StoreJson.fromJson(event.data() as Map<String, dynamic>, event.id);
    }).catchError((error) => print("Failed to fetch user. Error : ${error}"));
    return _user;
  }

  Future signIn(String email, String password) async {
    User? user;
    try {
      UserCredential userCred = await firebaseauth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCred.user;
      return user?.uid;
    } catch (e) {
      return e;
    }
  }

  Future<void> signOut() async {
    await firebaseauth.signOut();
  }

  Future<void> setUser(String? id) async {
    StoreJson newUser = StoreJson.empty();
    await db.collection("store").doc(id).get().then((event) {
      newUser =
          StoreJson.fromJson(event.data() as Map<String, dynamic>, event.id);
    }).catchError((error) => print("Failed to fetch user. Error : ${error}"));
    print(_user.storeName);
    _user = newUser;
  }
}
