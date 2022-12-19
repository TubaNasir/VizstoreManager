import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
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
  bool _isEditing = false;

  StoreJson get user => _user;
  bool get editable => _editable;
  String get dropdownvalue => _dropdownvalue;
  bool get isEditing => _isEditing;

  Future<void> setProduct(ProductJson product) async {
    _product = product;
    notifyListeners();
  }

  Future<void> getUser() async {
    _user = await _userRepository.getStore();
    notifyListeners();
  }

  Future<void> updateProduct(String title, String description, int stock, int price, String category) async {
    _isEditing = true;
    notifyListeners();
    ProductJson product = _product.copyWith(title:title, description: description, stock: stock, price: price, category:category);
    ProductJson updatedProduct = await _productRepository.updateProduct(product);
    _product = updatedProduct;
    notifyListeners();
    _isEditing = false;
    notifyListeners();
    Toast.show("Product updated", duration: Toast.lengthShort, gravity: Toast.top, backgroundColor: Colors.grey, backgroundRadius: 20.0);
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
    _isEditing = true;
    notifyListeners();
    ProductJson updatedProduct = await _productRepository.changeImage(_product, fileBytes);
    _product = updatedProduct;
    notifyListeners();
    _isEditing = false;
    notifyListeners();
  }

}
