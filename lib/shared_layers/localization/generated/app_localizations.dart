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

  /// No description provided for @badRequest.
  ///
  /// In en, this message translates to:
  /// **'Bad request format 👎'**
  String get badRequest;

  /// No description provided for @couldNotFindSource.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t find the source 😱'**
  String get couldNotFindSource;

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
  /// **'Enter your Email.'**
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

  /// No description provided for @didNotReceiveOtp.
  ///
  /// In en, this message translates to:
  /// **'Did not receive code?'**
  String get didNotReceiveOtp;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend code?'**
  String get resend;

  /// No description provided for @codeValid.
  ///
  /// In en, this message translates to:
  /// **'Code is valid'**
  String get codeValid;

  /// No description provided for @codeNotValid.
  ///
  /// In en, this message translates to:
  /// **'Code not valid'**
  String get codeNotValid;

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

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterEmail;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterPassword;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget password'**
  String get forgetPassword;

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

  /// No description provided for @noMoreExcuses.
  ///
  /// In en, this message translates to:
  /// **'NO MORE EXCUSES'**
  String get noMoreExcuses;

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

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @chatAI.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chatAI;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t Have An Account Yet? '**
  String get noAccount;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @loginSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Login Successfully'**
  String get loginSuccessfully;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @registerScreen________.
  ///
  /// In en, this message translates to:
  /// **'\$\$\$ Comment \$\$\$'**
  String get registerScreen________;

  /// No description provided for @heyThere.
  ///
  /// In en, this message translates to:
  /// **'Hey There'**
  String get heyThere;

  /// No description provided for @createAnAccount.
  ///
  /// In en, this message translates to:
  /// **'create an account'**
  String get createAnAccount;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already Have an account ?'**
  String get alreadyHaveAccount;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @successfullyRegistered.
  ///
  /// In en, this message translates to:
  /// **'Registered Successfully!'**
  String get successfullyRegistered;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error!'**
  String get error;

  /// No description provided for @tellUsAboutYourself.
  ///
  /// In en, this message translates to:
  /// **'Tell us about yourself !'**
  String get tellUsAboutYourself;

  /// No description provided for @weNeedToKnowYourGender.
  ///
  /// In en, this message translates to:
  /// **'We need to know your gender'**
  String get weNeedToKnowYourGender;

  /// No description provided for @howOldAreYou.
  ///
  /// In en, this message translates to:
  /// **'How old are you ?'**
  String get howOldAreYou;

  /// No description provided for @whatIsYourWeight.
  ///
  /// In en, this message translates to:
  /// **'What is your weight ?'**
  String get whatIsYourWeight;

  /// No description provided for @thisHelpsUsCreateYourPersonalizedPlan.
  ///
  /// In en, this message translates to:
  /// **'This helps us create your personalized plan'**
  String get thisHelpsUsCreateYourPersonalizedPlan;

  /// No description provided for @whatIsYourHeight.
  ///
  /// In en, this message translates to:
  /// **'What is your height ?'**
  String get whatIsYourHeight;

  /// No description provided for @whatIsYourGoal.
  ///
  /// In en, this message translates to:
  /// **'What is your goal?'**
  String get whatIsYourGoal;

  /// No description provided for @yourPhysicalActivityLevel.
  ///
  /// In en, this message translates to:
  /// **'Your physical activity level'**
  String get yourPhysicalActivityLevel;

  /// No description provided for @activityLevel.
  ///
  /// In en, this message translates to:
  /// **'Activity Level ?'**
  String get activityLevel;

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

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @kg.
  ///
  /// In en, this message translates to:
  /// **'KG'**
  String get kg;

  /// No description provided for @cm.
  ///
  /// In en, this message translates to:
  /// **'CM'**
  String get cm;

  /// No description provided for @gainWeight.
  ///
  /// In en, this message translates to:
  /// **'Gain Weight'**
  String get gainWeight;

  /// No description provided for @loseWeight.
  ///
  /// In en, this message translates to:
  /// **'Lose Weight'**
  String get loseWeight;

  /// No description provided for @getFitter.
  ///
  /// In en, this message translates to:
  /// **'Get Fitter'**
  String get getFitter;

  /// No description provided for @gainMoreFlexible.
  ///
  /// In en, this message translates to:
  /// **'Gain More Flexible'**
  String get gainMoreFlexible;

  /// No description provided for @learnTheBasic.
  ///
  /// In en, this message translates to:
  /// **'Learn The Basic'**
  String get learnTheBasic;

  /// No description provided for @rookie.
  ///
  /// In en, this message translates to:
  /// **'Rookie'**
  String get rookie;

  /// No description provided for @beginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get beginner;

  /// No description provided for @intermediate.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get intermediate;

  /// No description provided for @advanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get advanced;

  /// No description provided for @trueBeast.
  ///
  /// In en, this message translates to:
  /// **'True Beast'**
  String get trueBeast;

  /// No description provided for @appSections___________.
  ///
  /// In en, this message translates to:
  /// **'\$\$\$ Comment \$\$\$'**
  String get appSections___________;

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore;

  /// No description provided for @aiChat.
  ///
  /// In en, this message translates to:
  /// **'AI Chat'**
  String get aiChat;

  /// No description provided for @workouts.
  ///
  /// In en, this message translates to:
  /// **'Workouts'**
  String get workouts;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @sendOtp.
  ///
  /// In en, this message translates to:
  /// **'Send OTP'**
  String get sendOtp;

  /// No description provided for @resetPassDesc.
  ///
  /// In en, this message translates to:
  /// **'Make Sure its 8 characters Or More '**
  String get resetPassDesc;

  /// No description provided for @createNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Create New Password'**
  String get createNewPassword;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @oTpCode.
  ///
  /// In en, this message translates to:
  /// **'Otp Code'**
  String get oTpCode;

  /// No description provided for @enterOtpCode.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Otp Code , check your email'**
  String get enterOtpCode;

  /// No description provided for @successEmailVerified.
  ///
  /// In en, this message translates to:
  /// **'Email Verified Successfully'**
  String get successEmailVerified;

  /// No description provided for @foodRecommendation.
  ///
  /// In en, this message translates to:
  /// **'Food Recommendation'**
  String get foodRecommendation;

  /// No description provided for @noVideoProvide.
  ///
  /// In en, this message translates to:
  /// **'Video not available'**
  String get noVideoProvide;

  /// No description provided for @noFoodRecommendation.
  ///
  /// In en, this message translates to:
  /// **'No Food Recommendation Found'**
  String get noFoodRecommendation;

  /// No description provided for @ingredients.
  ///
  /// In en, this message translates to:
  /// **'Ingredients'**
  String get ingredients;

  /// No description provided for @recommendation.
  ///
  /// In en, this message translates to:
  /// **'Recommendation'**
  String get recommendation;

  /// No description provided for @energy.
  ///
  /// In en, this message translates to:
  /// **'Energy'**
  String get energy;

  /// No description provided for @energyValue.
  ///
  /// In en, this message translates to:
  /// **'100 k'**
  String get energyValue;

  /// No description provided for @noWorkoutsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No workouts available'**
  String get noWorkoutsAvailable;

  /// No description provided for @homePage_________.
  ///
  /// In en, this message translates to:
  /// **'\$\$\$ Comment \$\$\$'**
  String get homePage_________;

  /// No description provided for @hiUser.
  ///
  /// In en, this message translates to:
  /// **'Hi {userName},\n'**
  String hiUser(Object userName);

  /// No description provided for @startYourDayMessage.
  ///
  /// In en, this message translates to:
  /// **'Let’s Start Your Day'**
  String get startYourDayMessage;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @gym.
  ///
  /// In en, this message translates to:
  /// **'Gym'**
  String get gym;

  /// No description provided for @fitness.
  ///
  /// In en, this message translates to:
  /// **'Fitness'**
  String get fitness;

  /// No description provided for @yoga.
  ///
  /// In en, this message translates to:
  /// **'Yoga'**
  String get yoga;

  /// No description provided for @aerobics.
  ///
  /// In en, this message translates to:
  /// **'Aerobics'**
  String get aerobics;

  /// No description provided for @trainer.
  ///
  /// In en, this message translates to:
  /// **'Trainer'**
  String get trainer;

  /// No description provided for @recommendationToDay.
  ///
  /// In en, this message translates to:
  /// **'Recommendation To Day'**
  String get recommendationToDay;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No Data'**
  String get noData;

  /// No description provided for @upcomingWorkouts.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Workouts'**
  String get upcomingWorkouts;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @recommendationForYou.
  ///
  /// In en, this message translates to:
  /// **'Recommendation For You'**
  String get recommendationForYou;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @areYouSureLogout.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get areYouSureLogout;

  /// No description provided for @logoutCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get logoutCancel;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get editProfile;

  /// No description provided for @updatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Updated Successfully'**
  String get updatedSuccessfully;

  /// No description provided for @yourWeight.
  ///
  /// In en, this message translates to:
  /// **'Your Weight'**
  String get yourWeight;

  /// No description provided for @tapToEdit.
  ///
  /// In en, this message translates to:
  /// **'(tap to edit)'**
  String get tapToEdit;

  /// No description provided for @yourGoal.
  ///
  /// In en, this message translates to:
  /// **'Your Goal'**
  String get yourGoal;

  /// No description provided for @yourActivityLevel.
  ///
  /// In en, this message translates to:
  /// **'Your activity level'**
  String get yourActivityLevel;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @aiChatFeature____________.
  ///
  /// In en, this message translates to:
  /// **'\$\$\$ Comment \$\$\$'**
  String get aiChatFeature____________;

  /// No description provided for @iAmYourSmartCoach.
  ///
  /// In en, this message translates to:
  /// **'I Am Your Smart Coach'**
  String get iAmYourSmartCoach;

  /// No description provided for @previousConversations.
  ///
  /// In en, this message translates to:
  /// **'Previous Conversations'**
  String get previousConversations;

  /// No description provided for @howCanIAssistYouToday.
  ///
  /// In en, this message translates to:
  /// **'How Can I Assist You\nToday ?'**
  String get howCanIAssistYouToday;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @smartCoach.
  ///
  /// In en, this message translates to:
  /// **'Smart Coach'**
  String get smartCoach;

  /// No description provided for @untitledChat.
  ///
  /// In en, this message translates to:
  /// **'Untitled Chat'**
  String get untitledChat;

  /// No description provided for @messageGemini.
  ///
  /// In en, this message translates to:
  /// **'Message Gemini'**
  String get messageGemini;

  /// No description provided for @tellingGeminiToBeSmartFitnessCoach.
  ///
  /// In en, this message translates to:
  /// **'You are a smart fitness coach. Help the user with gym workouts, nutrition, and motivation.'**
  String get tellingGeminiToBeSmartFitnessCoach;

  /// No description provided for @tellingGeminiToWelcomeUser.
  ///
  /// In en, this message translates to:
  /// **'Welcome user briefly Just a few sentences. For every response, keep the answer simple, clear, and concise—no long explanations'**
  String get tellingGeminiToWelcomeUser;

  /// No description provided for @tellingGeminiToWelcomeUserWithInfo.
  ///
  /// In en, this message translates to:
  /// **'Welcome user briefly by his name. Just a few sentences. The user info is as follows: {userInfo} (ignore Unknown info if exists). Just keep this info if user asks a question related to them. For every response, keep the answer simple, clear, and concise—no long explanations.'**
  String tellingGeminiToWelcomeUserWithInfo(Object userInfo);

  /// No description provided for @tellingGeminiToGiveChatTitle.
  ///
  /// In en, this message translates to:
  /// **'Give a short, 10-20 characters (not more) title for this message: {firstMessage}, don\'t give me options just choose the best one.'**
  String tellingGeminiToGiveChatTitle(Object firstMessage);

  /// No description provided for @conversationIsCloseToLimit.
  ///
  /// In en, this message translates to:
  /// **'Conversation is about to reach its limit ⚠️'**
  String get conversationIsCloseToLimit;

  /// No description provided for @conversationEnded.
  ///
  /// In en, this message translates to:
  /// **'Conversation Ended ❌'**
  String get conversationEnded;

  /// No description provided for @exercises________.
  ///
  /// In en, this message translates to:
  /// **'\$\$\$ comment \$\$\$'**
  String get exercises________;

  /// No description provided for @noVideoProvided.
  ///
  /// In en, this message translates to:
  /// **'No video Provided'**
  String get noVideoProvided;
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
