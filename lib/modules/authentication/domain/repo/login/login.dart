import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/authentication/domain/entities/login/login_data_response_entity.dart';

abstract class LoginRepo {
  Future<ApiResult<LoginEntity>> login(String email, String password);
}
