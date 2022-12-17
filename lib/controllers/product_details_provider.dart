import 'dart:typed_data';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:vizstore_manager/constants.dart';
import 'package:vizstore_manager/models/product_json.dart';
import 'package:vizstore_manager/models/store_json.dart';
import 'package:vizstore_manager/repositories/product_repository.dart';
import 'package:vizstore_manager/repositories/store_repository.dart';


class ProductDetailsProvider with ChangeNotifier {
  ProductDetailsProvider(
      this._userRepository,
      this._productRepository);

  StoreRepository _userRepository;
  ProductRepository _productRepository;

  ProductJson _product = ProductJson.empty();
  StoreJson _user = StoreJson.empty();
  bool _editable = false;
  String _dropdownvalue = "Clothes";

  StoreJson get user => _user;
  bool get editable => _editable;
  String get dropdownvalue => _dropdownvalue;

  Future<void> setProduct(ProductJson product) async {
    _product = product;
    notifyListeners();
  }

  Future<void> getUser() async {
    _user = await _userRepository.getStore();
    notifyListeners();
    print('prodlist provider' + _user.storeName);
  }

  Future<void> updateProduct(String title, String description, int stock, int price, String category) async {
    ProductJson product = _product.copyWith(title:title, description: description, stock: stock, price: price, category:category);
    ProductJson updatedProduct = await _productRepository.updateProduct(product);
    _product = updatedProduct;
    notifyListeners();
    print(_product.title);
  }


  void changeEditable() {
    _editable = !editable;
    notifyListeners();
  }

  void setDropdownValue(String value){
    _dropdownvalue = value;
    notifyListeners();
  }

  void changeImage(Uint8List fileBytes) async{
    ProductJson updatedProduct = await _productRepository.changeImage(_product, fileBytes);
    _product = updatedProduct;
    notifyListeners();
  }

}
