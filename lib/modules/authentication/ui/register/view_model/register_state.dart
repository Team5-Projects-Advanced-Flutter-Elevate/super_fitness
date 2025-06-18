import 'package:equatable/equatable.dart';

enum Status { idle, loading, success, error }

class RegisterState extends Equatable {
  final Status registerStatus;
  final Object? error;

  const RegisterState({this.registerStatus = Status.idle, this.error});
  @override
  List<Object?> get props => [registerStatus, error];

  RegisterState copyWith({Status? registerStatus, Object? error}) {
    return RegisterState(
      registerStatus: registerStatus ?? this.registerStatus,
      error: error ?? this.error,
    );
  }
}
