import 'package:equatable/equatable.dart';
import 'package:super_fitness/modules/authentication/domain/entities/login/login_data_response_entity.dart';

enum Status { idle, loading, success, error }

class LoginState extends Equatable {
  final Status loginStatus;
  final LoginEntity? userData;
  final Object? error;
  const LoginState({this.loginStatus = Status.idle, this.error, this.userData});

  @override
  List<Object?> get props => [loginStatus, error,userData];
}
