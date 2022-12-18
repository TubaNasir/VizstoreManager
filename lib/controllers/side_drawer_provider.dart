import 'package:flutter/foundation.dart';
import '../repositories/store_repository.dart';

class SideDrawerProvider with ChangeNotifier {
  SideDrawerProvider(this._storeRepository);

  StoreRepository _storeRepository;

  String _productPage = 'products';

  String get productPage => _productPage;

  void setPage(String page) => {_productPage = page, notifyListeners()};

  Future<void> logout() async {
    await _storeRepository.signOut();
  }
}
