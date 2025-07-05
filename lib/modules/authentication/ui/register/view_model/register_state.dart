import 'package:equatable/equatable.dart';

enum Status { idle, loading, success, error }

class RegisterState extends Equatable {
  final Status registerStatus;
  final Status socialRegisterStatus;
  final Object? error;
  final Object? socialRegisterError;

  const RegisterState({
    this.registerStatus = Status.idle,
    this.socialRegisterStatus = Status.idle,
    this.error,
    this.socialRegisterError,
  });
  @override
  List<Object?> get props => [
    registerStatus,
    socialRegisterStatus,
    error,
    socialRegisterError,
  ];

  RegisterState copyWith({
    Status? registerStatus,
    Status? socialRegisterStatus,
    Object? error,
    Object? socialRegisterError,
  }) {
    return RegisterState(
      registerStatus: registerStatus ?? this.registerStatus,
      socialRegisterStatus: socialRegisterStatus ?? this.socialRegisterStatus,
      error: error ?? this.error,
      socialRegisterError: socialRegisterError ?? this.socialRegisterError,
    );
  }
}
