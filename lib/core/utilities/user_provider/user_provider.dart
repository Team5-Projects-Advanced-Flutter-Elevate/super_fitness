import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/modules/authentication/domain/entities/login/login_data_response_entity.dart';

@singleton
class UserProvider extends ChangeNotifier {
  LoginEntity? _userLoginInfo;
  bool _reloadPreviousChatsOfAiChatPage = false;

  LoginEntity? get userLoginInfo => _userLoginInfo;

  bool get reloadPreviousChatsOfAiChatPage => _reloadPreviousChatsOfAiChatPage;

  void changeUserLoginInfo(LoginEntity? newEntity) {
    if (_userLoginInfo != newEntity) {
      _userLoginInfo = newEntity;
      notifyListeners();
    }
  }

  void changeReloadPreviousChats(bool newValue) {
    _reloadPreviousChatsOfAiChatPage = newValue;
    notifyListeners();
  }
}
