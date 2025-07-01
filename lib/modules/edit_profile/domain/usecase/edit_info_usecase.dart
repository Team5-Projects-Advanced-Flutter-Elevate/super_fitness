import 'package:injectable/injectable.dart';

import '../../../../core/apis/api_result/api_result.dart';
import '../entity/edit_info.dart';
import '../repo/edit_data.dart';

@injectable
class EditInfoUseCase {
  final EditInfoRepo _editInfoRepo;
  EditInfoUseCase(this._editInfoRepo);

  Future<ApiResult<EditMyInfoEntity>> call(
    String? firstName,
    String? lastName,
    String? email,
    String? goal,
    String? weight,
    String? level,
  ) {
    return _editInfoRepo.editInfo(
      firstName,
      lastName,
      email,
      goal,
      weight,
      level,
    );
  }
}
