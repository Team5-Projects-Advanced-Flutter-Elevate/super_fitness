import 'package:injectable/injectable.dart';
import 'package:super_fitness/shared_layers/localization/generated/app_localizations.dart';

@lazySingleton
class ValidateFunctions {
  AppLocalizations _appLocalizations;

  set appLocalizations(AppLocalizations appLocalizations) {
    _appLocalizations = appLocalizations;
  }

  ValidateFunctions(this._appLocalizations);

  String? validationOfFullName(String? inputText) {
    if (inputText?.trim().isEmpty == true || inputText == null) {
      return _appLocalizations.pleaseEnterName;
    }
    return null;
  }

  String? validationOfUserName(String? inputText) {
    if (inputText?.trim().isEmpty == true || inputText == null) {
      return _appLocalizations.pleaseEnterUserName;
    }
    if (inputText.length < 3 || inputText.length > 16) {
      return _appLocalizations.userNameLength;
    }

    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(inputText)) {
      return _appLocalizations.userNameRules;
    }
    return null;
  }

  String? validationOfFirstOrLastName(
    String? inputText, {
    bool isFirstName = true,
  }) {
    RegExp nameRegExp = RegExp(r'^[A-Za-z]+$');

    if (inputText?.trim().isEmpty == true || inputText == null) {
      return isFirstName
          ? _appLocalizations.pleaseEnterFirstName
          : _appLocalizations.pleaseEnterLastName;
    }
    if (inputText.trim().length < 3) {
      return _appLocalizations.namesLengthRule;
    }
    if (!nameRegExp.hasMatch(inputText)) {
      return _appLocalizations.namesRules;
    }
    return null;
  }

  String? validationOfAddress(String? inputText) {
    final RegExp addressRegex = RegExp(r"^[\p{L}\d\s,.\-\/#]+$", unicode: true);

    if (inputText == null || inputText.trim().isEmpty) {
      return _appLocalizations.pleaseEnterAddress;
    }

    if (!addressRegex.hasMatch(inputText.trim())) {
      return _appLocalizations.pleaseEnterValidAddress;
    }

    return null;
  }

  String? validationOfRecipient(String? inputText) {
    final RegExp addressRegex = RegExp(r"^[\p{L}\d\s,.\-\/#]+$", unicode: true);

    if (inputText == null || inputText.trim().isEmpty) {
      return _appLocalizations.pleaseEnterValidRecipient;
    }

    if (!addressRegex.hasMatch(inputText.trim())) {
      return _appLocalizations.pleaseEnterValidRecipient;
    }

    return null;
  }

  String? validationOfEmail(String? inputText) {
    RegExp gmailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (inputText?.trim().isEmpty == true || inputText == null) {
      return _appLocalizations.pleaseEnterEmail;
    }
    if (!gmailRegExp.hasMatch(inputText)) {
      return _appLocalizations.pleaseEnterValidEmail;
    }
    return null;
  }

  String? validationOfPhoneNumber(String? inputText) {
    RegExp phoneNumber = RegExp(r'^(\+2)?(010|011|012|015)[0-9]{8}$');
    if (inputText?.trim().isEmpty == true || inputText == null) {
      return _appLocalizations.pleaseEnterPhoneNumber;
    } else if (!phoneNumber.hasMatch(inputText)) {
      return _appLocalizations.phoneNumberRules;
    }
    return null;
  }

  String? validationOfPassword(String? inputText) {
    // RegExp passValid = RegExp(
    //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@\$%^&*-]).{8,}\$');
    if (inputText?.trim().isEmpty == true || inputText == null) {
      return _appLocalizations.pleaseEnterPassword;
    } else if (inputText.length < 8) {
      return _appLocalizations.passwordLength;
    } else if (!RegExp(r'(?=.*?[A-Z])').hasMatch(inputText)) {
      return _appLocalizations.uppercaseRulePassword;
    } else if (!RegExp(r'(?=.*?[a-z])').hasMatch(inputText)) {
      return _appLocalizations.lowercaseRulePassword;
    } else if (!RegExp(r'(?=.*?[0-9])').hasMatch(inputText)) {
      return _appLocalizations.digitRulePassword;
    } else if (!RegExp(r'(?=.*?[#?!@$%^&*-])').hasMatch(inputText)) {
      return _appLocalizations.specialCharactersRulePassword;
    }
    return null;
  }

  String? validationOfConfirmPassword(
    String? inputText,
    String passwordToMatchWith,
  ) {
    if (inputText?.trim().isEmpty == true || inputText == null) {
      return _appLocalizations.pleaseConfirmPassword;
    } else if (inputText != passwordToMatchWith) {
      return _appLocalizations.noMatch;
    }
    return null;
  }
}
