// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:get_it/get_it.dart';
// import 'package:super_fitness/core/apis/api_error/api_error_handler.dart';
// import 'package:super_fitness/core/di/injectable_initializer.dart';
// import 'package:super_fitness/core/validation/validation_functions.dart';
// import 'package:super_fitness/modules/authentication/ui/complete_register/view_model/complete_register_cubit.dart';
// import 'package:super_fitness/modules/authentication/ui/register/register_screen.dart';
// import 'package:super_fitness/modules/authentication/ui/register/view_model/register_view_model.dart';
// import 'package:super_fitness/shared_layers/localization/generated/app_localizations.dart';
// import 'package:super_fitness/shared_layers/localization/l10n_manager/localization_manager.dart';
// import 'package:super_fitness/shared_layers/storage/implementation/flutter_secure_storage_service_imp.dart';
// import 'register_cubit_test.mocks.dart';
//
// void main() {
//   late AppLocalizations appLocalizations;
//   setUpAll(() async {
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
//     getIt.registerFactory<CompleteRegisterCubit>(() => CompleteRegisterCubit());
//   });
//   Widget buildWidget() => MaterialApp(
//     home: BlocProvider<RegisterViewModel>(
//       create:
//           (_) => RegisterViewModel(
//             MockRegisterUserCase(),
//             MockSignUpWithGoogleAccountUseCase(),
//             MockGoogleSignInHandler(),
//           ),
//       child: const RegisterScreen(),
//     ),
//     localizationsDelegates: AppLocalizations.localizationsDelegates,
//     supportedLocales: AppLocalizations.supportedLocales,
//     localeResolutionCallback: (locale, supportedLocales) {
//       GetIt.instance<LocalizationManager>().changeLocal(locale!.languageCode);
//       return locale;
//     },
//   );
//   group('RegisterScreen', () {
//     group('Register', () {
//       testWidgets('Check if image is rendered', (tester) async {
//         await tester.pumpWidget(buildWidget());
//         await tester.pump();
//         expect(find.byType(Image), findsAtLeast(1));
//       });
//       testWidgets('Check if Text is rendered', (tester) async {
//         await tester.pumpWidget(buildWidget());
//         await tester.pump();
//         expect(find.byType(Text), findsAtLeast(1));
//       });
//       testWidgets('Check if TextFormField is rendered', (tester) async {
//         await tester.pumpWidget(buildWidget());
//         await tester.pump();
//         expect(find.byType(TextFormField), findsAtLeast(1));
//       });
//       testWidgets('Check if FilledButton is rendered', (tester) async {
//         await tester.pumpWidget(buildWidget());
//         await tester.pump();
//         expect(find.byType(FilledButton), findsAtLeast(1));
//       });
//     });
//   });
// }
