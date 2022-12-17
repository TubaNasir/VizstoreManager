import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vizstore_manager/models/product_json.dart';
import 'package:vizstore_manager/models/store_json.dart';

class ProductRepository {
  final db = FirebaseFirestore.instance;
  FirebaseAuth firebaseauth = FirebaseAuth.instance;

  Future<List<ProductJson>> getProductList() async {
    List<ProductJson> products = [];
    await db.collection("product").get().then((event) {
      products =
          event.docs.map((e) => ProductJson.fromJson(e.data(), e.id)).toList();
    }).catchError(
        (error) => print("Failed to fetch products. Error : ${error}"));

    return products;
  }

  Future<List<ProductJson>> getMyProducts() async {
    String? id = await firebaseauth.currentUser?.uid;
    List<ProductJson> products = [];
    await db
        .collection("product")
        .where("storeId", isEqualTo: id)
        .get()
        .then((event) {
      for (var doc in event.docs) {
        products.add(
            ProductJson.fromJson(doc.data() as Map<String, dynamic>, doc.id));
      }
    }).catchError((error) => print("Failed to fetch user. Error : ${error}"));
    print(products);
    return products;
  }

  Future<bool> addProduct(ProductJson product, Uint8List filebytes) async {
    var bool = false;
    String productId = '';
    await db
        .collection("product")
        .add(product.toJson())
        .then((value) =>
            {print(value.id), productId = value.id, print("product added")})
        .catchError((error) => print("Failed to add book. Error : ${error}"));

    final metadata = SettableMetadata(contentType: 'image/jpeg');

    var snapshot = await FirebaseStorage.instance
        .ref(productId)
        .putData(filebytes, metadata);
    String downloadUrl = await snapshot.ref.getDownloadURL();

    await db
        .collection('product')
        .doc(productId)
        .update({'image': downloadUrl})
        .then((value) => {print("image added"), bool = true})
        .catchError((error) => print("Failed to add image. Error : ${error}"));
    return bool;
  }

  Future<ProductJson> changeImage(ProductJson product, Uint8List filebytes) async {
    ProductJson p = ProductJson.empty();

    await FirebaseStorage.instance.refFromURL(product.image).delete();

    final metadata = SettableMetadata(contentType: 'image/jpeg');

    var snapshot = await FirebaseStorage.instance
        .ref(product.id)
        .putData(filebytes, metadata);
    String downloadUrl = await snapshot.ref.getDownloadURL();

    ProductJson updatedImageProduct = product.copyWith(image: downloadUrl);

    p = await updateProduct(updatedImageProduct);

    return p;
  }

  Future<ProductJson> updateProduct(ProductJson product) async {
    ProductJson p = ProductJson.empty();
    print(product.id);
    await db
        .collection("product")
        .doc(product.id)
        .update(product.toJson())
        .then((event) {
      print("product updated");
    }).catchError(
            (error) => print("Failed to update product. Error : ${error}"));

    await db
        .collection('product')
        .doc(product.id)
        .get()
        .then((event) =>
            {
              p = ProductJson.fromJson(event.data() as Map<String, dynamic>, event.id)
            })
        .catchError((error) => print("Failed to get product. Error : ${error}"));
    return p;
  }

}
