import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_executor/api_executor.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/core/di/injectable_initializer.dart';
import 'package:super_fitness/modules/home/data/data_sources_contracts/change_password/change_password_remote_data_source_contract.dart';
import 'package:super_fitness/modules/home/data/models/change_password/change_password_request_dto.dart';
import 'package:super_fitness/modules/home/data/models/change_password/change_password_response_dto.dart';
import 'package:super_fitness/modules/home/domain/entities/change_password/change_password_response_entity.dart';
import 'package:super_fitness/modules/home/ui/pages/profile_page/data/api/api_client/profile_api_client.dart';
import 'package:super_fitness/shared_layers/localization/l10n_manager/localization_manager.dart';

@Injectable(as: ChangePasswordRemoteDataSourceContract)
class ChangePasswordRemoteDataSourceImpl
    implements ChangePasswordRemoteDataSourceContract {
  final ProfileApiClient _profileApiClient;

  ChangePasswordRemoteDataSourceImpl(this._profileApiClient);

  @override
  Future<ApiResult<ChangePasswordResponseEntity>> changePassword(
    String password,
    String newPassword,
  ) async {
    var result = await ApiExecutor.executeApi(() async {
      var response = await _profileApiClient.changePassword(
        ChangePasswordRequestDto(
          password: password,
          newPassword: newPassword,
        ).toJson(),
        getIt.get<LocalizationManager>().currentLocale,
      );
      return response;
    });
    switch (result) {
      case Success<ChangePasswordResponseDto>():
        return Success(data: result.data.toEntity());
      case Error<ChangePasswordResponseDto>():
        return Error(error: result.error);
    }
  }
}
