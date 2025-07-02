import 'package:injectable/injectable.dart';
import '../../../../core/apis/api_result/api_result.dart';
import '../../domain/entity/get_data_entity.dart';
import '../../domain/repo/get_data_repo.dart';
import '../datasource/get_data.dart';

@Injectable(as: GetLoggedDriverDataRepo)
class LoggedDriverDataRepoImp implements GetLoggedDriverDataRepo {
  final GetLoggedDriverDataOnlineDataSource _loggedDriverDataRemoteDataSource;

  LoggedDriverDataRepoImp(this._loggedDriverDataRemoteDataSource);

  @override
  Future<ApiResult<GetDataEntity>> getLoggedDriverData() {
    return _loggedDriverDataRemoteDataSource.getLoggedDriverData();
  }
}
