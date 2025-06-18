import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/apis/api_error/api_error_handler.dart';
import '../../../../../core/apis/api_result/api_result.dart';
import '../../../../../core/di/injectable_initializer.dart';
import '../../../data/models/forget_password/forget_password_response.dart';
import '../../../domain/use_cases/forget_password/forget_password_use_case.dart';
import '../../../domain/use_cases/forget_password/reset_code_use_case.dart';
import '../../../domain/use_cases/forget_password/reset_password_use_case.dart';
import 'forget_password_state.dart';

@injectable
class ForgetPasswordViewModel extends Cubit<ForgetPasswordState> {
  ForgetPasswordUseCase forgetPasswordUseCase;
  ResetCodeUseCase resetCodeUseCase;
  ResetPasswordUseCase resetPasswordUseCase;

  @factoryMethod
  ForgetPasswordViewModel(
    this.resetPasswordUseCase,
    this.forgetPasswordUseCase,
    this.resetCodeUseCase,
  ) : super(const ForgetPasswordState());

  void onIntent(ForgetPasswordIntent intent) {
    switch (intent) {
      case ForgotPasswordIntent():
        _forgetPasswordHandling(intent.email);
        break;
      case ResetCodeIntent():
        _resetCodeHandling(intent.code);
        break;
      case ResetPasswordIntent():
        _resetPasswordHandling(intent.email, intent.newPassword);
        break;
    }
  }

  _resetPasswordHandling(String email, String newPassword) async {
    FocusManager.instance.primaryFocus?.unfocus();
    emit(state.copyWith(resetPasswordStatus: ResetPasswordStatus.loading));
    var result = await resetPasswordUseCase.call(email, newPassword);
    switch (result) {
      case Success<ForgetPasswordResponse?>():
        emit(
          state.copyWith(
            resetPasswordStatus: ResetPasswordStatus.success,
            password: newPassword,
          ),
        );

      case Error<ForgetPasswordResponse?>():
        emit(state.copyWith(resetPasswordStatus: ResetPasswordStatus.error));
    }
  }

  _resetCodeHandling(String code) async {
    emit(
      state.copyWith(
        sendOtpStatus: SendOtpStatus.loading,
        sendEmailStatus: SendEmailStatus.initial,
      ),
    );
    var result = await resetCodeUseCase.call(code);
    switch (result) {
      case Success<ForgetPasswordResponse?>():
        emit(state.copyWith(sendOtpStatus: SendOtpStatus.success, otp: code));
      case Error<ForgetPasswordResponse?>():
        emit(
          state.copyWith(
            sendOtpStatus: SendOtpStatus.error,
            error: getIt.get<ApiErrorHandler>().handle(result.error),
          ),
        );
    }
  }

  _forgetPasswordHandling(String email) async {
    FocusManager.instance.primaryFocus?.unfocus();
    emit(state.copyWith(sendEmailStatus: SendEmailStatus.loading));
    var result = await forgetPasswordUseCase.call(email);
    switch (result) {
      case Success<ForgetPasswordResponse?>():
        emit(
          state.copyWith(
            sendEmailStatus: SendEmailStatus.success,
            email: email,
          ),
        );

      case Error<ForgetPasswordResponse?>():
        emit(
          state.copyWith(
            sendEmailStatus: SendEmailStatus.error,
            error: getIt.get<ApiErrorHandler>().handle(result.error),
          ),
        );
    }
  }
}

sealed class ForgetPasswordIntent {}

class ForgotPasswordIntent extends ForgetPasswordIntent {
  final String email;

  ForgotPasswordIntent(this.email);
}

class ResetCodeIntent extends ForgetPasswordIntent {
  final String code;

  ResetCodeIntent(this.code);
}

class ResetPasswordIntent extends ForgetPasswordIntent {
  final String email;
  final String newPassword;

  ResetPasswordIntent(this.email, this.newPassword);
}
