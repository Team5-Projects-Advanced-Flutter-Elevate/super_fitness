abstract class Activities {
  List<String> activities = [
    "Rookie",
    "Beginner",
    "Intermediate",
    "Advanced",
    "True Beast",
  ];

  static String getActivityLevel(String activity) {
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
