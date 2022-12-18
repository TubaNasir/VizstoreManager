import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vizstore_manager/models/order_json.dart';

class OrderRepository {
  final db = FirebaseFirestore.instance;
  FirebaseAuth firebaseauth = FirebaseAuth.instance;

  Future<List<OrderJson>> getMyOrders() async {
    String? id = firebaseauth.currentUser?.uid;
    print(id);
    List<OrderJson> products = [];
    await db
        .collection("order")
        .where("storeId", isEqualTo: id)
        .get()
        .then((event) {
      for (var doc in event.docs) {
        products.add(
            OrderJson.fromJson(doc.data() as Map<String, dynamic>, doc.id));
      }
    }).catchError((error) => print("Failed to fetch user. Error : ${error}"));
    return products;
  }

  Future<OrderJson> getOrderInfo(String id) async {

    OrderJson order = OrderJson.empty();

    await db.collection("order").doc(id).get().then((event) {
      order = OrderJson.fromJson(event.data() as Map<String, dynamic>, event.id);
    }).catchError((error) => print("Failed to fetch store. Error : ${error}"));
    return order;
  }

  Future<void> updateOrder(OrderJson order) async {
    await db
        .collection("order")
        .doc(order.id)
        .update(order.toJson())
        .then((event) {
      print("order updated");
    }).catchError((error) => print("Failed to update order. Error : ${error}"));
  }


}