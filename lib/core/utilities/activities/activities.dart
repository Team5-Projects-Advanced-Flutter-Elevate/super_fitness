import 'package:super_fitness/shared_layers/localization/generated/app_localizations.dart';

abstract class Activities {
  static String getActivityLevel({
    required String activity,
    required AppLocalizations appLocalizations,
  }) {
    if (activity == appLocalizations.rookie) {
      return "level1";
    } else if (activity == appLocalizations.beginner) {
      return "level2";
    } else if (activity == appLocalizations.intermediate) {
      return "level3";
    } else if (activity == appLocalizations.advanced) {
      return "level4";
    } else if (activity == appLocalizations.trueBeast) {
      return "level5";
    } else {
      return "Invalid Activity";
    }
  }
}
