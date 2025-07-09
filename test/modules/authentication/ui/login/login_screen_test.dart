import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/constants/assets_paths/assets_paths.dart';
import 'package:super_fitness/core/di/injectable_initializer.dart';
import 'package:super_fitness/core/utilities/social_accounts_sign_in/facebook_sign_in/facebook_sign_in_handler.dart';
import 'package:super_fitness/core/utilities/social_accounts_sign_in/google_sign_in/google_sign_in_handler.dart';
import 'package:super_fitness/core/validation/validation_functions.dart';
import 'package:super_fitness/modules/authentication/domain/usecase/login/login.dart';
import 'package:super_fitness/modules/authentication/domain/usecase/login/login_local.dart';
import 'package:super_fitness/modules/authentication/ui/login/cubit/login/view_model.dart';
import 'package:super_fitness/modules/authentication/ui/login/login_screen.dart';
import 'package:super_fitness/shared_layers/localization/generated/app_localizations.dart';
import 'package:super_fitness/shared_layers/localization/l10n_manager/localization_manager.dart';

import 'login_screen_test.mocks.dart';

@GenerateMocks([
  LoginUseCase,
  StoreLoginLocalUseCase,
  GoogleSignInHandler,
  FacebookSignInHandler,
  LocalizationManager,
  AppLocalizations,
  ValidateFunctions,
])
void main() {
  group('test login screen items', () {
    late MockLoginUseCase mockLoginUseCase;
    late MockStoreLoginLocalUseCase mockStoreLoginLocalUseCase;
    late MockGoogleSignInHandler mockGoogleSignInHandler;
    late FacebookSignInHandler mockFacebookSignInHandler;
    late MockAppLocalizations mockAppLocalizations;
    late MockLocalizationManager mockLocalizationManager;
    late MockValidateFunctions mockValidateFunctions;

    setUpAll(() async {
      mockLoginUseCase = MockLoginUseCase();
      mockStoreLoginLocalUseCase = MockStoreLoginLocalUseCase();
      mockGoogleSignInHandler = MockGoogleSignInHandler();
      mockFacebookSignInHandler = MockFacebookSignInHandler();
      mockLocalizationManager = MockLocalizationManager();
      mockAppLocalizations = MockAppLocalizations();
      mockValidateFunctions = MockValidateFunctions();

      when(mockAppLocalizations.welcomeBack).thenReturn("Welcome Back");


      getIt.registerSingleton<LocalizationManager>(mockLocalizationManager);
      getIt.registerSingleton<AppLocalizations>(mockAppLocalizations);
      getIt.registerSingleton<ValidateFunctions>(mockValidateFunctions);

      // register your LoginViewModel with the mocks
      getIt.registerFactory<LoginViewModel>(
        () => LoginViewModel(
          mockLoginUseCase,
          mockGoogleSignInHandler,
          mockFacebookSignInHandler,
          mockStoreLoginLocalUseCase,
        ),
      );
    });

    Widget build() {
      return const MaterialApp(
        locale: Locale("en"),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: LoginScreen(),
      );
    }

    testWidgets('check if image is render', (widgetTester) async {
      await widgetTester.pumpWidget(build());
      var image =find.image(const AssetImage(AssetsPaths.fitnessAppIcon));
      expect(image, findsOneWidget);


    });
    
    testWidgets('check if text field is render', (widgetTester)async {
      await widgetTester.pumpWidget(build());
      var textField=find.byType(TextFormField);
      expect(textField, findsNWidgets(2));

    },);


    testWidgets('check if login button is rendered', (widgetTester) async {
      await widgetTester.pumpWidget(build());

      var button = find.byType(ElevatedButton);
      expect(button, findsWidgets);

    });

    testWidgets('check if google button is rendered', (widgetTester) async {
      await widgetTester.pumpWidget(build());

      var googleIcon = find.image(const AssetImage(AssetsPaths.googleIcon));
      expect(googleIcon, findsOneWidget);

    });







  });
}
