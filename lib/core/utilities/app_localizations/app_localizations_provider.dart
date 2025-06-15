import 'dart:ui';

import 'package:injectable/injectable.dart';
import 'package:super_fitness/shared_layers/localization/constants/l10n_constants.dart';
import 'package:super_fitness/shared_layers/localization/generated/app_localizations.dart';

@module
abstract class AppLocalizationsProvider {
  @preResolve
  Future<AppLocalizations> provideAppLocalizations(
    @Named(L10nConstants.initCurrentLocal) String languageCode,
  ) {
    return AppLocalizations.delegate.load(Locale(languageCode));
  }
}
