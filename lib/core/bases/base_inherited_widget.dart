import 'package:flutter/material.dart';
import 'package:super_fitness/shared_layers/localization/generated/app_localizations.dart';
import 'package:super_fitness/shared_layers/localization/l10n_manager/localization_manager.dart';

import '../validation/validation_functions.dart';

class BaseInheritedWidget extends InheritedWidget {
  final ThemeData theme;
  final double screenWidth, screenHeight;
  final AppLocalizations appLocalizations;
  final LocalizationManager localizationManager;
  final ValidateFunctions validateFunctions;

  const BaseInheritedWidget({
    super.key,
    required this.theme,
    required this.screenWidth,
    required this.screenHeight,
    required this.appLocalizations,
    required this.localizationManager,
    required this.validateFunctions,
    required super.child,
  });

  static BaseInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BaseInheritedWidget>()
        as BaseInheritedWidget;
  }

  @override
  bool updateShouldNotify(BaseInheritedWidget oldWidget) {
    return oldWidget.theme != theme ||
        oldWidget.screenWidth != screenWidth ||
        oldWidget.screenHeight != screenHeight ||
        oldWidget.appLocalizations != appLocalizations ||
        oldWidget.localizationManager != localizationManager ||
        oldWidget.validateFunctions != validateFunctions;
  }
}
