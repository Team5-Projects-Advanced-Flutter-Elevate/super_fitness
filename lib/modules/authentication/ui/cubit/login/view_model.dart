import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/apis/api_result/api_result.dart';
import '../../../domain/entities/login/login_data_response_entity.dart';
import '../../../domain/usecase/login/login.dart';
import '../../login/state.dart';

@injectable
class LoginViewModel extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase) : super(const LoginState());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void doIntent(LoginIntent intent) {
    switch (intent) {
      case Login():
        _login(intent.email, intent.password);
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
}

sealed class LoginIntent {}

class Login extends LoginIntent {
  final String email;
  final String password;

  Login(this.email, this.password);
}
