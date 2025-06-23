import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/modules/authentication/data/api/api_client/auth_api_client.dart';

@module
abstract class AuthApiClientProvider {
  @lazySingleton
  AuthApiClient provideApiClient(Dio dio) {
    return AuthApiClient(dio);
  }
}
