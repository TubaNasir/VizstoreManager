import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vizstore_manager/models/store_json.dart';
import 'package:vizstore_manager/repositories/store_repository.dart';
import 'package:toast/toast.dart';

class LoginProvider with ChangeNotifier {
  LoginProvider(
      this._storeRepository);
  bool _passwordVisible = false;
  bool _errorMessage = false;
  bool _isLoggedIn = false;
  StoreJson _user = StoreJson.empty();
  bool _isLoading = false;

  bool get passwordVisible => _passwordVisible;
  bool get isLoggedIn => _isLoggedIn;
  StoreJson get user => _user;
  bool get isLoading => _isLoading;

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

  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    dynamic result = await _storeRepository.signIn(email, password);

    if(result is String){
      await _storeRepository.setUser(result);
      notifyListeners();
      _isLoading = false;
      notifyListeners();
      return true;
    }
    else if(result is FirebaseAuthException){
      Toast.show("Incorrect Email or Password", duration: Toast.lengthShort, gravity: Toast.top, backgroundColor: Colors.grey, backgroundRadius: 20.0);
      print('icorrect');
      _isLoading = false;
      notifyListeners();
      return false;
    }
    _isLoading = false;
    notifyListeners();
    return false;

  }


}
