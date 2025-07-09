// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_ai/firebase_ai.dart' as _i187;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;

import '../../modules/authentication/data/api/api_client/auth_api_client.dart'
    as _i343;
import '../../modules/authentication/data/api/api_client_provider/auth_api_client_provider.dart'
    as _i1019;
import '../../modules/authentication/data/data_sources_contracts/forget_password/forget_password_remote_data_source.dart'
    as _i150;
import '../../modules/authentication/data/data_sources_contracts/login/login.dart'
    as _i969;
import '../../modules/authentication/data/data_sources_contracts/login/login_local.dart'
    as _i393;
import '../../modules/authentication/data/data_sources_contracts/register/register_remote_data_source.dart'
    as _i735;
import '../../modules/authentication/data/data_sources_imp/forget_password/forget_password_remote_data_source_imp.dart'
    as _i191;
import '../../modules/authentication/data/data_sources_imp/login/login.dart'
    as _i79;
import '../../modules/authentication/data/data_sources_imp/login/login_local.dart'
    as _i537;
import '../../modules/authentication/data/data_sources_imp/register/register_remote_data_source_imp.dart'
    as _i132;
import '../../modules/authentication/data/repositories_imp/forget_password/forget_password_repo_imp.dart'
    as _i956;
import '../../modules/authentication/data/repositories_imp/login/login_local.dart'
    as _i849;
import '../../modules/authentication/data/repositories_imp/login/login_repo_imp.dart'
    as _i641;
import '../../modules/authentication/data/repositories_imp/register/register_repo_imp.dart'
    as _i193;
import '../../modules/authentication/domain/repo/login/login.dart' as _i239;
import '../../modules/authentication/domain/repo/login/login_local.dart'
    as _i630;
import '../../modules/authentication/domain/repositories_contracts/forget_password/forget_password_repo.dart'
    as _i1013;
import '../../modules/authentication/domain/repositories_contracts/register/register_repo.dart'
    as _i496;
import '../../modules/authentication/domain/use_cases/forget_password/forget_password_use_case.dart'
    as _i823;
import '../../modules/authentication/domain/use_cases/forget_password/reset_code_use_case.dart'
    as _i9;
import '../../modules/authentication/domain/use_cases/forget_password/reset_password_use_case.dart'
    as _i110;
import '../../modules/authentication/domain/use_cases/register/register_use_case.dart'
    as _i782;
import '../../modules/authentication/domain/usecase/login/login.dart' as _i192;
import '../../modules/authentication/domain/usecase/login/login_local.dart'
    as _i966;
import '../../modules/authentication/ui/complete_register/view_model/complete_register_cubit.dart'
    as _i778;
import '../../modules/authentication/ui/forget_password/view_model/forget_password_view_model.dart'
    as _i494;
import '../../modules/authentication/ui/login/cubit/login/view_model.dart'
    as _i396;
import '../../modules/authentication/ui/register/view_model/register_view_model.dart'
    as _i610;
import '../../modules/edit_profile/data/api/api_client/get_data_api_client.dart'
    as _i984;
import '../../modules/edit_profile/data/api/api_client/upload_image_api_client.dart'
    as _i737;
import '../../modules/edit_profile/data/api/api_client_provider/get_data_api_client_provider.dart'
    as _i1073;
import '../../modules/edit_profile/data/datasource/edit_info.dart' as _i229;
import '../../modules/edit_profile/data/datasource/get_data.dart' as _i890;
import '../../modules/edit_profile/data/datasource/upload_image.dart' as _i754;
import '../../modules/edit_profile/data/datasource_impl/edit_info.dart' as _i93;
import '../../modules/edit_profile/data/datasource_impl/get_data.dart' as _i458;
import '../../modules/edit_profile/data/datasource_impl/upload_image.dart'
    as _i626;
import '../../modules/edit_profile/data/repo_impl/edit_info.dart' as _i213;
import '../../modules/edit_profile/data/repo_impl/get_data.dart' as _i452;
import '../../modules/edit_profile/data/repo_impl/image_upload.dart' as _i42;
import '../../modules/edit_profile/domain/repo/edit_data.dart' as _i272;
import '../../modules/edit_profile/domain/repo/get_data_repo.dart' as _i382;
import '../../modules/edit_profile/domain/repo/upload_image.dart' as _i51;
import '../../modules/edit_profile/domain/usecase/edit_info_usecase.dart'
    as _i797;
import '../../modules/edit_profile/domain/usecase/get_data_usecase.dart'
    as _i736;
import '../../modules/edit_profile/domain/usecase/upload_image.dart' as _i875;
import '../../modules/edit_profile/ui/cubit/view_model.dart' as _i552;
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
import '../../modules/food_details/data/api/api_client/food_details_api_client.dart'
    as _i847;
import '../../modules/food_details/data/api/api_provider/food_details_api_provider.dart'
    as _i762;
import '../../modules/food_details/data/datasource_contract/food_details_datasource.dart'
    as _i208;
import '../../modules/food_details/data/datasource_impl/food_details_datasource_impl.dart'
    as _i432;
import '../../modules/food_details/data/repo_impl/food_details_repo_impl.dart'
    as _i946;
import '../../modules/food_details/domain/repo_contract/food_details_repo_contract.dart'
    as _i270;
import '../../modules/food_details/domain/usecases/get_food_details_use_case.dart'
    as _i812;
import '../../modules/food_details/ui/view_model/food_details_cubit.dart'
    as _i597;
import '../../modules/home/data/api/api_client/home_api_client.dart' as _i293;
import '../../modules/home/data/api/api_client_provider/home_api_client_provider.dart'
    as _i939;
import '../../modules/home/data/data_sources_contracts/change_password/change_password_remote_data_source_contract.dart'
    as _i544;
import '../../modules/home/data/data_sources_contracts/random_exercises/random_exercises_remote_data_source.dart'
    as _i1066;
import '../../modules/home/data/data_sources_contracts/workout_datasource_contract.dart'
    as _i195;
import '../../modules/home/data/data_sources_imp/change_password/change_password_remote_data_source_impl.dart'
    as _i712;
import '../../modules/home/data/data_sources_imp/random_exercises/random_exercises_remote_data_source_imp.dart'
    as _i705;
import '../../modules/home/data/data_sourcs_imp/workout_datasource_impl.dart'
    as _i369;
import '../../modules/home/data/repositories_imp/change_password/change_password_repo_impl.dart'
    as _i427;
import '../../modules/home/data/repositories_imp/workout_repo_impl.dart'
    as _i371;
import '../../modules/home/data/respositories_imp/random_exercises/random_exercises_repo_imp.dart'
    as _i16;
import '../../modules/home/domain/repositories_contracts/change_password_repo_contract.dart'
    as _i58;
import '../../modules/home/domain/repositories_contracts/random_exercises/random_exercise_repo.dart'
    as _i352;
import '../../modules/home/domain/repositories_contracts/workout_repo_contract.dart'
    as _i464;
import '../../modules/home/domain/use_cases/change_password/change_password_use_case.dart'
    as _i460;
import '../../modules/home/domain/use_cases/random_exercises/get_ten_random_exerciese_use_case.dart'
    as _i784;
import '../../modules/home/domain/use_cases/workouts/get_muscle_group_workout_use_case.dart'
    as _i1011;
import '../../modules/home/domain/use_cases/workouts/get_muscles_group_use_case.dart'
    as _i415;
import '../../modules/home/ui/pages/ai_chat_page/view_model/ai_chat_page_view_model.dart'
    as _i693;
import '../../modules/home/ui/pages/home_page/view_model/home_page_view_model.dart'
    as _i102;
import '../../modules/home/ui/pages/profile_page/data/api/api_client/profile_api_client.dart'
    as _i145;
import '../../modules/home/ui/pages/profile_page/data/api/api_provider/profile_api_provider.dart'
    as _i355;
import '../../modules/home/ui/pages/profile_page/data/datasource_contract/profile_datasource.dart'
    as _i65;
import '../../modules/home/ui/pages/profile_page/data/datasource_impl/profile_datasource_impl.dart'
    as _i510;
import '../../modules/home/ui/pages/profile_page/data/repo_impl/profile_repo_impl.dart'
    as _i253;
import '../../modules/home/ui/pages/profile_page/domain/repo_contract/profile_repo.dart'
    as _i1041;
import '../../modules/home/ui/pages/profile_page/domain/use_cases/get_profile_data.dart'
    as _i521;
import '../../modules/home/ui/pages/profile_page/ui/view_model/profile_cubit.dart'
    as _i936;
import '../../modules/home/ui/pages/workouts_page/view_model/workouts_page_cubit.dart'
    as _i72;
import '../../modules/home/ui/view_model/change_password/change_password_view_model.dart'
    as _i1041;
import '../../modules/home/ui/view_model/home_view_model.dart' as _i540;
import '../../modules/smart_coach/data/ai_model_contracts/ai_model_source.dart'
    as _i684;
import '../../modules/smart_coach/data/ai_model_contracts/chat_fire_store_data_source.dart'
    as _i617;
import '../../modules/smart_coach/data/ai_model_implementations/ai_model_source_imp.dart'
    as _i296;
import '../../modules/smart_coach/data/ai_model_implementations/chat_fire_store_data_source_impl.dart'
    as _i125;
import '../../modules/smart_coach/data/model_provider/model_provider.dart'
    as _i17;
import '../../modules/smart_coach/data/repositories_imp/ai_model_repo_imp.dart'
    as _i742;
import '../../modules/smart_coach/data/repositories_imp/chat_fire_store_repo_imp.dart'
    as _i433;
import '../../modules/smart_coach/domain/repositories_contracts/ai_model_repo.dart'
    as _i384;
import '../../modules/smart_coach/domain/repositories_contracts/chat_fire_store_repo.dart'
    as _i627;
import '../../modules/smart_coach/domain/use_cases/add_list_of_messages_use_case.dart'
    as _i887;
import '../../modules/smart_coach/domain/use_cases/add_message_use_case.dart'
    as _i642;
import '../../modules/smart_coach/domain/use_cases/create_chat_use_case.dart'
    as _i869;
import '../../modules/smart_coach/domain/use_cases/end_chat_use_case.dart'
    as _i624;
import '../../modules/smart_coach/domain/use_cases/get_all_chats_use_case.dart'
    as _i507;
import '../../modules/smart_coach/domain/use_cases/get_chat_use_case.dart'
    as _i607;
import '../../modules/smart_coach/domain/use_cases/prompt_model_use_case.dart'
    as _i831;
import '../../modules/smart_coach/domain/use_cases/update_chat_time_use_case.dart'
    as _i487;
import '../../modules/smart_coach/ui/view_model/smart_coach_screen_view_model.dart'
    as _i533;
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
import '../utilities/single_data_per_application/single_data_per_application_provider.dart'
    as _i459;
import '../utilities/social_accounts_sign_in/facebook_sign_in/facebook_sign_in_handler.dart'
    as _i817;
import '../utilities/social_accounts_sign_in/google_sign_in/google_sign_in_handler.dart'
    as _i560;
import '../utilities/social_accounts_sign_in/google_sign_in/google_sign_in_object.dart'
    as _i646;
import '../utilities/user_provider/user_provider.dart' as _i911;
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
    final geminiModelProvider = _$GeminiModelProvider();
    final authApiClientProvider = _$AuthApiClientProvider();
    final getDataApiClientProvider = _$GetDataApiClientProvider();
    final exerciseApiClientProvider = _$ExerciseApiClientProvider();
    final foodApiClientProvider = _$FoodApiClientProvider();
    final foodDetailsApiClientProvider = _$FoodDetailsApiClientProvider();
    final homeApiClientProvider = _$HomeApiClientProvider();
    final profileApiClientProvider = _$ProfileApiClientProvider();
    final localeInitializer = _$LocaleInitializer();
    final appLocalizationsProvider = _$AppLocalizationsProvider();
    await gh.factoryAsync<_i361.Dio>(
      () => dioService.provideDio(),
      preResolve: true,
    );
    gh.factory<_i817.FacebookSignInHandler>(
      () => _i817.FacebookSignInHandler(),
    );
    gh.factory<_i778.CompleteRegisterCubit>(
      () => _i778.CompleteRegisterCubit(),
    );
    gh.factory<_i540.HomeViewModel>(() => _i540.HomeViewModel());
    await gh.factoryAsync<_i558.FlutterSecureStorage>(
      () => storagesInitializer.initFlutterSecureStorage(),
      preResolve: true,
    );
    gh.singleton<_i911.UserProvider>(() => _i911.UserProvider());
    gh.lazySingleton<_i459.SingleDataPerApplicationProvider>(
      () => _i459.SingleDataPerApplicationProvider(),
    );
    gh.lazySingleton<_i116.GoogleSignIn>(
      () => googleSignInObject.providerObject(),
    );
    gh.lazySingleton<_i187.GenerativeModel>(
      () => geminiModelProvider.provide(),
    );
    gh.lazySingleton<_i343.AuthApiClient>(
      () => authApiClientProvider.provideApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i737.UploadImageApiClient>(
      () => _i737.UploadImageApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i984.GetDataApiClient>(
      () => getDataApiClientProvider.provideApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i14.ExerciseApiClient>(
      () => exerciseApiClientProvider.provideApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i642.FoodApiClient>(
      () => foodApiClientProvider.provideApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i847.FoodDetailsApiClient>(
      () => foodDetailsApiClientProvider.provideApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i293.HomeApiClient>(
      () => homeApiClientProvider.provideApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i145.ProfileApiClient>(
      () => profileApiClientProvider.provideApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i684.AiModelSource>(
      () => _i296.AiModelSourceImp(gh<_i187.GenerativeModel>()),
    );
    gh.factory<_i617.ChatFireStoreDataSource>(
      () => _i125.FirebaseChatDataSource(),
    );
    gh.factory<_i442.ExerciseOnlineDataSource>(
      () => _i146.ExerciseOnlineDataSourceImpl(gh<_i14.ExerciseApiClient>()),
    );
    gh.factory<_i560.GoogleSignInHandler>(
      () => _i560.GoogleSignInHandler(gh<_i116.GoogleSignIn>()),
    );
    gh.factory<_i229.EditInfoOnlineDataSource>(
      () => _i93.EditInfoOnlineDataSourceImpl(gh<_i984.GetDataApiClient>()),
    );
    gh.factory<_i1066.RandomExercisesRemoteDataSource>(
      () => _i705.RandomExercisesRemoteDataSourceImp(gh<_i293.HomeApiClient>()),
    );
    gh.factory<_i754.UploadImageOnlineDataSource>(
      () => _i626.UploadImageOnlineDataSourceImpl(
        gh<_i737.UploadImageApiClient>(),
      ),
    );
    gh.factory<_i150.ForgetPasswordRemoteDataSource>(
      () => _i191.ForgetPasswordRemoteDataSourceImpl(gh<_i343.AuthApiClient>()),
    );
    gh.factory<_i34.FoodDataSourceContract>(
      () => _i47.FoodDataSourceImp(gh<_i642.FoodApiClient>()),
    );
    gh.factory<_i890.GetLoggedDriverDataOnlineDataSource>(
      () => _i458.GetLoggedDriverDataOnlineDataSourceImpl(
        gh<_i984.GetDataApiClient>(),
      ),
    );
    gh.singleton<_i629.SecureStorageService<dynamic>>(
      () => _i701.SecureStorageServiceImp(gh<_i558.FlutterSecureStorage>()),
    );
    gh.factory<_i544.ChangePasswordRemoteDataSourceContract>(
      () => _i712.ChangePasswordRemoteDataSourceImpl(
        gh<_i145.ProfileApiClient>(),
      ),
    );
    gh.factory<_i272.EditInfoRepo>(
      () => _i213.EditInfoRepoImpl(gh<_i229.EditInfoOnlineDataSource>()),
    );
    gh.factory<_i797.EditInfoUseCase>(
      () => _i797.EditInfoUseCase(gh<_i272.EditInfoRepo>()),
    );
    gh.factory<_i208.FoodDetailsDataSource>(
      () => _i432.FoodDetailsDataSourceImpl(gh<_i847.FoodDetailsApiClient>()),
    );
    gh.factory<_i65.ProfileDatasource>(
      () => _i510.ProfileDatasourceImpl(gh<_i145.ProfileApiClient>()),
    );
    gh.factory<_i1041.ProfileRepo>(
      () => _i253.ProfileRepoImpl(gh<_i65.ProfileDatasource>()),
    );
    gh.factory<_i384.AiModelRepo>(
      () => _i742.AiModelRepoImp(gh<_i684.AiModelSource>()),
    );
    gh.factory<_i58.ChangePasswordRepoContract>(
      () => _i427.ChangePasswordRepoImpl(
        gh<_i544.ChangePasswordRemoteDataSourceContract>(),
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
    gh.factory<_i352.RandomExercisesRepo>(
      () => _i16.RandomExercisesRepoImp(
        gh<_i1066.RandomExercisesRemoteDataSource>(),
      ),
    );
    gh.factory<_i627.ChatFireStoreRepo>(
      () => _i433.ChatFireStoreRepoImp(gh<_i617.ChatFireStoreDataSource>()),
    );
    gh.factory<_i382.GetLoggedDriverDataRepo>(
      () => _i452.LoggedDriverDataRepoImp(
        gh<_i890.GetLoggedDriverDataOnlineDataSource>(),
      ),
    );
    gh.singleton<_i273.LocalizationManager>(
      () => _i273.LocalizationManager(
        gh<_i629.SecureStorageService<dynamic>>(),
        gh<String>(instanceName: 'initCurrentLocal'),
      ),
    );
    gh.factory<_i270.FoodDetailsRepo>(
      () => _i946.FoodDetailsRepoImpl(gh<_i208.FoodDetailsDataSource>()),
    );
    gh.factory<_i51.UploadImageRepo>(
      () => _i42.UploadImageRepoImpl(gh<_i754.UploadImageOnlineDataSource>()),
    );
    await gh.factoryAsync<_i543.AppLocalizations>(
      () => appLocalizationsProvider.provideAppLocalizations(
        gh<String>(instanceName: 'initCurrentLocal'),
      ),
      preResolve: true,
    );
    gh.factory<_i393.StoreLoginLocalDataSource>(
      () => _i537.StoreLoginLocalDataSourceImpl(
        gh<_i629.SecureStorageService<dynamic>>(),
      ),
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
    gh.factory<_i831.PromptModelUseCase>(
      () => _i831.PromptModelUseCase(gh<_i384.AiModelRepo>()),
    );
    gh.factory<_i521.GetProfileDataUseCase>(
      () => _i521.GetProfileDataUseCase(gh<_i1041.ProfileRepo>()),
    );
    gh.factory<_i875.UploadImageUseCase>(
      () => _i875.UploadImageUseCase(gh<_i51.UploadImageRepo>()),
    );
    gh.factory<_i496.RegisterRepo>(
      () => _i193.RegisterRepoImp(gh<_i735.RegisterRemoteDataSource>()),
    );
    gh.factory<_i887.AddListOfMessagesUseCase>(
      () => _i887.AddListOfMessagesUseCase(gh<_i627.ChatFireStoreRepo>()),
    );
    gh.factory<_i642.AddMessageUseCase>(
      () => _i642.AddMessageUseCase(gh<_i627.ChatFireStoreRepo>()),
    );
    gh.factory<_i869.CreateChatUseCase>(
      () => _i869.CreateChatUseCase(gh<_i627.ChatFireStoreRepo>()),
    );
    gh.factory<_i624.EndChatUseCase>(
      () => _i624.EndChatUseCase(gh<_i627.ChatFireStoreRepo>()),
    );
    gh.factory<_i507.GetAllChatsUseCase>(
      () => _i507.GetAllChatsUseCase(gh<_i627.ChatFireStoreRepo>()),
    );
    gh.factory<_i607.GetChatUseCase>(
      () => _i607.GetChatUseCase(gh<_i627.ChatFireStoreRepo>()),
    );
    gh.factory<_i487.UpdateChatTimeUseCase>(
      () => _i487.UpdateChatTimeUseCase(gh<_i627.ChatFireStoreRepo>()),
    );
    gh.factory<_i533.SmartCoachScreenViewModel>(
      () => _i533.SmartCoachScreenViewModel(
        gh<_i831.PromptModelUseCase>(),
        gh<_i507.GetAllChatsUseCase>(),
        gh<_i869.CreateChatUseCase>(),
        gh<_i887.AddListOfMessagesUseCase>(),
        gh<_i487.UpdateChatTimeUseCase>(),
        gh<_i624.EndChatUseCase>(),
      ),
    );
    gh.factory<_i812.GetFoodDetailsUseCase>(
      () => _i812.GetFoodDetailsUseCase(gh<_i270.FoodDetailsRepo>()),
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
    gh.factory<_i460.ChangePasswordUseCase>(
      () => _i460.ChangePasswordUseCase(gh<_i58.ChangePasswordRepoContract>()),
    );
    gh.factory<_i736.GetUserDataUseCase>(
      () => _i736.GetUserDataUseCase(gh<_i382.GetLoggedDriverDataRepo>()),
    );
    gh.factory<_i370.ExerciseViewModel>(
      () => _i370.ExerciseViewModel(gh<_i111.ExerciseUseCase>()),
    );
    gh.factory<_i630.StoreLoginLocalRepo>(
      () =>
          _i849.StoreLoginLocalRepoImpl(gh<_i393.StoreLoginLocalDataSource>()),
    );
    gh.factory<_i751.FilterMealsByCategoryNameUseCase>(
      () =>
          _i751.FilterMealsByCategoryNameUseCase(gh<_i442.FoodRepoContract>()),
    );
    gh.factory<_i1035.GetFoodCategoriesUseCase>(
      () => _i1035.GetFoodCategoriesUseCase(gh<_i442.FoodRepoContract>()),
    );
    gh.factory<_i693.AiChatPageViewModel>(
      () => _i693.AiChatPageViewModel(gh<_i507.GetAllChatsUseCase>()),
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
    gh.factory<_i1041.ChangePasswordViewModel>(
      () => _i1041.ChangePasswordViewModel(gh<_i460.ChangePasswordUseCase>()),
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
    gh.factory<_i597.FoodDetailsCubit>(
      () => _i597.FoodDetailsCubit(gh<_i812.GetFoodDetailsUseCase>()),
    );
    gh.factory<_i966.StoreLoginLocalUseCase>(
      () => _i966.StoreLoginLocalUseCase(gh<_i630.StoreLoginLocalRepo>()),
    );
    gh.factory<_i494.ForgetPasswordViewModel>(
      () => _i494.ForgetPasswordViewModel(
        gh<_i110.ResetPasswordUseCase>(),
        gh<_i823.ForgetPasswordUseCase>(),
        gh<_i9.ResetCodeUseCase>(),
      ),
    );
    gh.factory<_i396.LoginViewModel>(
      () => _i396.LoginViewModel(
        gh<_i192.LoginUseCase>(),
        gh<_i560.GoogleSignInHandler>(),
        gh<_i817.FacebookSignInHandler>(),
        gh<_i966.StoreLoginLocalUseCase>(),
      ),
    );
    gh.factory<_i552.EditProfileViewModel>(
      () => _i552.EditProfileViewModel(
        gh<_i736.GetUserDataUseCase>(),
        gh<_i797.EditInfoUseCase>(),
        gh<_i875.UploadImageUseCase>(),
      ),
    );
    gh.factory<_i610.RegisterViewModel>(
      () => _i610.RegisterViewModel(
        gh<_i782.RegisterUserCase>(),
        gh<_i560.GoogleSignInHandler>(),
        gh<_i817.FacebookSignInHandler>(),
      ),
    );
    gh.factory<_i624.FoodViewModel>(
      () => _i624.FoodViewModel(
        gh<_i1035.GetFoodCategoriesUseCase>(),
        gh<_i751.FilterMealsByCategoryNameUseCase>(),
      ),
    );
    gh.factory<_i936.ProfileCubit>(
      () => _i936.ProfileCubit(
        gh<_i521.GetProfileDataUseCase>(),
        gh<_i966.StoreLoginLocalUseCase>(),
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

class _$GoogleSignInObject extends _i646.GoogleSignInObject {}

class _$GeminiModelProvider extends _i17.GeminiModelProvider {}

class _$AuthApiClientProvider extends _i1019.AuthApiClientProvider {}

class _$GetDataApiClientProvider extends _i1073.GetDataApiClientProvider {}

class _$ExerciseApiClientProvider extends _i356.ExerciseApiClientProvider {}

class _$FoodApiClientProvider extends _i561.FoodApiClientProvider {}

class _$FoodDetailsApiClientProvider
    extends _i762.FoodDetailsApiClientProvider {}

class _$HomeApiClientProvider extends _i939.HomeApiClientProvider {}

class _$ProfileApiClientProvider extends _i355.ProfileApiClientProvider {}

class _$LocaleInitializer extends _i631.LocaleInitializer {}

class _$AppLocalizationsProvider extends _i363.AppLocalizationsProvider {}
