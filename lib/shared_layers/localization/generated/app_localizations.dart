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

  /// No description provided for @pleaseEnterValidRecipient.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid recipient'**
  String get pleaseEnterValidRecipient;

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

  /// No description provided for @forgetPassword____________.
  ///
  /// In en, this message translates to:
  /// **'\$\$\$ تعليق \$\$\$'**
  String get forgetPassword____________;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get emailHint;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHint;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @confirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get confirmPasswordHint;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @removedImage.
  ///
  /// In en, this message translates to:
  /// **'Removed image'**
  String get removedImage;

  /// No description provided for @forgetPasswordDescription.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email associated to your account'**
  String get forgetPasswordDescription;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Successfully'**
  String get success;

  /// No description provided for @codeSendTitle.
  ///
  /// In en, this message translates to:
  /// **'Code send To Email'**
  String get codeSendTitle;

  /// No description provided for @otpScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Email verification'**
  String get otpScreenTitle;

  /// No description provided for @otpScreenDescription.
  ///
  /// In en, this message translates to:
  /// **'Please enter your code that send to your email address'**
  String get otpScreenDescription;

  /// No description provided for @didnotReciveOtp.
  ///
  /// In en, this message translates to:
  /// **'Did not receive code?'**
  String get didnotReciveOtp;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @codeValid.
  ///
  /// In en, this message translates to:
  /// **'Code is valid'**
  String get codeValid;

  /// No description provided for @codeNotvalid.
  ///
  /// In en, this message translates to:
  /// **'Code not valid'**
  String get codeNotvalid;

  /// No description provided for @resetPasswordScreenDescription.
  ///
  /// In en, this message translates to:
  /// **'Password must not be empty and must contain 6 characters with upper case letter and one number at least'**
  String get resetPasswordScreenDescription;

  /// No description provided for @resetPasswordScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPasswordScreenTitle;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmNewPassword;

  /// No description provided for @yourPasswordChanged.
  ///
  /// In en, this message translates to:
  /// **'Password Changed Successfully'**
  String get yourPasswordChanged;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterEmail;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterPassword;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget password?'**
  String get forgetPassword;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @pleaseEnterValidAddress.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid address'**
  String get pleaseEnterValidAddress;
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
