class FoodDetailsEntity {
  final MealEntity? mealEntity;

  FoodDetailsEntity({this.mealEntity});
}

class MealEntity {
  final String? idMeal;
  final String? strMeal;
  final dynamic strMealAlternate;
  final String? strCategory;
  final String? strArea;
  final String? strInstructions;
  final String? strMealThumb;
  final String? strTags;
  final String? strYoutube;
  final String? strSource;
  final dynamic strImageSource;
  final dynamic strCreativeCommonsConfirmed;
  final dynamic dateModified;
  final String? strIngredient1;
  final String? strIngredient2;
  final String? strIngredient3;
  final String? strIngredient4;
  final String? strIngredient5;
  final String? strIngredient6;
  final String? strIngredient7;
  final String? strIngredient8;
  final String? strIngredient9;
  final String? strIngredient10;
  final String? strMeasure1;
  final String? strMeasure2;
  final String? strMeasure3;
  final String? strMeasure4;
  final String? strMeasure5;
  final String? strMeasure6;
  final String? strMeasure7;
  final String? strMeasure8;
  final String? strMeasure9;
  final String? strMeasure10;

  MealEntity({
    this.idMeal,
    this.strMeal,
    this.strMealAlternate,
    this.strCategory,
    this.strArea,
    this.strInstructions,
    this.strMealThumb,
    this.strTags,
    this.strYoutube,
    this.strSource,
    this.strImageSource,
    this.strCreativeCommonsConfirmed,
    this.dateModified,
    this.strIngredient1,
    this.strIngredient2,
    this.strIngredient3,
    this.strIngredient4,
    this.strIngredient5,
    this.strIngredient6,
    this.strIngredient7,
    this.strIngredient8,
    this.strIngredient9,
    this.strIngredient10,
    this.strMeasure1,
    this.strMeasure2,
    this.strMeasure3,
    this.strMeasure4,
    this.strMeasure5,
    this.strMeasure6,
    this.strMeasure7,
    this.strMeasure8,
    this.strMeasure9,
    this.strMeasure10,
  });

  Map<String, dynamic> toJson() {
    return {
      "idMeal": idMeal,
      "strMeal": strMeal,
      "strMealAlternate": strMealAlternate,
      "strCategory": strCategory,
      "strArea": strArea,
      "strInstructions": strInstructions,
      "strMealThumb": strMealThumb,
      "strTags": strTags,
      "strYoutube": strYoutube,
      "strSource": strSource,
      "strImageSource": strImageSource,
      "strCreativeCommonsConfirmed": strCreativeCommonsConfirmed,
      "dateModified": dateModified,
      "strIngredient1": strIngredient1,
      "strIngredient2": strIngredient2,
      "strIngredient3": strIngredient3,
      "strIngredient4": strIngredient4,
      "strIngredient5": strIngredient5,
      "strIngredient6": strIngredient6,
      "strIngredient7": strIngredient7,
      "strIngredient8": strIngredient8,
      "strIngredient9": strIngredient9,
      "strIngredient10": strIngredient10,
      "strMeasure1": strMeasure1,
      "strMeasure2": strMeasure2,
      "strMeasure3": strMeasure3,
      "strMeasure4": strMeasure4,
      "strMeasure5": strMeasure5,
      "strMeasure6": strMeasure6,
      "strMeasure7": strMeasure7,
      "strMeasure8": strMeasure8,
      "strMeasure9": strMeasure9,
      "strMeasure10": strMeasure10,
    };
  }
}
