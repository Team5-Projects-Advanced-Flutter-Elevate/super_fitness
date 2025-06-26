import 'package:injectable/injectable.dart';
import 'package:super_fitness/modules/authentication/data/data_sources_contracts/login/login_local.dart';
import 'package:super_fitness/modules/authentication/data/models/login/login.dart';
import 'dart:convert';
import '../../../../../core/utilities/dio/dio_service/dio_service.dart';
import '../../../../../shared_layers/storage/constants/storage_constants.dart';
import '../../../../../shared_layers/storage/contracts/flutter_secure_storage_service_contract.dart';
import '../../../domain/entities/login/login_data_response_entity.dart';

@Injectable(as: StoreLoginLocalDataSource)
class StoreLoginLocalDataSourceImpl implements StoreLoginLocalDataSource {
  final SecureStorageService _secureStorageService;

  StoreLoginLocalDataSourceImpl(this._secureStorageService);

  @override
  Future<void> saveLoginData(LoginEntity loginEntity) async {
    final loginModel = LoginModelMapper.fromEntity(loginEntity);
    final jsonString = jsonEncode(loginModel.toJson());
    _secureStorageService.setStringValue(
      StorageConstants.loginModelKey,
      jsonString,
    );
  }

  @override
  Future<LoginEntity?> getLoginData() async {
    final jsonString = await _secureStorageService.getStringValue(
      StorageConstants.loginModelKey,
    );

    if (jsonString != null) {
      final jsonMap = jsonDecode(jsonString);
      final loginModel = LoginModel.fromJson(jsonMap);
      DioServiceExtension.updateDioWithToken(loginModel.token ?? "");
      return loginModel.toEntity();
    }

    return null;
  }

  @override
  Future<void> clearLoginData() async {
    await _secureStorageService.deleteValue(StorageConstants.loginModelKey);
  }
}
