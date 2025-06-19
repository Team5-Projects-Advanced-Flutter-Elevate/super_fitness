import 'package:super_fitness/shared_layers/localization/enums/languages_enum.dart';

abstract class Activities {
  List<String> activities = [
    "Rookie",
    "Beginner",
    "Intermediate",
    "Advanced",
    "True Beast",
  ];

  static String getActivityLevel({
    required String activity,
    required String currentLocale,
  }) {
    if (currentLocale == LanguagesEnum.en.getLanguageCode()) {
      return getActivityLevelEnLocale(activity);
    } else {
      return getActivityLevelArLocale(activity);
    }
  }

  static String getActivityLevelEnLocale(String activity) {
    switch (activity) {
      case "Rookie":
        return "level1";
      case "Beginner":
        return "level2";
      case "Intermediate":
        return "level3";
      case "Advanced":
        return "level4";
      case "True Beast":
        return "level5";
      default:
        return "Invalid Activity";
    }
  }

  static String getActivityLevelArLocale(String activity) {
    switch (activity) {
      case "Rookie":
        return "level1";
      case "Beginner":
        return "level2";
      case "Intermediate":
        return "level3";
      case "Advanced":
        return "level4";
      case "True Beast":
        return "level5";
      default:
        return "Invalid Activity";
    }
  }
}
