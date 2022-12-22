import 'package:flutter/material.dart';
import 'package:vizstore_manager/models/order_json.dart';
import 'package:vizstore_manager/models/user_json.dart';
import 'package:vizstore_manager/repositories/order_repository.dart';
import 'package:vizstore_manager/repositories/user_repository.dart';


class OrderListProvider with ChangeNotifier {
  OrderListProvider(
      this._orderRepository,
      this._userRepository,
    );

  OrderRepository _orderRepository;
  UserRepository _userRepository;

  List<OrderJson> _orders = [];
  List<UserJson> _users = [];
  bool _isLoading = false;
  UserJson _user = UserJson.empty();

  List<OrderJson> get orders => _orders;
  List<UserJson> get users => _users;
  bool get isLoading => _isLoading;
  UserJson get user => _user;

  Future<void> getMyOrders() async {
    List<OrderJson> _orderslist = [];

    _isLoading = true;
    notifyListeners();
    _orderslist = await _orderRepository.getMyOrders();
    if (_orderslist.isNotEmpty) {
      _orderslist.sort((b, a) => a.date_created.compareTo(b.date_created));
    }
    _orders = _orderslist;
    notifyListeners();
    _isLoading = false;
    notifyListeners();
  }

  Future<UserJson> getUser(String id) async {
    _user = await _userRepository.getUser(id);
    notifyListeners();
    return _user;
  }

  Future<List<UserJson>> getUsers() async {
    _users = await _userRepository.fetchUsersList();
    notifyListeners();
    return _users;
  }


}
