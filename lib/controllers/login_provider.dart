import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vizstore_manager/models/store_json.dart';
import 'package:vizstore_manager/repositories/store_repository.dart';


class LoginProvider with ChangeNotifier {
  LoginProvider(
      this._storeRepository);
  bool _passwordVisible = false;
  bool _errorMessage = false;
  bool _isLoggedIn = false;
  StoreJson _user = StoreJson.empty();

  bool get passwordVisible => _passwordVisible;
  bool get isLoggedIn => _isLoggedIn;
  StoreJson get user => _user;

  StoreRepository _storeRepository;

  void changePasswordVisible() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  void changeErrorMessage() {
    _errorMessage = !_errorMessage;
    notifyListeners();
  }
  void setErrorMessage(){
    _errorMessage = false;
  }

  Future<void> signIn(String email, String password) async {
    String? id = await _storeRepository.signIn(email, password);
    await _storeRepository.setUser(id);
    notifyListeners();
  }


/* void getLoggedIn(){
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is currently signed in!');
        getUser();
      }
    });
  }*/

/*void getUser() async {
    _user = await _userRepository.getUser();
    notifyListeners();
    print('prov' + _user.firstName);
  }*/




}
