// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodDetailsModel _$FoodDetailsModelFromJson(Map<String, dynamic> json) =>
    FoodDetailsModel(
      meal:
          (json['meals'] as List<dynamic>?)
              ?.map((e) => Meal.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$FoodDetailsModelToJson(FoodDetailsModel instance) =>
    <String, dynamic>{'meals': instance.meal};

Meal _$MealFromJson(Map<String, dynamic> json) => Meal(
  idMeal: json['idMeal'] as String?,
  strMeal: json['strMeal'] as String?,
  strMealAlternate: json['strMealAlternate'],
  strCategory: json['strCategory'] as String?,
  strArea: json['strArea'] as String?,
  strInstructions: json['strInstructions'] as String?,
  strMealThumb: json['strMealThumb'] as String?,
  strTags: json['strTags'] as String?,
  strYoutube: json['strYoutube'] as String?,
  strIngredient1: json['strIngredient1'] as String?,
  strIngredient2: json['strIngredient2'] as String?,
  strIngredient3: json['strIngredient3'] as String?,
  strIngredient4: json['strIngredient4'] as String?,
  strIngredient5: json['strIngredient5'] as String?,
  strIngredient6: json['strIngredient6'] as String?,
  strIngredient7: json['strIngredient7'] as String?,
  strIngredient8: json['strIngredient8'] as String?,
  strIngredient9: json['strIngredient9'] as String?,
  strIngredient10: json['strIngredient10'] as String?,
  strMeasure1: json['strMeasure1'] as String?,
  strMeasure2: json['strMeasure2'] as String?,
  strMeasure3: json['strMeasure3'] as String?,
  strMeasure4: json['strMeasure4'] as String?,
  strMeasure5: json['strMeasure5'] as String?,
  strMeasure6: json['strMeasure6'] as String?,
  strMeasure7: json['strMeasure7'] as String?,
  strMeasure8: json['strMeasure8'] as String?,
  strMeasure9: json['strMeasure9'] as String?,
  strMeasure10: json['strMeasure10'] as String?,
  strSource: json['strSource'] as String?,
  strImageSource: json['strImageSource'],
  strCreativeCommonsConfirmed: json['strCreativeCommonsConfirmed'],
  dateModified: json['dateModified'],
);

Map<String, dynamic> _$MealToJson(Meal instance) => <String, dynamic>{
  'idMeal': instance.idMeal,
  'strMeal': instance.strMeal,
  'strMealAlternate': instance.strMealAlternate,
  'strCategory': instance.strCategory,
  'strArea': instance.strArea,
  'strInstructions': instance.strInstructions,
  'strMealThumb': instance.strMealThumb,
  'strTags': instance.strTags,
  'strYoutube': instance.strYoutube,
  'strIngredient1': instance.strIngredient1,
  'strIngredient2': instance.strIngredient2,
  'strIngredient3': instance.strIngredient3,
  'strIngredient4': instance.strIngredient4,
  'strIngredient5': instance.strIngredient5,
  'strIngredient6': instance.strIngredient6,
  'strIngredient7': instance.strIngredient7,
  'strIngredient8': instance.strIngredient8,
  'strIngredient9': instance.strIngredient9,
  'strIngredient10': instance.strIngredient10,
  'strMeasure1': instance.strMeasure1,
  'strMeasure2': instance.strMeasure2,
  'strMeasure3': instance.strMeasure3,
  'strMeasure4': instance.strMeasure4,
  'strMeasure5': instance.strMeasure5,
  'strMeasure6': instance.strMeasure6,
  'strMeasure7': instance.strMeasure7,
  'strMeasure8': instance.strMeasure8,
  'strMeasure9': instance.strMeasure9,
  'strMeasure10': instance.strMeasure10,
  'strSource': instance.strSource,
  'strImageSource': instance.strImageSource,
  'strCreativeCommonsConfirmed': instance.strCreativeCommonsConfirmed,
  'dateModified': instance.dateModified,
};
