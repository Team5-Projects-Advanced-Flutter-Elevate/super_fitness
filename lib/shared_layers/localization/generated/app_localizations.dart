import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @errorMessages________.
  ///
  /// In en, this message translates to:
  /// **'\$\$\$ Comment \$\$\$'**
  String get errorMessages________;

  /// No description provided for @connectionTimeout.
  ///
  /// In en, this message translates to:
  /// **'Connection timeout with server ⌛'**
  String get connectionTimeout;

  /// No description provided for @sendTimeout.
  ///
  /// In en, this message translates to:
  /// **'Send timeout in connection with server ⏱'**
  String get sendTimeout;

  /// No description provided for @receiveTimeout.
  ///
  /// In en, this message translates to:
  /// **'Receive timeout in connection with server ⏰'**
  String get receiveTimeout;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Request to server was cancelled ✖'**
  String get cancel;

  /// No description provided for @connectionError.
  ///
  /// In en, this message translates to:
  /// **'No Internet connection 😑'**
  String get connectionError;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'Something Went Wrong 🤔'**
  String get unknownError;

  /// No description provided for @badCertificate.
  ///
  /// In en, this message translates to:
  /// **'The certificate provided by the server is not valid 📑'**
  String get badCertificate;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something Went Wrong 🤔'**
  String get somethingWentWrong;

  /// No description provided for @validationFunctions____________.
  ///
  /// In en, this message translates to:
  /// **'\$\$\$ Comment \$\$\$'**
  String get validationFunctions____________;

  /// No description provided for @pleaseEnterName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name.'**
  String get pleaseEnterName;

  /// No description provided for @pleaseEnterUserName.
  ///
  /// In en, this message translates to:
  /// **'Please enter user name.'**
  String get pleaseEnterUserName;

  /// No description provided for @userNameLength.
  ///
  /// In en, this message translates to:
  /// **'Username must be between 3 and 16 characters long.'**
  String get userNameLength;

  /// No description provided for @userNameRules.
  ///
  /// In en, this message translates to:
  /// **'Username can only contain letters, numbers, and underscores.'**
  String get userNameRules;

  /// No description provided for @pleaseEnterFirstName.
  ///
  /// In en, this message translates to:
  /// **'Please enter first name.'**
  String get pleaseEnterFirstName;

  /// No description provided for @pleaseEnterLastName.
  ///
  /// In en, this message translates to:
  /// **'Please enter last name.'**
  String get pleaseEnterLastName;

  /// No description provided for @namesRules.
  ///
  /// In en, this message translates to:
  /// **'Names can only have alphabetic characters.'**
  String get namesRules;

  /// No description provided for @pleaseEnterEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your E-mail.'**
  String get pleaseEnterEmail;

  /// No description provided for @pleaseEnterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address.'**
  String get pleaseEnterValidEmail;

  /// No description provided for @pleaseEnterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number.'**
  String get pleaseEnterPhoneNumber;

  /// No description provided for @phoneNumberRules.
  ///
  /// In en, this message translates to:
  /// **'Number must start with one of the valid prefixes:\n010, 011, 012, or 015\nfollowed by 8 digits.'**
  String get phoneNumberRules;

  /// No description provided for @pleaseEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password.'**
  String get pleaseEnterPassword;

  /// No description provided for @passwordLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters long.'**
  String get passwordLength;

  /// No description provided for @uppercaseRulePassword.
  ///
  /// In en, this message translates to:
  /// **'At least one one uppercase letter.'**
  String get uppercaseRulePassword;

  /// No description provided for @lowercaseRulePassword.
  ///
  /// In en, this message translates to:
  /// **'At least one one lowercase letter.'**
  String get lowercaseRulePassword;

  /// No description provided for @digitRulePassword.
  ///
  /// In en, this message translates to:
  /// **'At least one digit must be there.'**
  String get digitRulePassword;

  /// No description provided for @specialCharactersRulePassword.
  ///
  /// In en, this message translates to:
  /// **'At least one special character(e.g., #?!@\$%^&*-) must be included.'**
  String get specialCharactersRulePassword;

  /// No description provided for @pleaseConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Please confirm password.'**
  String get pleaseConfirmPassword;

  /// No description provided for @namesLengthRule.
  ///
  /// In en, this message translates to:
  /// **'Names must be at least three characters long.'**
  String get namesLengthRule;

  /// No description provided for @noMatch.
  ///
  /// In en, this message translates to:
  /// **'No Match!'**
  String get noMatch;

  /// No description provided for @pleaseEnterAddress.
  ///
  /// In en, this message translates to:
  /// **'Please enter the address'**
  String get pleaseEnterAddress;

  /// No description provided for @pleaseEnterValidAddress.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid address'**
  String get pleaseEnterValidAddress;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @doIt.
  ///
  /// In en, this message translates to:
  /// **'Do It'**
  String get doIt;

  /// No description provided for @priceOfExcellence.
  ///
  /// In en, this message translates to:
  /// **'The Price Of Excellence'**
  String get priceOfExcellence;

  /// No description provided for @isDiscipline.
  ///
  /// In en, this message translates to:
  /// **'Is Discipline'**
  String get isDiscipline;

  /// No description provided for @fitnessHasNeverBeenSo.
  ///
  /// In en, this message translates to:
  /// **'Fitness Has Never Been So'**
  String get fitnessHasNeverBeenSo;

  /// No description provided for @muchFun.
  ///
  /// In en, this message translates to:
  /// **'Much Fun'**
  String get muchFun;

  /// No description provided for @noMoreExecuses.
  ///
  /// In en, this message translates to:
  /// **'NO MORE EXCUSES'**
  String get noMoreExecuses;

  /// No description provided for @doItNow.
  ///
  /// In en, this message translates to:
  /// **'Do It Now'**
  String get doItNow;

  /// No description provided for @loremIpsumDolorSitAmetConsectetureuUrna.
  ///
  /// In en, this message translates to:
  /// **'Lorem ipsum dolor sit amet consectetur. Eu urna'**
  String get loremIpsumDolorSitAmetConsectetureuUrna;

  /// No description provided for @utGravidaQuisIdPretiumPurusMaurisMassa.
  ///
  /// In en, this message translates to:
  /// **'ut gravida quis id pretium purus. Mauris massa'**
  String get utGravidaQuisIdPretiumPurusMaurisMassa;

  /// No description provided for @pleaseEnterValidRecipient.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid recipient'**
  String get pleaseEnterValidRecipient;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
