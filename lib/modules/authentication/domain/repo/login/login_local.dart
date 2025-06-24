
import '../../entities/login/login_data_response_entity.dart';

abstract class StoreLoginLocalRepo {
  Future<void> saveLoginData(LoginEntity loginEntity);
  Future<LoginEntity?> getLoginData();
  Future<void> clearLoginData();
}
