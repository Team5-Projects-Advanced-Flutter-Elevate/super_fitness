import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/core/di/injectable_initializer.dart';
import 'package:super_fitness/core/validation/validation_functions.dart';
import 'package:super_fitness/modules/edit_profile/domain/entity/edit_info.dart';
import 'package:super_fitness/modules/edit_profile/domain/entity/get_data_entity.dart';
import 'package:super_fitness/modules/edit_profile/domain/entity/upload_image_response_entity.dart';
import 'package:super_fitness/modules/edit_profile/domain/entity/user_entity.dart';
import 'package:super_fitness/modules/edit_profile/domain/usecase/edit_info_usecase.dart';
import 'package:super_fitness/modules/edit_profile/domain/usecase/get_data_usecase.dart';
import 'package:super_fitness/modules/edit_profile/domain/usecase/upload_image.dart';
import 'package:super_fitness/modules/edit_profile/ui/cubit/view_model.dart';
import 'package:super_fitness/modules/edit_profile/ui/screens/edit_profile_screen.dart';
import 'package:super_fitness/shared_layers/localization/generated/app_localizations.dart';
import 'package:super_fitness/shared_layers/localization/l10n_manager/localization_manager.dart';

import 'edit_profile_screen_test.mocks.dart';

@GenerateMocks([
  GetUserDataUseCase,
  EditInfoUseCase,
  UploadImageUseCase,
  LocalizationManager,
  AppLocalizations,
  ValidateFunctions,
])
void main() {
  group('test edit profile screen items', () {
    late MockEditInfoUseCase mockEditInfoUseCase;
    late MockGetUserDataUseCase mockGetUserDataUseCase;
    late MockUploadImageUseCase mockUploadImageUseCase;
    late MockAppLocalizations mockAppLocalizations;
    late MockLocalizationManager mockLocalizationManager;
    late MockValidateFunctions mockValidateFunctions;

    late GetDataEntity getDataEntity;
    late EditMyInfoEntity editMyInfoEntity;
    late UploadImageResponseEntity uploadImageResponseEntity;

    setUpAll(() {
      // initialize mocks
      mockEditInfoUseCase = MockEditInfoUseCase();
      mockUploadImageUseCase = MockUploadImageUseCase();
      mockGetUserDataUseCase = MockGetUserDataUseCase();
      mockAppLocalizations = MockAppLocalizations();
      mockLocalizationManager = MockLocalizationManager();
      mockValidateFunctions = MockValidateFunctions();

      // test data
      getDataEntity = GetDataEntity(
        message: 'success',
        user: GetUserEntity(
          id: '1',
          email: 'email',
          gender: 'gender',
          age: 10,
          weight: 100,
          lastName: 'lastName',
          firstName: 'firstName',
          height: 100,
          activityLevel: 'activityLevel',
          goal: 'goal',
          photo: 'photo',
          createdAt: DateTime.now(),
        ),
      );

      editMyInfoEntity = EditMyInfoEntity(
        message: 'success',
        user: getDataEntity.user,
      );

      uploadImageResponseEntity = UploadImageResponseEntity(message: 'success');

      // provide dummy values for all needed types
      provideDummy<ApiResult<GetDataEntity>>(
        Success<GetDataEntity>(data: getDataEntity),
      );
      provideDummy<ApiResult<GetDataEntity?>>(
        Success<GetDataEntity?>(data: getDataEntity),
      );
      provideDummy<ApiResult<EditMyInfoEntity>>(
        Success<EditMyInfoEntity>(data: editMyInfoEntity),
      );
      provideDummy<ApiResult<UploadImageResponseEntity?>>(
        Success<UploadImageResponseEntity?>(data: uploadImageResponseEntity),
      );

      // default mocks
      when(mockGetUserDataUseCase.call())
          .thenAnswer((_) async => Success<GetDataEntity>(data: getDataEntity));

      when(mockEditInfoUseCase.call(any, any, any, any, any, any))
          .thenAnswer((_) async => Success<EditMyInfoEntity>(data: editMyInfoEntity));

      File imageFile = File(r'C:\Users\pc_nu\Downloads\test.png');
      when(mockUploadImageUseCase.execute(imageFile: imageFile))
          .thenAnswer((_) async => Success<UploadImageResponseEntity>(data: uploadImageResponseEntity));

      // register dependencies in getIt
      getIt.registerSingleton<LocalizationManager>(mockLocalizationManager);
      getIt.registerSingleton<AppLocalizations>(mockAppLocalizations);
      getIt.registerSingleton<ValidateFunctions>(mockValidateFunctions);
      getIt.registerFactory<EditProfileViewModel>(
            () => EditProfileViewModel(
          mockGetUserDataUseCase,
          mockEditInfoUseCase,
          mockUploadImageUseCase,
        ),
      );
    });

    Widget build() {
      return const MaterialApp(
        locale: Locale("en"),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: EditProfileScreen(),
      );
    }

    testWidgets('should render update button with correct text', (tester) async {
      when(mockAppLocalizations.editProfile).thenReturn("Edit Profile");
      when(mockAppLocalizations.update).thenReturn("Update");
      when(mockAppLocalizations.yourWeight).thenReturn("Your Weight");
      when(mockAppLocalizations.yourGoal).thenReturn("Your Goal");
      when(mockAppLocalizations.yourActivityLevel).thenReturn("Your Activity");
      when(mockAppLocalizations.tapToEdit).thenReturn("Tap to Edit");
      when(mockAppLocalizations.success).thenReturn("Success");
      when(mockAppLocalizations.updatedSuccessfully).thenReturn("Updated Successfully");

      await tester.pumpWidget(build());
      await tester.pumpAndSettle();

      expect(find.text("Update"), findsOneWidget);
      expect(find.text("Your Weight"), findsOneWidget);
      expect(find.text("Your Goal"), findsOneWidget);
      expect(find.text("Your Activity"), findsOneWidget);
    });

    testWidgets('check if text field is render', (tester) async {
      await tester.pumpWidget(build());
      expect(find.byType(TextFormField), findsNWidgets(6));
    });
  });
}
