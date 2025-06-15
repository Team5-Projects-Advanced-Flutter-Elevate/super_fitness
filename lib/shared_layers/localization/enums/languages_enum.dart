enum LanguagesEnum { en, ar }

extension LanguagesEnumExtension on LanguagesEnum {
  String getLanguageCode() {
    var result = toString().split(".").toList()[1];
    return result;
  }

  String getLanguageName() {
    switch (this) {
      case LanguagesEnum.en:
        return "English";
      case LanguagesEnum.ar:
        return "العربية";
    }
  }
}
