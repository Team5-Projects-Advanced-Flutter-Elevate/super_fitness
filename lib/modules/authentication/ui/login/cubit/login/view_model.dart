import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/di/injectable_initializer.dart';
import 'package:super_fitness/core/utilities/social_accounts_sign_in/google_sign_in/google_sign_in_handler.dart';
import 'package:super_fitness/core/utilities/user_provider/user_provider.dart';
import 'package:super_fitness/modules/authentication/domain/usecase/login/login_local.dart';

import '../../../../../../core/apis/api_result/api_result.dart';
import '../../../../domain/entities/login/login_data_response_entity.dart';
import '../../../../domain/usecase/login/login.dart';
import '../../state.dart';

@injectable
class LoginViewModel extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  final GoogleSignInHandler _googleSignInHandler;
  final StoreLoginLocalUseCase _loginLocalUseCase;

  LoginViewModel(
    this._loginUseCase,
    this._googleSignInHandler,
    this._loginLocalUseCase,
  ) : super(const LoginState());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void doIntent(LoginIntent intent) {
    switch (intent) {
      case Login():
        _login(intent.email, intent.password);
        break;
      case GoogleLogin():
        //_googleLogin();
        break;

      case GetData():
        _getData();
        break;

      case ClearData():
        _clearData();
        break;
    }
  }

  void _login(String email, String password) async {
    emit(const LoginState(loginStatus: Status.loading));
    var useCaseResult = await _loginUseCase.call(email, password);

    switch (useCaseResult) {
      case Success<LoginEntity>():
        await _storeData(useCaseResult.data);
        emit(const LoginState(loginStatus: Status.success));

        Future.delayed(const Duration(milliseconds: 100), () {
          emit(const LoginState(loginStatus: Status.idle));
        });

      case Error<LoginEntity>():
        emit(LoginState(loginStatus: Status.error, error: useCaseResult.error));
    }
  }

  // void _googleLogin() async {
  //   emit(const LoginState(loginStatus: Status.loading));
  //   var googleUserAccount = await _googleSignInHandler.getUserGoogleAccount();
  //
  //   if (googleUserAccount == null) {
  //     emit(const LoginState(loginStatus: Status.idle));
  //     return;
  //   }
  //   var googleLogin = await _signInWithGoogleAccountUseCase.call(
  //     googleUserAccount,
  //   );
  //   switch (googleLogin) {
  //     case Success<UserCredential>():
  //       emit(const LoginState(loginStatus: Status.success));
  //     case Error<UserCredential>():
  //       emit(LoginState(loginStatus: Status.error, error: googleLogin.error));
  //   }
  // }

  Future<void> _storeData(LoginEntity userData) async {
    await _loginLocalUseCase.call(userData);
    getIt.get<UserProvider>().changeUserLoginInfo(userData);
  }

  Future<void> _getData() async {
    emit(const LoginState(loginStatus: Status.loading));

    final loginEntity = await _loginLocalUseCase.getLocalData();
    if (loginEntity != null) {
      emit(LoginState(loginStatus: Status.success, userData: loginEntity));
    } else {
      emit(
        const LoginState(
          loginStatus: Status.error,
          error: 'No local login data found.',
        ),
      );
    }
  }

  Future<void> _clearData() async {
    await _loginLocalUseCase.clear();
  }
}

sealed class LoginIntent {}

class Login extends LoginIntent {
  final String email;
  final String password;

  Login(this.email, this.password);
}

class GoogleLogin extends LoginIntent {}

class GetData extends LoginIntent {}

class ClearData extends LoginIntent {}
