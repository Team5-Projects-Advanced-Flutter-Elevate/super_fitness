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
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;

import '../../modules/authentication/data/api/api_client/auth_api_client.dart'
    as _i343;
import '../../modules/authentication/data/api/api_client_provider/auth_api_client_provider.dart'
    as _i1019;
import '../../modules/authentication/data/collections/users/user_collection.dart'
    as _i550;
import '../../modules/authentication/data/collections/users/users_collection_imp.dart'
    as _i431;
import '../../modules/authentication/data/data_sources_contracts/firebase_auth/firebase_auth_data_source.dart'
    as _i449;
import '../../modules/authentication/data/data_sources_contracts/login/login.dart'
    as _i969;
import '../../modules/authentication/data/data_sources_contracts/register/register_remote_data_source.dart'
    as _i735;
import '../../modules/authentication/data/data_sources_imp/firebase_auth/firebase_auth_data_source_imp.dart'
    as _i1026;
import '../../modules/authentication/data/data_sources_imp/login/login.dart'
    as _i79;
import '../../modules/authentication/data/data_sources_imp/register/register_remote_data_source_imp.dart'
    as _i132;
import '../../modules/authentication/data/firebase_auth_api/google_auth_api.dart'
    as _i525;
import '../../modules/authentication/data/repositories_imp/firebase_auth/firebase_auth_repo_imp.dart'
    as _i121;
import '../../modules/authentication/data/repositories_imp/login/login_repo_imp.dart'
    as _i641;
import '../../modules/authentication/data/repositories_imp/register/register_repo_imp.dart'
    as _i193;
import '../../modules/authentication/domain/repo/login/login.dart' as _i239;
import '../../modules/authentication/domain/repositories_contracts/firebase_auth/firebase_auth_repo.dart'
    as _i396;
import '../../modules/authentication/domain/repositories_contracts/register/register_repo.dart'
    as _i496;
import '../../modules/authentication/domain/use_cases/firebase_auth/google/sign_in/sign_in_with_google_account.dart'
    as _i851;
import '../../modules/authentication/domain/use_cases/firebase_auth/google/sign_up/sign_up_with_google_account.dart'
    as _i210;
import '../../modules/authentication/domain/use_cases/register/register_use_case.dart'
    as _i782;
import '../../modules/authentication/domain/usecase/login/login.dart' as _i192;
import '../../modules/authentication/ui/complete_register/view_model/complete_register_cubit.dart'
    as _i778;
import '../../modules/authentication/ui/login/cubit/login/view_model.dart'
    as _i396;
import '../../modules/authentication/ui/register/view_model/register_view_model.dart'
    as _i610;
import '../../modules/exercise/data/api/api_client/exercise_api_client.dart'
    as _i14;
import '../../modules/exercise/data/api/api_client_provider/auth_api_client_provider.dart'
    as _i356;
import '../../modules/exercise/data/datasource/exercise_datasource.dart'
    as _i442;
import '../../modules/exercise/data/datasource_impl/exercise_datasource_impl.dart'
    as _i146;
import '../../modules/exercise/data/repo_impl/exercise_repo_impl.dart' as _i830;
import '../../modules/exercise/domain/repo/exercise_repo.dart' as _i960;
import '../../modules/exercise/domain/usecase/exercise_usecase.dart' as _i111;
import '../../modules/exercise/ui/cubit/view_model.dart' as _i370;
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
import '../utilities/google_sign_in/google_sign_in_handler.dart' as _i138;
import '../utilities/google_sign_in/google_sign_in_object.dart' as _i780;
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
    final googleSignInObject = _$GoogleSignInObject();
    final authApiClientProvider = _$AuthApiClientProvider();
    final exerciseApiClientProvider = _$ExerciseApiClientProvider();
    final localeInitializer = _$LocaleInitializer();
    final appLocalizationsProvider = _$AppLocalizationsProvider();
    await gh.factoryAsync<_i361.Dio>(
      () => dioService.provideDio(),
      preResolve: true,
    );
    gh.factory<_i778.CompleteRegisterCubit>(
      () => _i778.CompleteRegisterCubit(),
    );
    await gh.factoryAsync<_i558.FlutterSecureStorage>(
      () => storagesInitializer.initFlutterSecureStorage(),
      preResolve: true,
    );
    gh.lazySingleton<_i116.GoogleSignIn>(
      () => googleSignInObject.providerObject(),
    );
    gh.lazySingleton<_i525.GoogleAuthApi>(() => _i525.GoogleAuthApi());
    gh.factory<_i550.UsersCollection>(() => _i431.UsersCollectionImp());
    gh.lazySingleton<_i343.AuthApiClient>(
      () => authApiClientProvider.provideApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i14.ExerciseApiClient>(
      () => exerciseApiClientProvider.provideApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i442.ExerciseOnlineDataSource>(
      () => _i146.ExerciseOnlineDataSourceImpl(gh<_i14.ExerciseApiClient>()),
    );
    gh.factory<_i138.GoogleSignInHandler>(
      () => _i138.GoogleSignInHandler(gh<_i116.GoogleSignIn>()),
    );
    gh.singleton<_i629.SecureStorageService<dynamic>>(
      () => _i701.SecureStorageServiceImp(gh<_i558.FlutterSecureStorage>()),
    );
    gh.factory<_i449.FirebaseAuthDataSource>(
      () => _i1026.FirebaseAuthDataSourceImp(
        gh<_i525.GoogleAuthApi>(),
        gh<_i550.UsersCollection>(),
      ),
    );
    gh.factory<_i960.ExerciseRepo>(
      () => _i830.ExerciseRepoImpl(gh<_i442.ExerciseOnlineDataSource>()),
    );
    gh.factory<_i969.LoginOnlineDataSource>(
      () => _i79.LoginOnlineDataSourceImpl(gh<_i343.AuthApiClient>()),
    );
    await gh.factoryAsync<String>(
      () => localeInitializer.initCurrentLocal(
        gh<_i629.SecureStorageService<dynamic>>(),
      ),
      instanceName: 'initCurrentLocal',
      preResolve: true,
    );
    gh.factory<_i735.RegisterRemoteDataSource>(
      () => _i132.RegisterRemoteDataSourceImp(gh<_i343.AuthApiClient>()),
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
    gh.factory<_i111.ExerciseUseCase>(
      () => _i111.ExerciseUseCase(gh<_i960.ExerciseRepo>()),
    );
    gh.factory<_i496.RegisterRepo>(
      () => _i193.RegisterRepoImp(gh<_i735.RegisterRemoteDataSource>()),
    );
    gh.factory<_i396.FirebaseAuthRepo>(
      () => _i121.FirebaseAuthRepoImp(gh<_i449.FirebaseAuthDataSource>()),
    );
    gh.factory<_i239.LoginRepo>(
      () => _i641.LoginRepoImpl(gh<_i969.LoginOnlineDataSource>()),
    );
    gh.factory<_i370.ExerciseViewModel>(
      () => _i370.ExerciseViewModel(gh<_i111.ExerciseUseCase>()),
    );
    gh.factory<_i851.SignInWithGoogleAccountUseCase>(
      () => _i851.SignInWithGoogleAccountUseCase(gh<_i396.FirebaseAuthRepo>()),
    );
    gh.factory<_i210.SignUpWithGoogleAccountUseCase>(
      () => _i210.SignUpWithGoogleAccountUseCase(gh<_i396.FirebaseAuthRepo>()),
    );
    gh.lazySingleton<_i439.ApiErrorHandler>(
      () => _i439.ApiErrorHandler(gh<_i543.AppLocalizations>()),
    );
    gh.lazySingleton<_i166.ValidateFunctions>(
      () => _i166.ValidateFunctions(gh<_i543.AppLocalizations>()),
    );
    gh.factory<_i782.RegisterUserCase>(
      () => _i782.RegisterUserCase(gh<_i496.RegisterRepo>()),
    );
    gh.factory<_i192.LoginUseCase>(
      () => _i192.LoginUseCase(gh<_i239.LoginRepo>()),
    );
    gh.factory<_i610.RegisterViewModel>(
      () => _i610.RegisterViewModel(
        gh<_i782.RegisterUserCase>(),
        gh<_i210.SignUpWithGoogleAccountUseCase>(),
        gh<_i138.GoogleSignInHandler>(),
      ),
    );
    gh.factory<_i396.LoginViewModel>(
      () => _i396.LoginViewModel(
        gh<_i192.LoginUseCase>(),
        gh<_i851.SignInWithGoogleAccountUseCase>(),
        gh<_i138.GoogleSignInHandler>(),
      ),
    );
    return this;
  }
}

class _$DioService extends _i738.DioService {}

class _$StoragesInitializer extends _i241.StoragesInitializer {}

class _$GoogleSignInObject extends _i780.GoogleSignInObject {}

class _$AuthApiClientProvider extends _i1019.AuthApiClientProvider {}

class _$ExerciseApiClientProvider extends _i356.ExerciseApiClientProvider {}

class _$LocaleInitializer extends _i631.LocaleInitializer {}

class _$AppLocalizationsProvider extends _i363.AppLocalizationsProvider {}
