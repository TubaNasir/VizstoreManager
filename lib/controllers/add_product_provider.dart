import 'dart:typed_data';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:vizstore_manager/constants.dart';
import 'package:vizstore_manager/models/product_json.dart';
import 'package:vizstore_manager/models/store_json.dart';
import 'package:vizstore_manager/repositories/product_repository.dart';
import 'package:vizstore_manager/repositories/store_repository.dart';


class AddProductProvider with ChangeNotifier {
  AddProductProvider(
      this._userRepository,
      this._productRepository);

  StoreRepository _userRepository;
  ProductRepository _productRepository;

  StoreJson _user = StoreJson.empty();
  List<ProductJson> _products = [];

  StoreJson get user => _user;
  List<ProductJson> get products => _products;

  Future<void> getUser() async {
    _user = await _userRepository.getStore();
    notifyListeners();
    print('prodlist provider' + _user.storeName);
  }

  Future<bool> addProduct(String title, String description, int stock, int price, String category, Uint8List filebytes) async {
  print('prod prov ${_user.id}');
  print("cat ${category}");
  var success =  await _productRepository.addProduct(
      ProductJson(title: title, description: description, stock: stock, price: price, category: category, storeId: _user.id, image: '')
    , filebytes);
    notifyListeners();
    return success;
  }

  void showCartToast(){
    Fluttertoast.showToast(
        msg: "Product has been added successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: SecondaryColor,
        textColor: Colors.black
    );
  }
}
