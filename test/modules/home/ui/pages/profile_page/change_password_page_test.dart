import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:super_fitness/core/apis/api_error/api_error_handler.dart';
import 'package:super_fitness/core/di/injectable_initializer.dart';
import 'package:super_fitness/core/validation/validation_functions.dart';
import 'package:super_fitness/modules/home/ui/pages/profile_page/change_password_page.dart';
import 'package:super_fitness/modules/home/ui/view_model/change_password/change_password_view_model.dart';
import 'package:super_fitness/shared_layers/localization/generated/app_localizations.dart';
import 'package:super_fitness/shared_layers/localization/l10n_manager/localization_manager.dart';
import 'package:super_fitness/shared_layers/storage/implementation/flutter_secure_storage_service_imp.dart';
import 'change_password_cubit_test.mocks.dart';

void main() {
  late AppLocalizations appLocalizations;
  MockChangePasswordUseCase mockChangePasswordUseCase =
      MockChangePasswordUseCase();
  setUpAll(() async {
    appLocalizations = await AppLocalizations.delegate.load(const Locale('en'));
    getIt.registerSingleton<AppLocalizations>(appLocalizations);
    getIt.registerSingleton<LocalizationManager>(
      LocalizationManager(
        SecureStorageServiceImp(const FlutterSecureStorage()),
        'en',
      ),
    );
    getIt.registerSingleton<ValidateFunctions>(
      ValidateFunctions(appLocalizations),
    );
    getIt.registerSingleton<ApiErrorHandler>(ApiErrorHandler(appLocalizations));
    getIt.registerFactory<ChangePasswordViewModel>(
      () => ChangePasswordViewModel(mockChangePasswordUseCase),
    );
  });
  Widget buildWidget() => MaterialApp(
    home: const ChangePasswordScreen(),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    localeResolutionCallback: (locale, supportedLocales) {
      GetIt.instance<LocalizationManager>().changeLocal(locale!.languageCode);
      return locale;
    },
  );

  group('ChangePasswordScreen', () {
    testWidgets('Check if image is rendered', (tester) async {
      await tester.pumpWidget(buildWidget());
      await tester.pump();
      expect(
        find.byKey(const Key('changePasswordScreenImage')),
        findsAtLeast(1),
      );
    });
    testWidgets('Check if CurrentPasswordTextFormField is rendered', (
      tester,
    ) async {
      await tester.pumpWidget(buildWidget());
      await tester.pump();
      expect(
        find.byKey(const Key('changePasswordScreenCurrentPassword')),
        findsAtLeast(1),
      );
    });
    testWidgets('Check if NewPasswordTextFormField is rendered', (
      tester,
    ) async {
      await tester.pumpWidget(buildWidget());
      await tester.pump();
      expect(
        find.byKey(const Key('changePasswordScreenNewPassword')),
        findsAtLeast(1),
      );
    });
    testWidgets('Check if ConfirmPasswordTextFormField is rendered', (
      tester,
    ) async {
      await tester.pumpWidget(buildWidget());
      await tester.pump();
      expect(
        find.byKey(const Key('changePasswordScreenConfirmPassword')),
        findsAtLeast(1),
      );
    });
    testWidgets('Check if DoneButton is rendered', (
      tester,
    ) async {
      await tester.pumpWidget(buildWidget());
      await tester.pump();
      expect(
        find.byKey(const Key('changePasswordScreenDoneButton')),
        findsAtLeast(1),
      );
    });
  });
}
