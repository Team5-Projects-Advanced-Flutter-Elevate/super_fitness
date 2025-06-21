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
import 'package:super_fitness/shared_layers/localization/l10n_manager/localization_manager.dart';

import 'core/di/injectable_initializer.dart';
import 'core/validation/validation_functions.dart';
import 'firebase_options.dart';
import 'modules/authentication/ui/forget_password/view/forget_password_screen.dart';
import 'shared_layers/localization/generated/app_localizations.dart';

GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();
// just sonarQube workflow to run again
void main() async {
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await configureDependencies();

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
      ],
      child: const MyApp(),
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
            initialRoute: DefinedRoutes.homeScreenRoute,
            home: const ForgetPasswordScreen(),
            // initialRoute: DefinedRoutes.forgetPasswordScreenRoute,
            // onGenerateRoute: GenerateRoute.onGenerateRoute,
            // onGenerateInitialRoutes: (initialRoute) {
            //   return GenerateRoute.onGenerateInitialRoutes(
            //     initialRoute: DefinedRoutes.onboardingScreenRoute,
            //     loginInfo: null,
            //   );
            // },
          ),
        );
      },
    );
  }
}
