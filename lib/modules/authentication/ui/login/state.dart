import 'package:equatable/equatable.dart';

enum Status { idle, loading, success, error }

class LoginState extends Equatable {
  final Status loginStatus;
  final Object? error;
  const LoginState({this.loginStatus = Status.idle, this.error});

  @override
  List<Object?> get props => [loginStatus, error];
}
