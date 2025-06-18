// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../modules/authentication/data/api/api_client/auth_api_client.dart'
    as _i343;
import '../../modules/authentication/data/api/api_client_provider/auth_api_client_provider.dart'
    as _i1019;
import '../../modules/authentication/ui/register/view_model/register_view_model.dart'
    as _i610;
import '../../shared_layers/localization/generated/app_localizations.dart'
    as _i543;
import '../../shared_layers/localization/initializer/locale_initializer.dart'
    as _i631;
import '../../shared_layers/localization/l10n_manager/localization_manager.dart'
    as _i273;
import '../../shared_layers/storage/contracts/flutter_secure_storage_service_contract.dart'
    as _i629;
import '../../shared_layers/storage/implementation/flutter_secure_storage_service_imp.dart'
    as _i701;
import '../../shared_layers/storage/initializer/storage_initializer.dart'
    as _i241;
import '../apis/api_error/api_error_handler.dart' as _i439;
import '../utilities/app_localizations/app_localizations_provider.dart'
    as _i363;
import '../utilities/dio/dio_service/dio_service.dart' as _i738;
import '../validation/validation_functions.dart' as _i166;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioService = _$DioService();
    final storagesInitializer = _$StoragesInitializer();
    final authApiClientProvider = _$AuthApiClientProvider();
    final localeInitializer = _$LocaleInitializer();
    final appLocalizationsProvider = _$AppLocalizationsProvider();
    await gh.factoryAsync<_i361.Dio>(
      () => dioService.provideDio(),
      preResolve: true,
    );
    gh.factory<_i610.RegisterViewModel>(() => _i610.RegisterViewModel());
    await gh.factoryAsync<_i558.FlutterSecureStorage>(
      () => storagesInitializer.initFlutterSecureStorage(),
      preResolve: true,
    );
    gh.lazySingleton<_i343.AuthApiClient>(
      () => authApiClientProvider.provide(gh<_i361.Dio>()),
    );
    gh.singleton<_i629.SecureStorageService<dynamic>>(
      () => _i701.SecureStorageServiceImp(gh<_i558.FlutterSecureStorage>()),
    );
    await gh.factoryAsync<String>(
      () => localeInitializer.initCurrentLocal(
        gh<_i629.SecureStorageService<dynamic>>(),
      ),
      instanceName: 'initCurrentLocal',
      preResolve: true,
    );
    gh.singleton<_i273.LocalizationManager>(
      () => _i273.LocalizationManager(
        gh<_i629.SecureStorageService<dynamic>>(),
        gh<String>(instanceName: 'initCurrentLocal'),
      ),
    );
    await gh.factoryAsync<_i543.AppLocalizations>(
      () => appLocalizationsProvider.provideAppLocalizations(
        gh<String>(instanceName: 'initCurrentLocal'),
      ),
      preResolve: true,
    );
    gh.lazySingleton<_i439.ApiErrorHandler>(
      () => _i439.ApiErrorHandler(gh<_i543.AppLocalizations>()),
    );
    gh.lazySingleton<_i166.ValidateFunctions>(
      () => _i166.ValidateFunctions(gh<_i543.AppLocalizations>()),
    );
    return this;
  }
}

class _$DioService extends _i738.DioService {}

class _$StoragesInitializer extends _i241.StoragesInitializer {}

class _$AuthApiClientProvider extends _i1019.AuthApiClientProvider {}

class _$LocaleInitializer extends _i631.LocaleInitializer {}

class _$AppLocalizationsProvider extends _i363.AppLocalizationsProvider {}
