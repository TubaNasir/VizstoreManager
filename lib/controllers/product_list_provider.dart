import 'package:flutter/material.dart';
import 'package:vizstore_manager/models/product_json.dart';
import 'package:vizstore_manager/models/store_json.dart';
import 'package:vizstore_manager/repositories/product_repository.dart';
import 'package:vizstore_manager/repositories/store_repository.dart';


class ProductListProvider with ChangeNotifier {
  ProductListProvider(
      this._storeRepository,
      this._productRepository);

  StoreRepository _storeRepository;
  ProductRepository _productRepository;

  StoreJson _store = StoreJson.empty();
  List<ProductJson> _products = [];
  String _nameInitial = '';
  String _storeInitial = '';
  bool _isLoading = false;

  StoreJson get store => _store;
  List<ProductJson> get products => _products;
  String get nameInitial => _nameInitial;
  String get storeInitial => _storeInitial;
  bool get isLoading => _isLoading;

  Future<void> getStore() async {
    _store = await _storeRepository.getStore();
    notifyListeners();
  }

  void getNameInitial() {
    _nameInitial = _store.storeManager.substring(0,1);
    notifyListeners();
  }

  void getStoreInitial() {
    _storeInitial = _store.storeName.substring(0,1);
    notifyListeners();
  }

  Future<void> getMyProducts() async {
    _isLoading = true;
    notifyListeners();
    _products = await _productRepository.getMyProducts();
    notifyListeners();
    _isLoading = false;
    notifyListeners();
  }

}
