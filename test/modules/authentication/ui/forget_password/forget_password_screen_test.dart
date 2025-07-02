import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:super_fitness/core/apis/api_error/api_error_handler.dart';
import 'package:super_fitness/core/di/injectable_initializer.dart';
import 'package:super_fitness/core/validation/validation_functions.dart';
import 'package:super_fitness/modules/authentication/ui/forget_password/view/forget_password_screen.dart';
import 'package:super_fitness/modules/authentication/ui/forget_password/view/reset_code_screen.dart';
import 'package:super_fitness/modules/authentication/ui/forget_password/view/reset_password_screen.dart';
import 'package:super_fitness/modules/authentication/ui/forget_password/view_model/forget_password_view_model.dart';
import 'package:super_fitness/shared_layers/localization/generated/app_localizations.dart';
import 'package:super_fitness/shared_layers/localization/l10n_manager/localization_manager.dart';
import 'package:super_fitness/shared_layers/storage/implementation/flutter_secure_storage_service_imp.dart';

import 'forget_password_cubit_test.mocks.dart';

void main() {
  late AppLocalizations appLocalizations;
  MockForgetPasswordUseCase mockForgetPasswordUseCase =
      MockForgetPasswordUseCase();
  MockResetPasswordUseCase mockResetPasswordUseCase =
      MockResetPasswordUseCase();
  MockResetCodeUseCase mockResetCodeUseCase = MockResetCodeUseCase();
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
    getIt.registerFactory<ForgetPasswordViewModel>(
      () => ForgetPasswordViewModel(
        mockResetPasswordUseCase,
        mockForgetPasswordUseCase,
        mockResetCodeUseCase,
      ),
    );
  });

  group('ForgetPasswordScreen', () {
    group('ForgetPassword', () {
      testWidgets('Check if image is rendered', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: const ForgetPasswordScreen(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            localeResolutionCallback: (locale, supportedLocales) {
              GetIt.instance<LocalizationManager>().changeLocal(
                locale!.languageCode,
              );
              return locale;
            },
          ),
        );
        await tester.pump();
        expect(find.byType(Image), findsAtLeast(1));
      });
      testWidgets('Check if Text is rendered', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: const ForgetPasswordScreen(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            localeResolutionCallback: (locale, supportedLocales) {
              GetIt.instance<LocalizationManager>().changeLocal(
                locale!.languageCode,
              );
              return locale;
            },
          ),
        );
        await tester.pump();
        expect(find.byType(Text), findsAtLeast(1));
      });
      testWidgets('Check if TextFormField is rendered', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: const ForgetPasswordScreen(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            localeResolutionCallback: (locale, supportedLocales) {
              GetIt.instance<LocalizationManager>().changeLocal(
                locale!.languageCode,
              );
              return locale;
            },
          ),
        );
        await tester.pump();
        expect(find.byType(TextFormField), findsAtLeast(1));
      });
      testWidgets('Check if FilledButton is rendered', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: const ForgetPasswordScreen(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            localeResolutionCallback: (locale, supportedLocales) {
              GetIt.instance<LocalizationManager>().changeLocal(
                locale!.languageCode,
              );
              return locale;
            },
          ),
        );
        await tester.pump();
        expect(find.byType(FilledButton), findsAtLeast(1));
      });
    });
    group('ResetPassword', () {
      testWidgets('Check if image is rendered', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: ResetPasswordScreen(
              viewModel: ForgetPasswordViewModel(
                mockResetPasswordUseCase,
                mockForgetPasswordUseCase,
                mockResetCodeUseCase,
              ),
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            localeResolutionCallback: (locale, supportedLocales) {
              GetIt.instance<LocalizationManager>().changeLocal(
                locale!.languageCode,
              );
              return locale;
            },
          ),
        );
        await tester.pump();
        expect(find.byType(Image), findsAtLeast(1));
      });
      testWidgets('Check if Text is rendered', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: ResetPasswordScreen(
              viewModel: ForgetPasswordViewModel(
                mockResetPasswordUseCase,
                mockForgetPasswordUseCase,
                mockResetCodeUseCase,
              ),
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            localeResolutionCallback: (locale, supportedLocales) {
              GetIt.instance<LocalizationManager>().changeLocal(
                locale!.languageCode,
              );
              return locale;
            },
          ),
        );
        await tester.pump();
        expect(find.byType(Text), findsNWidgets(5));
      });
      testWidgets('Check if TextFormField is rendered', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: ResetPasswordScreen(
              viewModel: ForgetPasswordViewModel(
                mockResetPasswordUseCase,
                mockForgetPasswordUseCase,
                mockResetCodeUseCase,
              ),
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            localeResolutionCallback: (locale, supportedLocales) {
              GetIt.instance<LocalizationManager>().changeLocal(
                locale!.languageCode,
              );
              return locale;
            },
          ),
        );
        await tester.pump();
        expect(find.byType(TextFormField), findsNWidgets(2));
      });
      testWidgets('Check if FilledButton is rendered', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: ResetPasswordScreen(
              viewModel: ForgetPasswordViewModel(
                mockResetPasswordUseCase,
                mockForgetPasswordUseCase,
                mockResetCodeUseCase,
              ),
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            localeResolutionCallback: (locale, supportedLocales) {
              GetIt.instance<LocalizationManager>().changeLocal(
                locale!.languageCode,
              );
              return locale;
            },
          ),
        );
        await tester.pump();
        expect(find.byType(FilledButton), findsAtLeast(1));
      });
    });
    group('ResetCode', () {
      testWidgets('Check if image is rendered', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: ResetPasswordScreen(
              viewModel: ForgetPasswordViewModel(
                mockResetPasswordUseCase,
                mockForgetPasswordUseCase,
                mockResetCodeUseCase,
              ),
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            localeResolutionCallback: (locale, supportedLocales) {
              GetIt.instance<LocalizationManager>().changeLocal(
                locale!.languageCode,
              );
              return locale;
            },
          ),
        );
        await tester.pump();
        expect(find.byType(Image), findsAtLeast(1));
      });
      testWidgets('Check if Text is rendered', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: ResetPasswordScreen(
              viewModel: ForgetPasswordViewModel(
                mockResetPasswordUseCase,
                mockForgetPasswordUseCase,
                mockResetCodeUseCase,
              ),
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            localeResolutionCallback: (locale, supportedLocales) {
              GetIt.instance<LocalizationManager>().changeLocal(
                locale!.languageCode,
              );
              return locale;
            },
          ),
        );
        await tester.pump();
        expect(find.byType(Text), findsNWidgets(5));
      });
      testWidgets('Check if FilledButton is rendered', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: ResetCodeScreen(
              viewModel: ForgetPasswordViewModel(
                mockResetPasswordUseCase,
                mockForgetPasswordUseCase,
                mockResetCodeUseCase,
              ),
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            localeResolutionCallback: (locale, supportedLocales) {
              GetIt.instance<LocalizationManager>().changeLocal(
                locale!.languageCode,
              );
              return locale;
            },
          ),
        );
        await tester.pump();
        expect(find.byType(OTPTextField), findsAtLeast(1));
      });
      testWidgets('Check if FilledButton is rendered', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: ResetCodeScreen(
              viewModel: ForgetPasswordViewModel(
                mockResetPasswordUseCase,
                mockForgetPasswordUseCase,
                mockResetCodeUseCase,
              ),
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            localeResolutionCallback: (locale, supportedLocales) {
              GetIt.instance<LocalizationManager>().changeLocal(
                locale!.languageCode,
              );
              return locale;
            },
          ),
        );
        await tester.pump();
        expect(find.byType(FilledButton), findsAtLeast(1));
      });
    });
  });
}
