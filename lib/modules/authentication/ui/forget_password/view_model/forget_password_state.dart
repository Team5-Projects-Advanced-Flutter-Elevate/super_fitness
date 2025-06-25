import 'package:equatable/equatable.dart';

enum SendEmailStatus { initial, loading, success, error }

enum SendOtpStatus { initial, loading, success, error }

enum ResetPasswordStatus { initial, loading, success, error }

enum ConfirmButtonStatus { enabled, disabled }

class ForgetPasswordState extends Equatable {
  final SendEmailStatus sendEmailStatus;
  final SendOtpStatus sendOtpStatus;
  final ResetPasswordStatus resetPasswordStatus;
  final ConfirmButtonStatus confirmButtonStatus;
  final String? otp;
  //bool resendCode;
  final String? password;
  final String? error;

  const ForgetPasswordState({
    this.sendEmailStatus = SendEmailStatus.initial,
    this.sendOtpStatus = SendOtpStatus.initial,
    this.resetPasswordStatus = ResetPasswordStatus.initial,
    this.otp,
    this.password,
    this.error,
    this.confirmButtonStatus = ConfirmButtonStatus.disabled,
  });

  ForgetPasswordState copyWith({
    SendEmailStatus? sendEmailStatus,
    SendOtpStatus? sendOtpStatus,
    ResetPasswordStatus? resetPasswordStatus,
    ConfirmButtonStatus? confirmButtonStatus,
    String? email,
    String? otp,
    String? password,
    String? error,
  }) {
    return ForgetPasswordState(
      sendEmailStatus: sendEmailStatus ?? this.sendEmailStatus,
      sendOtpStatus: sendOtpStatus ?? this.sendOtpStatus,
      confirmButtonStatus: confirmButtonStatus ?? this.confirmButtonStatus,
      resetPasswordStatus: resetPasswordStatus ?? this.resetPasswordStatus,
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
    otp,
    password,
    error,
    confirmButtonStatus,
  ];
}
