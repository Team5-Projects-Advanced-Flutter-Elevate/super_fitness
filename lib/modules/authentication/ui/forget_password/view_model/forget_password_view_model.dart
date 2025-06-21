import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:otp_text_field/otp_text_field.dart';

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
  String? otpCode;
  String? email;
  OtpFieldController otpFieldController = OtpFieldController();
  final ValueNotifier<int> timeRemaining = ValueNotifier(1);
  Timer? _timer;

  @factoryMethod
  ForgetPasswordViewModel(
    this.resetPasswordUseCase,
    this.forgetPasswordUseCase,
    this.resetCodeUseCase,
  ) : super(const ForgetPasswordState());

  void onIntent(ForgetPasswordIntent intent) {
    switch (intent) {
      case ForgotPasswordIntent():
        _forgetPasswordHandling();
        break;
      case ResetCodeIntent():
        _resetCodeHandling();
        break;
      case ResetPasswordIntent():
        _resetPasswordHandling(intent.newPassword);
        break;
      case StartTimerIntent():
        _startTimer(numberOfSeconds: 30);
        break;
      case DisposeTimerAndValueNotifierIntent():
        _disposeTimerAndValueNotifier();
        break;
    }
  }

  _resetPasswordHandling(String newPassword) async {
    emit(
      state.copyWith(
        sendEmailStatus: SendEmailStatus.initial,
        sendOtpStatus: SendOtpStatus.initial,
        resetPasswordStatus: ResetPasswordStatus.loading,
      ),
    );
    var result = await resetPasswordUseCase.call(email!, newPassword);
    switch (result) {
      case Success<ForgetPasswordResponse?>():
        emit(
          state.copyWith(
            resetPasswordStatus: ResetPasswordStatus.success,
            password: newPassword,
          ),
        );
        break;
      case Error<ForgetPasswordResponse?>():
        emit(
          state.copyWith(
            resetPasswordStatus: ResetPasswordStatus.error,
            error: getIt.get<ApiErrorHandler>().handle(result.error),
          ),
        );
    }
  }

  _resetCodeHandling() async {
    emit(
      state.copyWith(
        sendOtpStatus: SendOtpStatus.loading,
        sendEmailStatus: SendEmailStatus.initial,
      ),
    );
    var result = await resetCodeUseCase.call(otpCode!);
    switch (result) {
      case Success<ForgetPasswordResponse?>():
        emit(
          state.copyWith(sendOtpStatus: SendOtpStatus.success, otp: otpCode),
        );
      case Error<ForgetPasswordResponse?>():
        otpCode = null;
        otpFieldController.clear();
        emit(
          state.copyWith(
            sendOtpStatus: SendOtpStatus.error,
            error: getIt.get<ApiErrorHandler>().handle(result.error),
          ),
        );
        emit(state.copyWith(sendOtpStatus: SendOtpStatus.initial));
    }
  }

  _forgetPasswordHandling() async {
    FocusManager.instance.primaryFocus?.unfocus();
    emit(state.copyWith(sendEmailStatus: SendEmailStatus.loading));
    var result = await forgetPasswordUseCase.call(email!);
    switch (result) {
      case Success<ForgetPasswordResponse?>():
        emit(state.copyWith(sendEmailStatus: SendEmailStatus.success));

      case Error<ForgetPasswordResponse?>():
        emit(
          state.copyWith(
            sendEmailStatus: SendEmailStatus.error,
            error: getIt.get<ApiErrorHandler>().handle(result.error),
          ),
        );
    }
  }

  void _startTimer({required int numberOfSeconds}) {
    if (_timer?.isActive == true) {
      return;
    }
    timeRemaining.value = numberOfSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeRemaining.value > 0) {
        timeRemaining.value -= 1;
      } else {
        _timer?.cancel();
      }
    });
  }

  void _disposeTimerAndValueNotifier() {
    _timer?.cancel();
    timeRemaining.dispose();
  }
}

sealed class ForgetPasswordIntent {}

class ForgotPasswordIntent extends ForgetPasswordIntent {
  ForgotPasswordIntent();
}

class DisposeTimerAndValueNotifierIntent extends ForgetPasswordIntent {}

class ResetCodeIntent extends ForgetPasswordIntent {
  ResetCodeIntent();
}

class ResetPasswordIntent extends ForgetPasswordIntent {
  final String newPassword;

  ResetPasswordIntent(this.newPassword);
}

class StartTimerIntent extends ForgetPasswordIntent {}
