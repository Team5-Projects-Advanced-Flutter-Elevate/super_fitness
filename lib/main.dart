import 'package:device_preview/device_preview.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/core/bases/base_inherited_widget.dart';
import 'package:super_fitness/core/routing/defined_routes.dart';
import 'package:super_fitness/core/routing/generate_route.dart';
import 'package:super_fitness/core/themes/app_themes.dart';
import 'package:super_fitness/core/utilities/single_data_per_application/single_data_per_application_provider.dart';
import 'package:super_fitness/core/utilities/user_provider/user_provider.dart';
import 'package:super_fitness/shared_layers/localization/l10n_manager/localization_manager.dart';

import 'core/di/injectable_initializer.dart';
import 'core/validation/validation_functions.dart';
import 'firebase_options.dart';
import 'modules/authentication/domain/usecase/login/login_local.dart';
import 'shared_layers/localization/generated/app_localizations.dart';

GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();
// just sonarQube workflow to run again
void main() async {
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Safety Net provider
    // 3. Play Integrity provider
    androidProvider:
        kReleaseMode ? AndroidProvider.playIntegrity : AndroidProvider.debug,
    // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Device Check provider
    // 3. App Attest provider
    // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
    appleProvider:
        kReleaseMode ? AppleProvider.deviceCheck : AppleProvider.debug,
  );
  await configureDependencies();

  var userLoginInfo = await getIt.get<StoreLoginLocalUseCase>().getLocalData();
  getIt.get<UserProvider>().changeUserLoginInfo(userLoginInfo);

  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => getIt.get<LocalizationManager>(),
        ),
        ChangeNotifierProvider(
          create: (context) => getIt.get<SingleDataPerApplicationProvider>(),
        ),
        ChangeNotifierProvider(create: (context) => getIt.get<UserProvider>()),
      ],
      child: DevicePreview(
        enabled: false,
        builder: (context) {
          return const MyApp();
        },
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   getIt.get<LocalizationManager>().changeLocal("en");
    // });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<LocalizationManager>(
      builder: (context, localizationManager, child) {
        return BaseInheritedWidget(
          theme: AppThemes.darkTheme,
          screenWidth: MediaQuery.of(context).size.width,
          screenHeight: MediaQuery.of(context).size.height,
          appLocalizations: getIt.get<AppLocalizations>(),
          localizationManager: getIt.get<LocalizationManager>(),
          validateFunctions: getIt.get<ValidateFunctions>(),
          child: MaterialApp(
            title: 'Super Fitness App',
            debugShowCheckedModeBanner: false,
            theme: AppThemes.darkTheme,
            themeMode: ThemeMode.light,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            navigatorKey: globalNavigatorKey,
            locale: Locale(localizationManager.currentLocale),
            onGenerateRoute: GenerateRoute.onGenerateRoute,
            onGenerateInitialRoutes: (initialRoute) {
              return GenerateRoute.onGenerateInitialRoutes(
                initialRoute: DefinedRoutes.onboardingScreenRoute,
                loginInfo: getIt.get<UserProvider>().userLoginInfo,
              );
            },
          ),
        );
      },
    );
  }
}
