
import '../../../domain/entities/login/login_data_response_entity.dart';

abstract class StoreLoginLocalDataSource {
  Future<void> saveLoginData(LoginEntity loginEntity);
  Future<LoginEntity?> getLoginData();
  Future<void> clearLoginData();
}
