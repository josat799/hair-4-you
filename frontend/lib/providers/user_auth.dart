import 'package:flutter/material.dart';

enum UserState {
  loggingIn,
  register,
  loggingOut,
  loggedIn,
  LoggedOut,
}

class UserAuth with ChangeNotifier {
  UserAuth(this._clientID);

  UserState _userState;

  String _clientID = '';

  String _tokenExpiryDate = '';

  String _token = '';

  get clientID => this._clientID;

  set clientID(value) {
    this._clientID = value;
    notifyListeners();
  }

  get tokenExpiryDate => this._tokenExpiryDate;

  set tokenExpiryDate(value) {
    this._tokenExpiryDate = value;
    notifyListeners();
  }

  get userState => this._userState;

  set userState(UserState value) {
    this._userState = value;
    notifyListeners();
  }

  get token => this._token;

  set token(value) {
    this._token = value;
    notifyListeners();
  }
}
