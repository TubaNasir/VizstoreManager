import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:vizstore_manager/models/product_json.dart';
import 'package:vizstore_manager/models/store_json.dart';
import 'package:vizstore_manager/repositories/product_repository.dart';
import 'package:vizstore_manager/repositories/store_repository.dart';

class AddProductProvider with ChangeNotifier {
  AddProductProvider(this._userRepository, this._productRepository);

  StoreRepository _userRepository;
  ProductRepository _productRepository;

  StoreJson _user = StoreJson.empty();
  List<ProductJson> _products = [];
  String _dropdownvalue = "Clothes";
  bool _isAdding = false;

  StoreJson get user => _user;
  List<ProductJson> get products => _products;
  String get dropdownvalue => _dropdownvalue;
  bool get isAdding => _isAdding;

  Future<void> getUser() async {
    _user = await _userRepository.getStore();
    notifyListeners();
  }

  Future<bool> addProduct(String title, String description, int stock,
      int price, String category, Uint8List filebytes) async {
    _isAdding = true;
    notifyListeners();
    var success = await _productRepository.addProduct(
        ProductJson(
            title: title,
            description: description,
            stock: stock,
            price: price,
            category: category,
            storeId: _user.id,
            image: ''),
        filebytes);
    notifyListeners();
    _isAdding = false;
    notifyListeners();
    Toast.show("Product added successfully",
        duration: Toast.lengthShort,
        gravity: Toast.top,
        backgroundColor: Colors.grey,
        backgroundRadius: 20.0);
    return success;
  }

  void setDropdownValue(String value) {
    _dropdownvalue = value;
    notifyListeners();
  }
}
