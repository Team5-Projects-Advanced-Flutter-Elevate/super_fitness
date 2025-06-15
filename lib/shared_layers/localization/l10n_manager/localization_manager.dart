import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_error/api_error_handler.dart';
import 'package:super_fitness/core/di/injectable_initializer.dart';
import 'package:super_fitness/core/validation/validation_functions.dart';
import 'package:super_fitness/shared_layers/localization/enums/languages_enum.dart';

import '../../storage/constants/storage_constants.dart';
import '../../storage/contracts/flutter_secure_storage_service_contract.dart';
import '../constants/l10n_constants.dart';
import '../generated/app_localizations.dart';

@singleton
class LocalizationManager extends ChangeNotifier {
  String currentLocale;
  final SecureStorageService _secureStorage;

  LocalizationManager(
    this._secureStorage,
    @Named(L10nConstants.initCurrentLocal) this.currentLocale,
  );

  Future<void> changeLocal(String languageCode) async {
    currentLocale = languageCode;
    var appLocalization = await AppLocalizations.delegate.load(
      Locale(languageCode),
    );
    if (getIt.isRegistered<AppLocalizations>()) {
      await getIt.unregister<AppLocalizations>();
    }
    getIt.registerSingleton<AppLocalizations>(appLocalization);
    getIt.get<ValidateFunctions>().appLocalizations =
        getIt.get<AppLocalizations>();
    getIt.get<ApiErrorHandler>().appLocalizations =
        getIt.get<AppLocalizations>();
    _saveLocal(languageCode);
    notifyListeners();
  }

  void _saveLocal(String languageCode) {
    _secureStorage.setStringValue(StorageConstants.localeKey, languageCode);
  }

  Future<String?> getSavedLocal() async {
    var savedLocale = await _secureStorage.getStringValue(
      StorageConstants.localeKey,
    );
    return savedLocale;
  }

  bool get isEnglish => currentLocale == LanguagesEnum.en.getLanguageCode();
}
