import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:super_fitness/core/di/injectable_initializer.dart';
import 'package:super_fitness/core/routing/generate_route.dart';
import 'package:super_fitness/core/validation/validation_functions.dart';
import 'package:super_fitness/main.dart';
import 'package:super_fitness/modules/onboarding/ui/screen/onboarding_screen.dart';
import 'package:super_fitness/shared_layers/localization/generated/app_localizations.dart';
import 'package:super_fitness/shared_layers/localization/l10n_manager/localization_manager.dart';
import 'package:super_fitness/shared_layers/storage/constants/storage_constants.dart';
import 'package:super_fitness/shared_layers/storage/contracts/flutter_secure_storage_service_contract.dart';
import 'package:super_fitness/shared_layers/storage/handler/storage_execution_handler.dart';
import 'package:super_fitness/shared_layers/storage/implementation/flutter_secure_storage_service_imp.dart'; 
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:super_fitness/core/routing/defined_routes.dart';
import 'package:super_fitness/shared_layers/storage/result/storage_result.dart';
import 'mocks.mocks.dart';

@GenerateMocks([
  AppLocalizations,
  NavigatorObserver,
  LocalizationManager,
  SecureStorageServiceImp,
  ValidateFunctions,
  FlutterSecureStorage,
])
void main() {
  late MockAppLocalizations mockAppLocalizations;
  late MockNavigatorObserver mockNavigatorObserver;
  late MockLocalizationManager mockLocalizationManager;
  late MockValidateFunctions mockValidateFunctions;
  late MockFlutterSecureStorage mockFlutterSecureStorage;

  setUp(() async {
    mockAppLocalizations = MockAppLocalizations();
    mockNavigatorObserver = MockNavigatorObserver();
    mockLocalizationManager = MockLocalizationManager();
    mockValidateFunctions = MockValidateFunctions();
    mockFlutterSecureStorage = MockFlutterSecureStorage();

    when(mockAppLocalizations.next).thenReturn('Next');
    when(mockAppLocalizations.back).thenReturn('Back');
    when(mockAppLocalizations.doIt).thenReturn('Do It');
    when(mockAppLocalizations.skip).thenReturn('Skip');
    when(mockAppLocalizations.priceOfExcellence).thenReturn('The Price Of Excellence');
    when(mockAppLocalizations.isDiscipline).thenReturn('Is Discipline');
    when(mockAppLocalizations.fitnessHasNeverBeenSo).thenReturn('Fitness Has Never Been So');
    when(mockAppLocalizations.muchFun).thenReturn('Much Fun');
    when(mockAppLocalizations.noMoreExecuses).thenReturn('NO MORE EXCUSES');
    when(mockAppLocalizations.doItNow).thenReturn('Do It Now');
    when(mockAppLocalizations.loremIpsumDolorSitAmetConsectetureuUrna)
        .thenReturn('Lorem ipsum dolor sit amet consectetur. Eu urna');
    when(mockAppLocalizations.utGravidaQuisIdPretiumPurusMaurisMassa)
        .thenReturn('ut gravida quis id pretium purus. Mauris massa');

    when(mockLocalizationManager.currentLocale).thenReturn('en');
    when(mockLocalizationManager.changeLocal(any)).thenAnswer((_) async {});
    when(mockLocalizationManager.getSavedLocal()).thenAnswer((_) async => 'en');


    getIt.registerSingleton<SecureStorageService>(SecureStorageServiceImp(mockFlutterSecureStorage));
    getIt.registerSingleton<LocalizationManager>(mockLocalizationManager);
    getIt.registerSingleton<AppLocalizations>(mockAppLocalizations);
    getIt.registerSingleton<ValidateFunctions>(mockValidateFunctions);
  });

  tearDown(() {
    getIt.reset();
  });

  Widget createTestableWidget(Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocalizationManager>.value(value: mockLocalizationManager),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [const Locale('en')],
        navigatorKey: globalNavigatorKey,
        navigatorObservers: [mockNavigatorObserver],
        onGenerateRoute: GenerateRoute.onGenerateRoute,
        home: child,
        routes: {
          DefinedRoutes.onboardingScreenRoute: (context) => const Scaffold(body: Text('Onboarding Screen')),
        },
      ),
    );
  }
  group('Storage Components Unit Tests', () {
  group('SecureStorageServiceImp', () {
    late SecureStorageServiceImp secureStorageService;

    setUp(() {
      secureStorageService = SecureStorageServiceImp(mockFlutterSecureStorage);
    });

    test('setStringValue stores value successfully', () async {
      when(mockFlutterSecureStorage.write(key: anyNamed('key'), value: anyNamed('value')))
          .thenAnswer((_) async => await null);

      secureStorageService.setStringValue('testKey', 'testValue');

      verify(mockFlutterSecureStorage.write(key: 'testKey', value: 'testValue')).called(1);
    });

    test('setStringValue handles error', () async {
      final error = Exception('Storage error');
      when(mockFlutterSecureStorage.write(key: anyNamed('key'), value: anyNamed('value')))
          .thenThrow(error);

      secureStorageService.setStringValue('testKey', 'testValue');

      verify(mockFlutterSecureStorage.write(key: 'testKey', value: 'testValue')).called(1);
    });

    test('getStringValue returns stored value', () async {
      when(mockFlutterSecureStorage.read(key: anyNamed('key')))
          .thenAnswer((_) async => 'testValue');

      final result = await secureStorageService.getStringValue('testKey');

      expect(result, 'testValue');
      verify(mockFlutterSecureStorage.read(key: 'testKey')).called(1);
    });

    test('getStringValue returns null on error', () async {
      final error = Exception('Read error');
      when(mockFlutterSecureStorage.read(key: anyNamed('key')))
          .thenThrow(error);

      final result = await secureStorageService.getStringValue('testKey');

      expect(result, null);
      verify(mockFlutterSecureStorage.read(key: 'testKey')).called(1);
    });

    test('deleteValue deletes value successfully', () async {
      when(mockFlutterSecureStorage.delete(key: anyNamed('key')))
          .thenAnswer((_) async => await null);

      await secureStorageService.deleteValue('testKey');

      verify(mockFlutterSecureStorage.delete(key: 'testKey')).called(1);
    });

    test('deleteValue handles error', () async {
      final error = Exception('Delete error');
      when(mockFlutterSecureStorage.delete(key: anyNamed('key')))
          .thenThrow(error);

      await secureStorageService.deleteValue('testKey');

      verify(mockFlutterSecureStorage.delete(key: 'testKey')).called(1);
    });
  });

  group('StorageExecutionHandler', () {
    test('execute returns StorageSuccessResult on success', () async {
      final result = await StorageExecutionHandler.execute<String>(() async => 'testValue');

      expect(result, isA<StorageSuccessResult<String>>());
      expect((result as StorageSuccessResult<String>).data, 'testValue');
    });

    test('execute returns StorageErrorResult on error', () async {
      final error = Exception('Test error');
      final result = await StorageExecutionHandler.execute<String>(() async => throw error);

      expect(result, isA<StorageErrorResult<String>>());
      expect((result as StorageErrorResult<String>).error, error);
    });
  });

  group('StorageConstants', () {
    test('errorStoringMessage formats error correctly', () {
      const error = 'Test error';
      final message = StorageConstants.errorStoringMessage(error);
      expect(message, 'Error Storing Value: $error');
    });

    test('errorReadingMessage formats error correctly', () {
      const error = 'Test error';
      final message = StorageConstants.errorReadingMessage(error);
      expect(message, 'Error Reading Value: $error');
    });

    test('errorDeletingMessage formats error correctly', () {
      const error = 'Test error';
      final message = StorageConstants.errorDeletingMessage(error);
      expect(message, 'Error Deleting Value: $error');
    });
  });
});
group('LocalizationManager Unit Tests', () {
  late SecureStorageServiceImp secureStorageService;

  setUp(() {
    secureStorageService = SecureStorageServiceImp(mockFlutterSecureStorage);
    getIt.registerSingleton<SecureStorageService>(secureStorageService);
  });

  test('changeLocal updates locale and stores it', () async {
    when(mockFlutterSecureStorage.write(key: anyNamed('key'), value: anyNamed('value')))
        .thenAnswer((_) async => await null);

    await mockLocalizationManager.changeLocal('ar');

    verify(mockFlutterSecureStorage.write(key: StorageConstants.localeKey, value: 'ar')).called(1);
    verify(mockLocalizationManager.notifyListeners()).called(1);
    expect(mockLocalizationManager.currentLocale, 'ar');
  });

  test('getSavedLocal returns stored locale', () async {
    when(mockFlutterSecureStorage.read(key: StorageConstants.localeKey))
        .thenAnswer((_) async => 'en');

    final result = await mockLocalizationManager.getSavedLocal();
    expect(result, 'en');
    verify(mockFlutterSecureStorage.read(key: StorageConstants.localeKey)).called(1);
  });

  test('isEnglish returns true for en locale', () {
    when(mockLocalizationManager.currentLocale).thenReturn('en');
    expect(mockLocalizationManager.isEnglish, true);

    when(mockLocalizationManager.currentLocale).thenReturn('ar');
    expect(mockLocalizationManager.isEnglish, false);
  });
});
group('OnboardingScreen Widget Tests', () {
  testWidgets('OnboardingScreen renders correctly with first page', (WidgetTester tester) async {
    await tester.pumpWidget(createTestableWidget(const OnboardingScreen()));
    await tester.pumpAndSettle();

    expect(find.text('The Price Of Excellence'), findsOneWidget);
    expect(find.text('Is Discipline'), findsOneWidget);
    expect(find.text('Lorem ipsum dolor sit amet consectetur. Eu urna'), findsOneWidget);
    expect(find.text('ut gravida quis id pretium purus. Mauris massa'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);
    expect(find.text('Skip'), findsOneWidget);
    expect(find.byType(SmoothPageIndicator), findsOneWidget);
  });

  testWidgets('Tapping Next button navigates to the next page', (WidgetTester tester) async {
    await tester.pumpWidget(createTestableWidget(const OnboardingScreen()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    expect(find.text('Fitness Has Never Been So'), findsOneWidget);
    expect(find.text('Much Fun'), findsOneWidget);
    expect(find.text('Back'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);
  });

  testWidgets('Tapping Back button navigates to the previous page', (WidgetTester tester) async {
    await tester.pumpWidget(createTestableWidget(const OnboardingScreen()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Back'));
    await tester.pumpAndSettle();

    expect(find.text('The Price Of Excellence'), findsOneWidget);
    expect(find.text('Is Discipline'), findsOneWidget);
  });

  testWidgets('Tapping Do It on the last page navigates to LoginScreen', (WidgetTester tester) async {
    await tester.pumpWidget(createTestableWidget(const OnboardingScreen()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Do It'));
    await tester.pumpAndSettle();

    verify(mockNavigatorObserver.didPush(any, any)).called(greaterThanOrEqualTo(1));
    expect(find.text('Login Screen'), findsOneWidget);
  });

  testWidgets('Tapping Skip navigates to LoginScreen', (WidgetTester tester) async {
    await tester.pumpWidget(createTestableWidget(const OnboardingScreen()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();

    verify(mockNavigatorObserver.didPush(any, any)).called(greaterThanOrEqualTo(1));
    expect(find.text('Login Screen'), findsOneWidget);
  });

  testWidgets('OnboardingScreen renders Arabic text after locale change', (WidgetTester tester) async {
    when(mockLocalizationManager.currentLocale).thenReturn('ar');
    when(mockAppLocalizations.next).thenReturn('التالى');
    when(mockAppLocalizations.skip).thenReturn('تخطي');
    when(mockAppLocalizations.priceOfExcellence).thenReturn('ثمن التميز');
    when(mockAppLocalizations.isDiscipline).thenReturn('هو الانضباط');

    await tester.pumpWidget(createTestableWidget(const OnboardingScreen()));
    await tester.pumpAndSettle();

    expect(find.text('ثمن التميز'), findsOneWidget);
    expect(find.text('هو الانضباط'), findsOneWidget);
    expect(find.text('التالى'), findsOneWidget);
    expect(find.text('تخطي'), findsOneWidget);
  });
});
}