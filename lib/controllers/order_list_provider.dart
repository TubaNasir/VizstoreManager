import 'package:flutter/material.dart';
import 'package:vizstore_manager/models/order_json.dart';
import 'package:vizstore_manager/repositories/order_repository.dart';


class OrderListProvider with ChangeNotifier {
  OrderListProvider(
      this._orderRepository,
    );

  OrderRepository _orderRepository;

  List<OrderJson> _orders = [];
  bool _isLoading = false;

  List<OrderJson> get orders => _orders;
  bool get isLoading => _isLoading;

  Future<void> getMyOrders() async {
    _isLoading = true;
    notifyListeners();
    _orders = await _orderRepository.getMyOrders();
    notifyListeners();
    _isLoading = false;
    notifyListeners();
  }

}
