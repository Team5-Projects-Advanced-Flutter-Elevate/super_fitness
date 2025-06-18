import 'package:equatable/equatable.dart';

sealed class PasswordState {}

class PasswordInitialState extends PasswordState {}

class PasswordLoadingState extends PasswordState {}

class PasswordErrorState extends PasswordState {
  final Object error;
  PasswordErrorState(this.error);
}

class PasswordSuccessState extends PasswordState {}

///////////////////////////////////Email-State/////////////
sealed class EmailState {}

class EmailInitialState extends EmailState {}

class EmailLoadingState extends EmailState {}

class EmailErrorState extends EmailState {
  final Object error;
  EmailErrorState(this.error);
}

class EmailSuccessState extends EmailState {}

////////////////////////////////////OTP-State/////////////
sealed class OtpState {}

class OtpInitialState extends OtpState {}

class OtpLoadingState extends OtpState {}

class OtpErrorState extends OtpState {
  final Object error;
  OtpErrorState(this.error);
}

class OtpSuccessState extends OtpState {}

enum SendEmailStatus { initial, loading, success, error }

enum SendOtpStatus { initial, loading, success, error }

enum ResetPasswordStatus { initial, loading, success, error }

class ForgetPasswordState extends Equatable {
  final SendEmailStatus sendEmailStatus;
  final SendOtpStatus sendOtpStatus;
  final ResetPasswordStatus resetPasswordStatus;
  final String? email;
  final String? otp;
  final String? password;
  final String? error;

  const ForgetPasswordState({
    this.sendEmailStatus = SendEmailStatus.initial,
    this.sendOtpStatus = SendOtpStatus.initial,
    this.resetPasswordStatus = ResetPasswordStatus.initial,
    this.email,
    this.otp,
    this.password,
    this.error,
  });

  ForgetPasswordState copyWith({
    SendEmailStatus? sendEmailStatus,
    SendOtpStatus? sendOtpStatus,
    ResetPasswordStatus? resetPasswordStatus,
    String? email,
    String? otp,
    String? password,
    String? error,
  }) {
    return ForgetPasswordState(
      sendEmailStatus: sendEmailStatus ?? this.sendEmailStatus,
      sendOtpStatus: sendOtpStatus ?? this.sendOtpStatus,
      resetPasswordStatus: resetPasswordStatus ?? this.resetPasswordStatus,
      email: email ?? this.email,
      otp: otp ?? this.otp,
      password: password ?? this.password,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    sendEmailStatus,
    sendOtpStatus,
    resetPasswordStatus,
    email,
    otp,
    password,
    error,
  ];
}
