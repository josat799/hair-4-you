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

  Map<String, dynamic> _user;

  int? _id;

  UserState _userState = UserState.LoggedOut;

  String _clientID = '';

  String? _tokenExpiryDate = '';

  String? _token = '';

  get user => this._user;

  set user(Map<String, dynamic> value) {
    this._user = value;
    notifyListeners();
  }

  int? get id => this._id;

  set id(int? value) {
    this._id = value;
    notifyListeners();
  }

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

  UserState get userState => this._userState;

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
