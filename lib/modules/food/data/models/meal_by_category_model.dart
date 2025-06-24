import '../../domain/entities/meal_entity.dart';

class MealByCategoryModel {
  List<Meals>? meals;

  MealByCategoryModel({this.meals});

  MealByCategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['meals'] != null) {
      meals = <Meals>[];
      json['meals'].forEach((v) {
        meals!.add(Meals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (meals != null) {
      data['meals'] = meals!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  // Convert entire model to list of entities
  List<MealEntity> toEntity() {
    if (meals == null) return [];
    return meals!.map((meal) => meal.toEntity()).toList();
  }
}

class Meals {
  String? strMeal;
  String? strMealThumb;
  String? idMeal;

  Meals({this.strMeal, this.strMealThumb, this.idMeal});

  Meals.fromJson(Map<String, dynamic> json) {
    strMeal = json['strMeal'];
    strMealThumb = json['strMealThumb'];
    idMeal = json['idMeal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['strMeal'] = strMeal;
    data['strMealThumb'] = strMealThumb;
    data['idMeal'] = idMeal;
    return data;
  }

  // Convert single meal to entity
  MealEntity toEntity() {
    return MealEntity(
      id: idMeal ?? '',
      name: strMeal ?? '',
      thumbnailUrl: strMealThumb ?? '',
    );
  }
}
