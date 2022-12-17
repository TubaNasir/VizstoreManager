import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vizstore_manager/models/order_json.dart';
import 'package:vizstore_manager/models/product_json.dart';
import 'package:vizstore_manager/models/store_json.dart';
import 'package:vizstore_manager/repositories/order_repository.dart';
import 'package:vizstore_manager/repositories/product_repository.dart';
import 'package:vizstore_manager/repositories/store_repository.dart';
import 'package:vizstore_manager/repositories/user_repository.dart';


class OrderListProvider with ChangeNotifier {
  OrderListProvider(
      this._storeRepository,
      this._orderRepository,
      this._userRepository);

  StoreRepository _storeRepository;
  OrderRepository _orderRepository;
  UserRepository _userRepository;

  StoreJson _user = StoreJson.empty();
  List<OrderJson> _orders = [];

  StoreJson get user => _user;
  List<OrderJson> get orders => _orders;

  Future<void> getStore() async {
    _user = await _storeRepository.getStore();
    notifyListeners();
  }

  Future<void> getMyOrders() async {
    _orders = await _orderRepository.getMyOrders();
    notifyListeners();
  }

}
