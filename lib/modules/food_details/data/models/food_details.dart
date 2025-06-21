import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness/modules/food_details/domain/entities/food_details_entity.dart';

part 'food_details.g.dart';

@JsonSerializable()
class FoodDetailsModel {
  @JsonKey(name: "meals")
  final List<Meal>? meal;

  FoodDetailsModel({this.meal});

  factory FoodDetailsModel.fromJson(Map<String, dynamic> json) {
    return _$FoodDetailsModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$FoodDetailsModelToJson(this);
  }

  FoodDetailsEntity toEntity() =>
      FoodDetailsEntity(mealEntity: meal?.first.toEntity());
}

@JsonSerializable()
class Meal {
  @JsonKey(name: "idMeal")
  final String? idMeal;
  @JsonKey(name: "strMeal")
  final String? strMeal;
  @JsonKey(name: "strMealAlternate")
  final dynamic strMealAlternate;
  @JsonKey(name: "strCategory")
  final String? strCategory;
  @JsonKey(name: "strArea")
  final String? strArea;
  @JsonKey(name: "strInstructions")
  final String? strInstructions;
  @JsonKey(name: "strMealThumb")
  final String? strMealThumb;
  @JsonKey(name: "strTags")
  final String? strTags;
  @JsonKey(name: "strYoutube")
  final String? strYoutube;
  @JsonKey(name: "strIngredient1")
  final String? strIngredient1;
  @JsonKey(name: "strIngredient2")
  final String? strIngredient2;
  @JsonKey(name: "strIngredient3")
  final String? strIngredient3;
  @JsonKey(name: "strIngredient4")
  final String? strIngredient4;
  @JsonKey(name: "strIngredient5")
  final String? strIngredient5;
  @JsonKey(name: "strIngredient6")
  final String? strIngredient6;
  @JsonKey(name: "strIngredient7")
  final String? strIngredient7;
  @JsonKey(name: "strIngredient8")
  final String? strIngredient8;
  @JsonKey(name: "strIngredient9")
  final String? strIngredient9;
  @JsonKey(name: "strIngredient10")
  final String? strIngredient10;

  @JsonKey(name: "strMeasure1")
  final String? strMeasure1;
  @JsonKey(name: "strMeasure2")
  final String? strMeasure2;
  @JsonKey(name: "strMeasure3")
  final String? strMeasure3;
  @JsonKey(name: "strMeasure4")
  final String? strMeasure4;
  @JsonKey(name: "strMeasure5")
  final String? strMeasure5;
  @JsonKey(name: "strMeasure6")
  final String? strMeasure6;
  @JsonKey(name: "strMeasure7")
  final String? strMeasure7;
  @JsonKey(name: "strMeasure8")
  final String? strMeasure8;
  @JsonKey(name: "strMeasure9")
  final String? strMeasure9;
  @JsonKey(name: "strMeasure10")
  final String? strMeasure10;

  @JsonKey(name: "strSource")
  final String? strSource;
  @JsonKey(name: "strImageSource")
  final dynamic strImageSource;
  @JsonKey(name: "strCreativeCommonsConfirmed")
  final dynamic strCreativeCommonsConfirmed;
  @JsonKey(name: "dateModified")
  final dynamic dateModified;

  Meal({
    this.idMeal,
    this.strMeal,
    this.strMealAlternate,
    this.strCategory,
    this.strArea,
    this.strInstructions,
    this.strMealThumb,
    this.strTags,
    this.strYoutube,
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
    this.strSource,
    this.strImageSource,
    this.strCreativeCommonsConfirmed,
    this.dateModified,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return _$MealFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MealToJson(this);
  }

  MealEntity toEntity() => MealEntity(
    idMeal: idMeal,
    strMeal: strMeal,
    strMealAlternate: strMealAlternate,
    strCategory: strCategory,
    strArea: strArea,
    strInstructions: strInstructions,
    strMealThumb: strMealThumb,
    strTags: strTags,
    strYoutube: strYoutube,
    strIngredient1: strIngredient1,
    strIngredient2: strIngredient2,
    strIngredient3: strIngredient3,
    strIngredient4: strIngredient4,
    strIngredient5: strIngredient5,
    strIngredient6: strIngredient6,
    strIngredient7: strIngredient7,
    strIngredient8: strIngredient8,
    strIngredient9: strIngredient9,
    strIngredient10: strIngredient10,
    strMeasure1: strMeasure1,
    strMeasure2: strMeasure2,
    strMeasure3: strMeasure3,
    strMeasure4: strMeasure4,
    strMeasure5: strMeasure5,
    strMeasure6: strMeasure6,
    strMeasure7: strMeasure7,
    strMeasure8: strMeasure8,
    strMeasure9: strMeasure9,
    strMeasure10: strMeasure10,
    strSource: strSource,
    strImageSource: strImageSource,
    strCreativeCommonsConfirmed: strCreativeCommonsConfirmed,
    dateModified: dateModified,
  );
}
