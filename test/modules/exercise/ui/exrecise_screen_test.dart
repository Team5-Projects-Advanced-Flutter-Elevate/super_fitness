// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:get_it/get_it.dart';
// import 'package:mockito/mockito.dart';
// import 'package:super_fitness/core/apis/api_error/api_error_handler.dart';
// import 'package:super_fitness/core/apis/api_result/api_result.dart';
// import 'package:super_fitness/core/di/injectable_initializer.dart';
// import 'package:super_fitness/core/validation/validation_functions.dart';
// import 'package:super_fitness/modules/exercise/domain/entity/exercise_entity.dart';
// import 'package:super_fitness/modules/exercise/domain/entity/get_exercise.dart';
// import 'package:super_fitness/modules/exercise/ui/cubit/view_model.dart';
// import 'package:super_fitness/modules/exercise/ui/screen/exercise_screen.dart';
// import 'package:super_fitness/shared_layers/localization/generated/app_localizations.dart';
// import 'package:super_fitness/shared_layers/localization/l10n_manager/localization_manager.dart';
// import 'package:super_fitness/shared_layers/storage/implementation/flutter_secure_storage_service_imp.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'exercise_cubit_test.mocks.dart';

// void main() {
//   late AppLocalizations appLocalizations;
//   MockExerciseUseCase mockExerciseUseCase =
//       MockExerciseUseCase();
//       provideDummyBuilder<ApiResult<GetExerciseEntity>>(
//   (parent, invocation) => Success(data: const GetExerciseEntity(exercises: [ExerciseEntity(
//           id: '1',
//           targetMuscleGroup: 'Chest',
//           difficultyLevel: 'Beginner',
//           posture: 'Standing',
//           shortYoutubeDemonstrationLink: 'https://youtube.com/short',
//         )], currentPage: 1, totalPages: 1, totalExercises: 1, message: 'success',)),
// );
//   setUpAll(() async {
//     InAppWebViewPlatform.instance = MockInAppWebViewPlatform();
//     appLocalizations = await AppLocalizations.delegate.load(const Locale('en'));
//     getIt.registerSingleton<AppLocalizations>(appLocalizations);
//     getIt.registerSingleton<LocalizationManager>(
//       LocalizationManager(
//         SecureStorageServiceImp(const FlutterSecureStorage()),
//         'en',
//       ),
//     );
//     getIt.registerSingleton<ValidateFunctions>(
//       ValidateFunctions(appLocalizations),
//     );
//     getIt.registerSingleton<ApiErrorHandler>(ApiErrorHandler(appLocalizations));
//     getIt.registerFactory<ExerciseViewModel>(
//       () => ExerciseViewModel(mockExerciseUseCase),
//     );
//   });
//   Widget buildWidget() => MaterialApp(
//     home: const ExerciseScreen(muscleId: '67c797e226895f87ce0aa94b',),
//     localizationsDelegates: AppLocalizations.localizationsDelegates,
//     supportedLocales: AppLocalizations.supportedLocales,
//     localeResolutionCallback: (locale, supportedLocales) {
//       GetIt.instance<LocalizationManager>().changeLocal(locale!.languageCode);
//       return locale;
//     },
//   );

//   group('ExerciseScreen', () {
//     testWidgets('Check if Image is rendered', (tester) async {
//       when(mockExerciseUseCase.call('67c797e226895f87ce0aa94b', '67c797e226895f87ce0aa94b'))
//     .thenAnswer((_) async => Success(data: const GetExerciseEntity(exercises: [ExerciseEntity(
//           id: '1',
//           targetMuscleGroup: 'Chest',
//           difficultyLevel: 'Beginner',
//           posture: 'Standing',
//           shortYoutubeDemonstrationLink: 'https://youtube.com/short',
//         )], currentPage: 1, totalPages: 1, totalExercises: 1, message: 'success',)));
//       await tester.pumpWidget(buildWidget());
//       await tester.pump();
//       expect(
//         find.byType(Image),
//         findsAtLeast(1),
//       );
//     });
//   });
// }
// class MockInAppWebViewPlatform extends InAppWebViewPlatform {
//   @override
//   Future<void> init() async {}

//   @override
//   Future<void> dispose() async {}

//   @override
//   Future<String> getPlatformVersion() async {
//     return 'FakePlatformVersion';
//   }

//   @override
//   InAppWebViewWidget createPlatformInAppWebViewWidget(
//     InAppWebViewSettings options,
//     InAppWebViewController webViewController,
//   ) {
//     return MockInAppWebViewWidget();
//   }
// }