import 'package:injectable/injectable.dart';
import 'package:super_fitness/modules/authentication/data/data_sources_contracts/login/login.dart';
import 'package:super_fitness/modules/authentication/domain/repo/login/login.dart';

import '../../../../../core/apis/api_result/api_result.dart';
import '../../../domain/entities/login/login_data_response_entity.dart';

@Injectable(as: LoginRepo)
class LoginRepoImpl implements LoginRepo {
  final LoginOnlineDataSource _loginOnlineDataSource;

  LoginRepoImpl(this._loginOnlineDataSource);

  @override
  Future<ApiResult<LoginEntity>> login(String email, String password) {
    return _loginOnlineDataSource.login(email, password);
  }
}
