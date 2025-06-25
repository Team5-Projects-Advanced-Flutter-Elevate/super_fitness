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
import '../../modules/authentication/data/data_sources_contracts/forget_password/forget_password_remote_data_source.dart'
    as _i150;
import '../../modules/authentication/data/data_sources_contracts/login/login.dart'
    as _i969;
import '../../modules/authentication/data/data_sources_contracts/register/register_remote_data_source.dart'
    as _i735;
import '../../modules/authentication/data/data_sources_imp/firebase_auth/firebase_auth_data_source_imp.dart'
    as _i1026;
import '../../modules/authentication/data/data_sources_imp/forget_password/forget_password_remote_data_source_imp.dart'
    as _i191;
import '../../modules/authentication/data/data_sources_imp/login/login.dart'
    as _i79;
import '../../modules/authentication/data/data_sources_imp/register/register_remote_data_source_imp.dart'
    as _i132;
import '../../modules/authentication/data/firebase_auth_api/google_auth_api.dart'
    as _i525;
import '../../modules/authentication/data/repositories_imp/firebase_auth/firebase_auth_repo_imp.dart'
    as _i121;
import '../../modules/authentication/data/repositories_imp/forget_password/forget_password_repo_imp.dart'
    as _i956;
import '../../modules/authentication/data/repositories_imp/login/login_repo_imp.dart'
    as _i641;
import '../../modules/authentication/data/repositories_imp/register/register_repo_imp.dart'
    as _i193;
import '../../modules/authentication/domain/repo/login/login.dart' as _i239;
import '../../modules/authentication/domain/repositories_contracts/firebase_auth/firebase_auth_repo.dart'
    as _i396;
import '../../modules/authentication/domain/repositories_contracts/forget_password/forget_password_repo.dart'
    as _i1013;
import '../../modules/authentication/domain/repositories_contracts/register/register_repo.dart'
    as _i496;
import '../../modules/authentication/domain/use_cases/firebase_auth/google/sign_in/sign_in_with_google_account.dart'
    as _i851;
import '../../modules/authentication/domain/use_cases/firebase_auth/google/sign_up/sign_up_with_google_account.dart'
    as _i210;
import '../../modules/authentication/domain/use_cases/forget_password/forget_password_use_case.dart'
    as _i823;
import '../../modules/authentication/domain/use_cases/forget_password/reset_code_use_case.dart'
    as _i9;
import '../../modules/authentication/domain/use_cases/forget_password/reset_password_use_case.dart'
    as _i110;
import '../../modules/authentication/domain/use_cases/register/register_use_case.dart'
    as _i782;
import '../../modules/authentication/domain/usecase/login/login.dart' as _i192;
import '../../modules/authentication/ui/complete_register/view_model/complete_register_cubit.dart'
    as _i778;
import '../../modules/authentication/ui/forget_password/view_model/forget_password_view_model.dart'
    as _i494;
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
import '../../modules/food/data/api/api_client/food_api_client.dart' as _i642;
import '../../modules/food/data/api/api_client_provider/food_api_client_provider.dart'
    as _i561;
import '../../modules/food/data/data_sources_contracts/food_data_source_contract.dart'
    as _i34;
import '../../modules/food/data/data_sources_imp/food_data_source_imp.dart'
    as _i47;
import '../../modules/food/data/repositories_imp/food_repo_imp.dart' as _i71;
import '../../modules/food/domain/repositories_contracts/food_repo_contract.dart'
    as _i442;
import '../../modules/food/domain/use_cases/filter_meals_by_category_name_use_case.dart'
    as _i751;
import '../../modules/food/domain/use_cases/get_food_categories_use_case.dart'
    as _i1035;
import '../../modules/food/ui/view_model/food_view_model.dart' as _i624;
import '../../modules/home/data/api/api_client/home_api_client.dart' as _i293;
import '../../modules/home/data/api/api_client_provider/home_api_client_provider.dart'
    as _i939;
import '../../modules/home/data/data_sources_contracts/random_exercises/random_exercises_remote_data_source.dart'
    as _i1066;
import '../../modules/home/data/data_sources_contracts/workout_datasource_contract.dart'
    as _i195;
import '../../modules/home/data/data_sources_imp/random_exercises/random_exercises_remote_data_source_imp.dart'
    as _i705;
import '../../modules/home/data/data_sourcs_imp/workout_datasource_impl.dart'
    as _i369;
import '../../modules/home/data/repositories_imp/workout_repo_impl.dart'
    as _i371;
import '../../modules/home/data/respositories_imp/random_exercises/random_exercises_repo_imp.dart'
    as _i16;
import '../../modules/home/domain/repositories_contracts/random_exercises/random_exercise_repo.dart'
    as _i352;
import '../../modules/home/domain/repositories_contracts/workout_repo_contract.dart'
    as _i464;
import '../../modules/home/domain/use_cases/random_exercises/get_ten_random_exerciese_use_case.dart'
    as _i784;
import '../../modules/home/domain/use_cases/workouts/get_muscle_group_workout_use_case.dart'
    as _i1011;
import '../../modules/home/domain/use_cases/workouts/get_muscles_group_use_case.dart'
    as _i415;
import '../../modules/home/ui/pages/home_page/view_model/home_page_view_model.dart'
    as _i102;
import '../../modules/home/ui/pages/workouts_page/view_model/workouts_page_cubit.dart'
    as _i72;
import '../../modules/home/ui/view_model/home_view_model.dart' as _i540;
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
import '../utilities/single_data_per_application/single_data_per_application_provider.dart'
    as _i459;
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
    final foodApiClientProvider = _$FoodApiClientProvider();
    final homeApiClientProvider = _$HomeApiClientProvider();
    final localeInitializer = _$LocaleInitializer();
    final appLocalizationsProvider = _$AppLocalizationsProvider();
    await gh.factoryAsync<_i361.Dio>(
      () => dioService.provideDio(),
      preResolve: true,
    );
    gh.factory<_i778.CompleteRegisterCubit>(
      () => _i778.CompleteRegisterCubit(),
    );
    gh.factory<_i540.HomeViewModel>(() => _i540.HomeViewModel());
    await gh.factoryAsync<_i558.FlutterSecureStorage>(
      () => storagesInitializer.initFlutterSecureStorage(),
      preResolve: true,
    );
    gh.lazySingleton<_i116.GoogleSignIn>(
      () => googleSignInObject.providerObject(),
    );
    gh.lazySingleton<_i525.GoogleAuthApi>(() => _i525.GoogleAuthApi());
    gh.lazySingleton<_i459.SingleDataPerApplicationProvider>(
      () => _i459.SingleDataPerApplicationProvider(),
    );
    gh.factory<_i550.UsersCollection>(() => _i431.UsersCollectionImp());
    gh.lazySingleton<_i343.AuthApiClient>(
      () => authApiClientProvider.provideApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i14.ExerciseApiClient>(
      () => exerciseApiClientProvider.provideApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i642.FoodApiClient>(
      () => foodApiClientProvider.provideApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i293.HomeApiClient>(
      () => homeApiClientProvider.provideApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i442.ExerciseOnlineDataSource>(
      () => _i146.ExerciseOnlineDataSourceImpl(gh<_i14.ExerciseApiClient>()),
    );
    gh.factory<_i138.GoogleSignInHandler>(
      () => _i138.GoogleSignInHandler(gh<_i116.GoogleSignIn>()),
    );
    gh.factory<_i150.ForgetPasswordRemoteDataSource>(
      () => _i191.ForgetPasswordRemoteDataSourceImpl(gh<_i343.AuthApiClient>()),
    );
    gh.factory<_i1066.RandomExerciseRemoteDataSource>(
      () => _i705.RandomExercisesRemoteDataSourceImp(gh<_i293.HomeApiClient>()),
    );
    gh.factory<_i34.FoodDataSourceContract>(
      () => _i47.FoodDataSourceImp(gh<_i642.FoodApiClient>()),
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
    gh.factory<_i195.WorkoutDatasource>(
      () => _i369.WorkoutDatasourceImpl(gh<_i293.HomeApiClient>()),
    );
    gh.factory<_i969.LoginOnlineDataSource>(
      () => _i79.LoginOnlineDataSourceImpl(gh<_i343.AuthApiClient>()),
    );
    gh.factory<_i1013.ForgetPasswordRepo>(
      () => _i956.ForgetPasswordRepoImpl(
        gh<_i150.ForgetPasswordRemoteDataSource>(),
      ),
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
    gh.factory<_i352.RandomExercisesRepo>(
      () => _i16.RandomExercisesRepoImp(
        gh<_i1066.RandomExerciseRemoteDataSource>(),
      ),
    );
    await gh.factoryAsync<_i543.AppLocalizations>(
      () => appLocalizationsProvider.provideAppLocalizations(
        gh<String>(instanceName: 'initCurrentLocal'),
      ),
      preResolve: true,
    );
    gh.factory<_i9.ResetCodeUseCase>(
      () => _i9.ResetCodeUseCase(gh<_i1013.ForgetPasswordRepo>()),
    );
    gh.factory<_i111.ExerciseUseCase>(
      () => _i111.ExerciseUseCase(gh<_i960.ExerciseRepo>()),
    );
    gh.factory<_i442.FoodRepoContract>(
      () => _i71.FoodRepoImp(gh<_i34.FoodDataSourceContract>()),
    );
    gh.factory<_i496.RegisterRepo>(
      () => _i193.RegisterRepoImp(gh<_i735.RegisterRemoteDataSource>()),
    );
    gh.factory<_i396.FirebaseAuthRepo>(
      () => _i121.FirebaseAuthRepoImp(gh<_i449.FirebaseAuthDataSource>()),
    );
    gh.factory<_i784.GetTenRandomExerciseUseCase>(
      () => _i784.GetTenRandomExerciseUseCase(gh<_i352.RandomExercisesRepo>()),
    );
    gh.factory<_i110.ResetPasswordUseCase>(
      () => _i110.ResetPasswordUseCase(gh<_i1013.ForgetPasswordRepo>()),
    );
    gh.factory<_i823.ForgetPasswordUseCase>(
      () => _i823.ForgetPasswordUseCase(gh<_i1013.ForgetPasswordRepo>()),
    );
    gh.factory<_i464.WorkoutRepo>(
      () => _i371.WorkoutRepoImpl(
        workoutDatasource: gh<_i195.WorkoutDatasource>(),
      ),
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
    gh.factory<_i751.FilterMealsByCategoryNameUseCase>(
      () =>
          _i751.FilterMealsByCategoryNameUseCase(gh<_i442.FoodRepoContract>()),
    );
    gh.factory<_i1035.GetFoodCategoriesUseCase>(
      () => _i1035.GetFoodCategoriesUseCase(gh<_i442.FoodRepoContract>()),
    );
    gh.factory<_i415.GetMusclesGroupUseCase>(
      () => _i415.GetMusclesGroupUseCase(gh<_i464.WorkoutRepo>()),
    );
    gh.factory<_i1011.GetMuscleGroupWorkoutUseCase>(
      () => _i1011.GetMuscleGroupWorkoutUseCase(gh<_i464.WorkoutRepo>()),
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
    gh.factory<_i102.HomePageViewModel>(
      () => _i102.HomePageViewModel(
        gh<_i784.GetTenRandomExerciseUseCase>(),
        gh<_i1035.GetFoodCategoriesUseCase>(),
        gh<_i415.GetMusclesGroupUseCase>(),
        gh<_i1011.GetMuscleGroupWorkoutUseCase>(),
      ),
    );
    gh.factory<_i610.RegisterViewModel>(
      () => _i610.RegisterViewModel(
        gh<_i782.RegisterUserCase>(),
        gh<_i210.SignUpWithGoogleAccountUseCase>(),
        gh<_i138.GoogleSignInHandler>(),
      ),
    );
    gh.factory<_i494.ForgetPasswordViewModel>(
      () => _i494.ForgetPasswordViewModel(
        gh<_i110.ResetPasswordUseCase>(),
        gh<_i823.ForgetPasswordUseCase>(),
        gh<_i9.ResetCodeUseCase>(),
      ),
    );
    gh.factory<_i624.FoodViewModel>(
      () => _i624.FoodViewModel(
        gh<_i1035.GetFoodCategoriesUseCase>(),
        gh<_i751.FilterMealsByCategoryNameUseCase>(),
      ),
    );
    gh.factory<_i396.LoginViewModel>(
      () => _i396.LoginViewModel(
        gh<_i192.LoginUseCase>(),
        gh<_i851.SignInWithGoogleAccountUseCase>(),
        gh<_i138.GoogleSignInHandler>(),
      ),
    );
    gh.factory<_i72.WorkoutsPageCubit>(
      () => _i72.WorkoutsPageCubit(
        gh<_i415.GetMusclesGroupUseCase>(),
        gh<_i1011.GetMuscleGroupWorkoutUseCase>(),
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

class _$FoodApiClientProvider extends _i561.FoodApiClientProvider {}

class _$HomeApiClientProvider extends _i939.HomeApiClientProvider {}

class _$LocaleInitializer extends _i631.LocaleInitializer {}

class _$AppLocalizationsProvider extends _i363.AppLocalizationsProvider {}
