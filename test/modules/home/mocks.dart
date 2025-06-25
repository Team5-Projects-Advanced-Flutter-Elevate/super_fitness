import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/core/di/injectable_initializer.dart';
import 'package:super_fitness/core/routing/generate_route.dart';
import 'package:super_fitness/core/validation/validation_functions.dart';
import 'package:super_fitness/main.dart';
import 'package:super_fitness/modules/home/ui/home_screen.dart';
import 'package:super_fitness/modules/home/ui/pages/home_page/home_page.dart';
import 'package:super_fitness/modules/home/ui/pages/workouts_page/workouts_page.dart';
import 'package:super_fitness/modules/home/ui/view_model/home_view_model.dart';
import 'package:super_fitness/shared_layers/localization/generated/app_localizations.dart';
import 'package:super_fitness/shared_layers/localization/l10n_manager/localization_manager.dart';
import 'package:super_fitness/shared_layers/storage/contracts/flutter_secure_storage_service_contract.dart';
import 'package:super_fitness/shared_layers/storage/implementation/flutter_secure_storage_service_imp.dart';

import 'mocks.mocks.dart';

class MockBaseInheritedWidget extends InheritedWidget {
  final double screenWidth;
  final double screenHeight;
  final ThemeData theme;

  const MockBaseInheritedWidget({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.theme,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static MockBaseInheritedWidget of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<MockBaseInheritedWidget>()!;
}

@GenerateMocks([
  AppLocalizations,
  NavigatorObserver,
  LocalizationManager,
  SecureStorageService,
  ValidateFunctions,
  FlutterSecureStorage,
  HomeViewModel,
  PageController,
])
void main() {
  late MockAppLocalizations mockAppLocalizations;
  late MockNavigatorObserver mockNavigatorObserver;
  late MockLocalizationManager mockLocalizationManager;
  late MockSecureStorageService mockSecureStorageService;
  late MockValidateFunctions mockValidateFunctions;
  late MockFlutterSecureStorage mockFlutterSecureStorage;
  late MockHomeViewModel mockHomeViewModel;
  late MockPageController mockPageController;
  late ValueNotifier<int> mockCurrentPageIndexNotifier;

  setUp(() async {
    mockAppLocalizations = MockAppLocalizations();
    mockNavigatorObserver = MockNavigatorObserver();
    mockLocalizationManager = MockLocalizationManager();
    mockSecureStorageService = MockSecureStorageService();
    mockValidateFunctions = MockValidateFunctions();
    mockFlutterSecureStorage = MockFlutterSecureStorage();
    mockHomeViewModel = MockHomeViewModel();
    mockPageController = MockPageController();
    mockCurrentPageIndexNotifier = ValueNotifier<int>(0);

    when(mockAppLocalizations.explore).thenReturn('Explore');
    when(mockAppLocalizations.aiChat).thenReturn('AI Chat');
    when(mockAppLocalizations.workouts).thenReturn('Workouts');
    when(mockAppLocalizations.profile).thenReturn('Profile');

    when(mockLocalizationManager.currentLocale).thenReturn('en');
    when(mockLocalizationManager.changeLocal(any)).thenAnswer((_) async {});
    when(mockLocalizationManager.getSavedLocal()).thenAnswer((_) async => 'en');

    when(
      mockSecureStorageService.setStringValue(any, any),
    ).thenAnswer((_) async {});
    when(
      mockSecureStorageService.getStringValue(any),
    ).thenAnswer((_) async => 'en');
    when(mockSecureStorageService.deleteValue(any)).thenAnswer((_) async {});

    when(mockHomeViewModel.pageViewController).thenReturn(mockPageController);
    when(
      mockHomeViewModel.currentPageIndexNotifier,
    ).thenReturn(mockCurrentPageIndexNotifier);
    when(mockPageController.jumpToPage(any)).thenAnswer((_) async {});
    when(mockPageController.page).thenReturn(0.0); // Initial page

    await getIt.reset();
    getIt.registerSingleton<SecureStorageService>(
      SecureStorageServiceImp(mockFlutterSecureStorage),
    );
    getIt.registerSingleton<LocalizationManager>(mockLocalizationManager);
    getIt.registerSingleton<AppLocalizations>(mockAppLocalizations);
    getIt.registerSingleton<ValidateFunctions>(mockValidateFunctions);
    getIt.registerSingleton<HomeViewModel>(mockHomeViewModel);
  });

  tearDown(() {
    mockCurrentPageIndexNotifier.dispose();
  });

  Widget createTestableWidget(Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocalizationManager>.value(
          value: mockLocalizationManager,
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('ar')],
        locale: const Locale('en'),
        navigatorKey: globalNavigatorKey,
        navigatorObservers: [mockNavigatorObserver],
        onGenerateRoute: GenerateRoute.onGenerateRoute,
        home: MockBaseInheritedWidget(
          screenWidth: 400,
          screenHeight: 800,
          theme: ThemeData.light(),
          child: Builder(
            builder: (context) {
              AppLocalizations.of(context);
              return child;
            },
          ),
        ),
      ),
    );
  }

  group('HomeScreen Widget Tests', () {
    testWidgets('BottomNavigationBar updates index on PageView change', (
      WidgetTester tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(400, 800));

      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        const MethodChannel('io.flutter.plugins.imageprovider/network_image'),
        (MethodCall call) async => null,
      );

      await tester.pumpWidget(createTestableWidget(const HomeScreen()));
      await tester.pumpAndSettle();

      expect(
        find.byType(BottomNavigationBar),
        findsOneWidget,
        reason: 'BottomNavigationBar should be rendered',
      );
      expect(
        find.byType(HomePage),
        findsOneWidget,
        reason: 'HomePage should be initial page',
      );
      final initialNavBar = tester.widget<BottomNavigationBar>(
        find.byType(BottomNavigationBar),
      );
      expect(
        initialNavBar.currentIndex,
        0,
        reason: 'Initial index should be 0',
      );

      when(mockPageController.page).thenReturn(2.0);
      mockCurrentPageIndexNotifier.value = 2;
      mockHomeViewModel.pageViewController.jumpToPage(2);
      await tester.pumpAndSettle();

      if (find.byType(BottomNavigationBar).evaluate().isEmpty) {
        debugDumpApp();
      }

      expect(
        find.byType(BottomNavigationBar),
        findsOneWidget,
        reason: 'BottomNavigationBar should still be rendered',
      );
      final updatedNavBar = tester.widget<BottomNavigationBar>(
        find.byType(BottomNavigationBar),
      );
      expect(
        updatedNavBar.currentIndex,
        2,
        reason: 'BottomNavigationBar index should be 2',
      );
      expect(
        find.byType(WorkoutsPage),
        findsOneWidget,
        reason: 'WorkoutsPage should be displayed',
      );
      expect(
        find.byType(HomePage),
        findsNothing,
        reason: 'HomePage should not be displayed',
      );

      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        const MethodChannel('io.flutter.plugins.imageprovider/network_image'),
        null,
      );
    });
  });
}
