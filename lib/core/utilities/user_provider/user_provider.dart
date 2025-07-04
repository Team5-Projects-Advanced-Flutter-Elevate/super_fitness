import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/modules/authentication/domain/entities/login/login_data_response_entity.dart';

@singleton
class UserProvider extends ChangeNotifier {
  LoginEntity? _userLoginInfo;

  LoginEntity? get userLoginInfo => _userLoginInfo;

  void changeUserLoginInfo(LoginEntity? newEntity) {
    if (_userLoginInfo != newEntity) {
      _userLoginInfo = newEntity;
      notifyListeners();
    }
  }
}
