import 'package:injectable/injectable.dart';

import '../../../../core/apis/api_result/api_result.dart';
import '../entity/get_data_entity.dart';
import '../repo/get_data_repo.dart';

@injectable
class GetUserDataUseCase {
  final GetLoggedDriverDataRepo _loggedDriverDataRepo;

  GetUserDataUseCase(this._loggedDriverDataRepo);

  Future<ApiResult<GetDataEntity>> call() {
    return _loggedDriverDataRepo.getLoggedDriverData();
  }
}
