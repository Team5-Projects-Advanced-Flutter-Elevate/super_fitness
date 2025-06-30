import 'package:injectable/injectable.dart';

import '../../../../core/apis/api_result/api_result.dart';
import '../../domain/entity/edit_info.dart';
import '../../domain/repo/edit_data.dart';
import '../datasource/edit_info.dart';

@Injectable(as: EditInfoRepo)
class EditInfoRepoImpl implements EditInfoRepo {
  final EditInfoOnlineDataSource _editInfoOnlineDataSource;
  EditInfoRepoImpl(this._editInfoOnlineDataSource);
  @override
  Future<ApiResult<EditMyInfoEntity>> editInfo(
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
  ) {
    return _editInfoOnlineDataSource.editInfo(
      firstName,
      lastName,
      email,
      phone,
    );
  }
}
