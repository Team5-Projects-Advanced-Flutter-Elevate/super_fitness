import 'package:super_fitness/shared_layers/localization/generated/app_localizations.dart';

abstract class Goals {
  static String getGoal({
    required String chosenGoal,
    required AppLocalizations appLocalizations,
  }) {
    if (chosenGoal == appLocalizations.gainWeight) {
      return "Gain Weight";
    } else if (chosenGoal == appLocalizations.loseWeight) {
      return "Lose Weight";
    } else if (chosenGoal == appLocalizations.getFitter) {
      return "Get Fitter";
    } else if (chosenGoal == appLocalizations.gainMoreFlexible) {
      return "Gain More Flexible";
    } else if (chosenGoal == appLocalizations.learnTheBasic) {
      return "Learn The Basic";
    } else {
      return "Invalid Goal";
    }
  }
}
