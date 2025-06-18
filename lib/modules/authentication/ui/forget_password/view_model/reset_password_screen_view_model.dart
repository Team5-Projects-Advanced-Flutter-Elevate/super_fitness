import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/apis/api_result/api_result.dart';
import '../../../data/models/forget_password/forget_password_response.dart';
import '../../../domain/use_cases/forget_password/reset_password_use_case.dart';
import 'forget_password_state.dart';

@injectable
class ResetPasswordViewModel extends Cubit<PasswordState> {
  ResetPasswordUseCase resetPasswordUseCase;

  @factoryMethod
  ResetPasswordViewModel(this.resetPasswordUseCase)
    : super(PasswordInitialState());

  void onIntent(ForgetIntent intent) {
    switch (intent) {
      case ResetPasswordIntent():
        _resetPasswordHandling(intent.email, intent.newPassword);
        break;
    }
  }

  _resetPasswordHandling(String email, String newPassword) async {
    FocusManager.instance.primaryFocus?.unfocus();
    emit(PasswordLoadingState());
    var result = await resetPasswordUseCase.call(email, newPassword);
    switch (result) {
      case Success<ForgetPasswordResponse?>():
        emit(PasswordSuccessState());
      case Error<ForgetPasswordResponse?>():
        emit(PasswordErrorState(result.error));
    }
  }
}

sealed class ForgetIntent {}

class ResetPasswordIntent extends ForgetIntent {
  final String email;
  final String newPassword;

  ResetPasswordIntent(this.email, this.newPassword);
}
