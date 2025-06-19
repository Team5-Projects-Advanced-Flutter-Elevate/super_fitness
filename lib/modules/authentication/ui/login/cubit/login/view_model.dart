import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/apis/api_result/api_result.dart';
import '../../../../../../core/utilities/google_sign_in/google_sign_in_handler.dart';
import '../../../../domain/entities/login/login_data_response_entity.dart';
import '../../../../domain/use_cases/firebase_auth/google/sign_in/sign_in_with_google_account.dart';
import '../../../../domain/usecase/login/login.dart';
import '../../state.dart';

@injectable
class LoginViewModel extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  final SignInWithGoogleAccountUseCase _signInWithGoogleAccountUseCase;
  final GoogleSignInHandler _googleSignInHandler;

  LoginViewModel(
    this._loginUseCase,
    this._signInWithGoogleAccountUseCase,
    this._googleSignInHandler,
  ) : super(const LoginState());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void doIntent(LoginIntent intent) {
    switch (intent) {
      case Login():
        _login(intent.email, intent.password);

      case GoogleLogin():
        _googleLogin();
    }
  }

  void _login(String email, String password) async {
    emit(const LoginState(loginStatus: Status.loading));
    var useCaseResult = await _loginUseCase.call(email, password);
    switch (useCaseResult) {
      case Success<LoginEntity>():
        emit(const LoginState(loginStatus: Status.success));
      case Error<LoginEntity>():
        emit(LoginState(loginStatus: Status.error, error: useCaseResult.error));
    }
  }

  void _googleLogin() async {
    emit(const LoginState(loginStatus: Status.loading));
    var googleUserAccount = await _googleSignInHandler.getUserGoogleAccount();

    if (googleUserAccount == null) {
      emit(const LoginState(loginStatus: Status.idle));
      return;
    }
    var googleLogin = await _signInWithGoogleAccountUseCase.call(
      googleUserAccount,
    );
    print("=========== After googleLoging ${googleLogin.toString()}");
    switch (googleLogin) {
      case Success<UserCredential>():
        emit(const LoginState(loginStatus: Status.success));
      case Error<UserCredential>():
        emit(LoginState(loginStatus: Status.error, error: googleLogin.error));
    }
  }
}

sealed class LoginIntent {}

class Login extends LoginIntent {
  final String email;
  final String password;

  Login(this.email, this.password);
}

class GoogleLogin extends LoginIntent {}
