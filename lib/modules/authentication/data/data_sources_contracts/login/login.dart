import '../../../../../core/apis/api_result/api_result.dart';
import '../../../domain/entities/login/login_data_response_entity.dart';

abstract class LoginOnlineDataSource {
  Future<ApiResult<LoginEntity>> login(String email, String password);
}
