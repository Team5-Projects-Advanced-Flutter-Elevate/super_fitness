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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
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

  /// No description provided for @onboardingScreen____________.
  ///
  /// In en, this message translates to:
  /// **'\$\$\$ Comment \$\$\$'**
  String get onboardingScreen____________;

  /// No description provided for @onboardingWelcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome to\nFlowery Rider app'**
  String get onboardingWelcomeMessage;

  /// No description provided for @applyNow.
  ///
  /// In en, this message translates to:
  /// **'Apply Now'**
  String get applyNow;

  /// No description provided for @pleaseEnterValidRecipient.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid recipient'**
  String get pleaseEnterValidRecipient;

  /// No description provided for @loginScreen___________.
  ///
  /// In en, this message translates to:
  /// **'\$\$ Comment \$\$'**
  String get loginScreen___________;

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

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget password?'**
  String get forgetPassword;

  /// No description provided for @continueWord.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueWord;

  /// No description provided for @loggedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Logged In Successfully!'**
  String get loggedSuccessfully;

  /// No description provided for @applyScreen____________.
  ///
  /// In en, this message translates to:
  /// **'\$\$ Comment \$\$'**
  String get applyScreen____________;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @imagePickedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Image picked successfully'**
  String get imagePickedSuccess;

  /// No description provided for @imagePickFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to pick image'**
  String get imagePickFailed;

  /// No description provided for @removedIdImage.
  ///
  /// In en, this message translates to:
  /// **'Removed ID image'**
  String get removedIdImage;

  /// No description provided for @removedLicenseImage.
  ///
  /// In en, this message translates to:
  /// **'Removed license image'**
  String get removedLicenseImage;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome !!'**
  String get welcome;

  /// No description provided for @joinQuestion.
  ///
  /// In en, this message translates to:
  /// **'You want to be a delivery man?'**
  String get joinQuestion;

  /// No description provided for @joinOurTeam.
  ///
  /// In en, this message translates to:
  /// **'Join our team'**
  String get joinOurTeam;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First legal name'**
  String get firstName;

  /// No description provided for @firstNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your first legal name'**
  String get firstNameHint;

  /// No description provided for @secondName.
  ///
  /// In en, this message translates to:
  /// **'Second legal name'**
  String get secondName;

  /// No description provided for @secondNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your second legal name'**
  String get secondNameHint;

  /// No description provided for @vehicleType.
  ///
  /// In en, this message translates to:
  /// **'Vehicle type'**
  String get vehicleType;

  /// No description provided for @vehicleNumberPrompt.
  ///
  /// In en, this message translates to:
  /// **'Please enter vehicle number'**
  String get vehicleNumberPrompt;

  /// No description provided for @vehicleNumber.
  ///
  /// In en, this message translates to:
  /// **'Vehicle number'**
  String get vehicleNumber;

  /// No description provided for @vehicleNumberHint.
  ///
  /// In en, this message translates to:
  /// **'Enter vehicle number'**
  String get vehicleNumberHint;

  /// No description provided for @vehicleLicensePrompt.
  ///
  /// In en, this message translates to:
  /// **'Please upload vehicle license'**
  String get vehicleLicensePrompt;

  /// No description provided for @vehicleLicense.
  ///
  /// In en, this message translates to:
  /// **'Vehicle license'**
  String get vehicleLicense;

  /// No description provided for @vehicleLicenseHint.
  ///
  /// In en, this message translates to:
  /// **'Upload license photo'**
  String get vehicleLicenseHint;

  /// No description provided for @idNumberPrompt.
  ///
  /// In en, this message translates to:
  /// **'Please enter ID number'**
  String get idNumberPrompt;

  /// No description provided for @idNumberLength.
  ///
  /// In en, this message translates to:
  /// **'ID number must be 14 characters'**
  String get idNumberLength;

  /// No description provided for @idNumber.
  ///
  /// In en, this message translates to:
  /// **'ID number'**
  String get idNumber;

  /// No description provided for @idNumberHint.
  ///
  /// In en, this message translates to:
  /// **'Enter national ID number'**
  String get idNumberHint;

  /// No description provided for @idImagePrompt.
  ///
  /// In en, this message translates to:
  /// **'Please upload ID image'**
  String get idImagePrompt;

  /// No description provided for @idImage.
  ///
  /// In en, this message translates to:
  /// **'ID image'**
  String get idImage;

  /// No description provided for @idImageHint.
  ///
  /// In en, this message translates to:
  /// **'Upload ID image'**
  String get idImageHint;

  /// No description provided for @selectGender.
  ///
  /// In en, this message translates to:
  /// **'Please select gender'**
  String get selectGender;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get emailHint;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @phoneNumberHint.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get phoneNumberHint;

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

  /// No description provided for @thankYou.
  ///
  /// In en, this message translates to:
  /// **'Thank You!!'**
  String get thankYou;

  /// No description provided for @applicationSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Your application has been submitted!'**
  String get applicationSubmitted;

  /// No description provided for @thanksForProvidingApplication.
  ///
  /// In en, this message translates to:
  /// **'Thank you for providing your application, we will review your application and will get back to you soon.'**
  String get thanksForProvidingApplication;

  /// No description provided for @successScreenDescription.
  ///
  /// In en, this message translates to:
  /// **'The order delivered successfully'**
  String get successScreenDescription;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @floweryRider.
  ///
  /// In en, this message translates to:
  /// **'Flowery rider'**
  String get floweryRider;

  /// No description provided for @readyForDelivery.
  ///
  /// In en, this message translates to:
  /// **'Ready for delivery'**
  String get readyForDelivery;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @noOrdersFound.
  ///
  /// In en, this message translates to:
  /// **'No orders found'**
  String get noOrdersFound;

  /// No description provided for @unKnownProduct.
  ///
  /// In en, this message translates to:
  /// **'Unknown Product'**
  String get unKnownProduct;

  /// No description provided for @unKnownAddress.
  ///
  /// In en, this message translates to:
  /// **'Unknown Address'**
  String get unKnownAddress;

  /// No description provided for @unKnownStore.
  ///
  /// In en, this message translates to:
  /// **'Unknown Store'**
  String get unKnownStore;

  /// No description provided for @unKnown.
  ///
  /// In en, this message translates to:
  /// **'UnKnown'**
  String get unKnown;

  /// No description provided for @eGP.
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get eGP;

  /// No description provided for @pickUpAddress.
  ///
  /// In en, this message translates to:
  /// **'Pickup address'**
  String get pickUpAddress;

  /// No description provided for @userAddress.
  ///
  /// In en, this message translates to:
  /// **'User address'**
  String get userAddress;

  /// No description provided for @orderDetailsScreen_________.
  ///
  /// In en, this message translates to:
  /// **'\$\$ Comment \$\$\$'**
  String get orderDetailsScreen_________;

  /// No description provided for @orderDetails.
  ///
  /// In en, this message translates to:
  /// **'Order Details'**
  String get orderDetails;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @accepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get accepted;

  /// No description provided for @orderId.
  ///
  /// In en, this message translates to:
  /// **'Order ID'**
  String get orderId;

  /// No description provided for @pickupAddress.
  ///
  /// In en, this message translates to:
  /// **'Pickup address'**
  String get pickupAddress;

  /// No description provided for @floweryStore.
  ///
  /// In en, this message translates to:
  /// **'Flowery store'**
  String get floweryStore;

  /// No description provided for @egp.
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get egp;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment method'**
  String get paymentMethod;

  /// No description provided for @cashOnDelivery.
  ///
  /// In en, this message translates to:
  /// **'Cash on delivery'**
  String get cashOnDelivery;

  /// No description provided for @arrivedAtPickupPoint.
  ///
  /// In en, this message translates to:
  /// **'Arrived at Pickup point'**
  String get arrivedAtPickupPoint;

  /// No description provided for @orderStatusAccepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get orderStatusAccepted;

  /// No description provided for @orderStatusPicked.
  ///
  /// In en, this message translates to:
  /// **'Picked'**
  String get orderStatusPicked;

  /// No description provided for @orderStatusOutForDelivery.
  ///
  /// In en, this message translates to:
  /// **'Out for delivery'**
  String get orderStatusOutForDelivery;

  /// No description provided for @orderStatusArrived.
  ///
  /// In en, this message translates to:
  /// **'Arrived'**
  String get orderStatusArrived;

  /// No description provided for @orderStatusDelivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get orderStatusDelivered;

  /// No description provided for @buttonArrivedAtPickup.
  ///
  /// In en, this message translates to:
  /// **'Arrived at pickup point'**
  String get buttonArrivedAtPickup;

  /// No description provided for @buttonStartDelivery.
  ///
  /// In en, this message translates to:
  /// **'Start delivery'**
  String get buttonStartDelivery;

  /// No description provided for @buttonArrivedDestination.
  ///
  /// In en, this message translates to:
  /// **'Arrived to destination'**
  String get buttonArrivedDestination;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @vehicleInfo.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Info'**
  String get vehicleInfo;

  /// No description provided for @buttonOrderDelivered.
  ///
  /// In en, this message translates to:
  /// **'Order delivered'**
  String get buttonOrderDelivered;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading.....'**
  String get loading;

  /// No description provided for @acceptedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Accepted Successfully!'**
  String get acceptedSuccessfully;

  /// No description provided for @updatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Updated Successfully!'**
  String get updatedSuccessfully;

  /// No description provided for @myOrders.
  ///
  /// In en, this message translates to:
  /// **'My orders'**
  String get myOrders;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @logoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutTitle;

  /// No description provided for @logoutMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutMessage;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @confirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmButton;

  /// No description provided for @orderFinishedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Order Finished Successfully!'**
  String get orderFinishedSuccessfully;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get editProfile;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @pickUpLocation________.
  ///
  /// In en, this message translates to:
  /// **'\$\$\$ Comment \$\$\$'**
  String get pickUpLocation________;

  /// No description provided for @errorLoadingTheMap.
  ///
  /// In en, this message translates to:
  /// **'Error Occurred While Loading The Map'**
  String get errorLoadingTheMap;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @flowery.
  ///
  /// In en, this message translates to:
  /// **'Flowery'**
  String get flowery;

  /// No description provided for @yourLocation.
  ///
  /// In en, this message translates to:
  /// **'Your Location'**
  String get yourLocation;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
