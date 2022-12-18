import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vizstore_manager/models/order_json.dart';
import 'package:vizstore_manager/models/product_json.dart';
import 'package:vizstore_manager/models/store_json.dart';
import 'package:vizstore_manager/models/user_json.dart';
import 'package:vizstore_manager/repositories/order_repository.dart';
import 'package:vizstore_manager/repositories/product_repository.dart';
import 'package:vizstore_manager/repositories/store_repository.dart';
import 'package:vizstore_manager/repositories/user_repository.dart';


class OrderDetailsProvider with ChangeNotifier {
  OrderDetailsProvider(
      this._orderRepository,
      this._userRepository,
      this._productRepository);

  OrderRepository _orderRepository;
  UserRepository _userRepository;
  ProductRepository _productRepository;

  OrderJson _order = OrderJson.empty();
  UserJson _user = UserJson.empty();
  List<ProductJson> _products = [];

  OrderJson get order => _order;
  UserJson get user => _user;


  Future<void> getOrderInfo(String id) async {
    _order = await _orderRepository.getOrderInfo(id);
    notifyListeners();
  }

  Future<void> getUserInfo() async {
    _user = await _userRepository.getUser(_order.userId!);
    notifyListeners();
  }

  Future<void> getAllProducts() async {
    _products = await _productRepository.getProductList();
}

  ProductJson getProductInfo(String id) {
    ProductJson product = ProductJson.empty();
    for (var item in _products) {
      if(id == item.id){
        product = item;
      }
    }
    return product;
  }

  List<ProductJson> getProductList(OrderJson order){
    List<ProductJson> products = order.cart.map((e) => getProductInfo(e.productId)).cast<ProductJson>().toList();
    return products;
  }

  Future<void> updateOrderStatus(String status) async {
    OrderJson order = _order.copyWith(status: status);
    await _orderRepository.updateOrder(order);
    _order = await _orderRepository.getOrderInfo(_order.id!);
    notifyListeners();
  }
}
