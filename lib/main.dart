import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/core/bases/base_inherited_widget.dart';
import 'package:super_fitness/core/themes/app_themes.dart';
import 'package:super_fitness/modules/authentication/ui/login/login_screen.dart';
import 'package:super_fitness/shared_layers/localization/l10n_manager/localization_manager.dart';

import 'core/di/injectable_initializer.dart';
import 'core/validation/validation_functions.dart';
import 'firebase_options.dart';
import 'shared_layers/localization/generated/app_localizations.dart';

GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
            home: const LoginScreen(),
            // onGenerateRoute: GenerateRoute.onGenerateRoute,
            // onGenerateInitialRoutes: (initialRoute) {
            //   return GenerateRoute.onGenerateInitialRoutes(
            //     initialRoute: initialRoute,
            //     loginInfo: null,
            //   );
            // },
          ),
        );
      },
    );
  }
}
