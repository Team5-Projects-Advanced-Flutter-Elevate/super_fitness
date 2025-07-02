import 'package:injectable/injectable.dart';
import 'package:super_fitness/modules/home/ui/pages/profile_page/domain/repo_contract/profile_repo.dart';
import '../../../../../../../core/apis/api_result/api_result.dart';
import '../../../../../../authentication/domain/entities/login/login_data_response_entity.dart';

@injectable
class GetProfileDataUseCase {
  final ProfileRepo _repo;

  GetProfileDataUseCase(this._repo);

  Future<ApiResult<UserEntity?>> execute() => _repo.getProfile();
}
