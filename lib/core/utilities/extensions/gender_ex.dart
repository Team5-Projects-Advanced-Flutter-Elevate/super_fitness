enum Gender { male, female }

extension GenderExtension on Gender {
  String getValue() {
    switch (this) {
      case Gender.male:
        return 'male';
      case Gender.female:
        return 'female';
    }
  }
}
