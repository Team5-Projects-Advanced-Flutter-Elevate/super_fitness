import 'package:equatable/equatable.dart';
import 'package:super_fitness/modules/food/domain/entities/meal_entity.dart';

import '../../domain/entities/food_categories_entity.dart';

enum LoadFoodCategoriesState { initial, loading, success, error }

enum FilterFoodState { initial, loading, success, error }

class FoodState extends Equatable {
  final LoadFoodCategoriesState loadFoodCategoriesState;
  final FilterFoodState filterFoodState;
  final String? loadCatErrMsg;
  final String? filterFoodErrMsg;
  final String? selectedCategory;
  final List<FoodCategoryEntity>? foodCategoriesList;
  final List<MealEntity>? mealsList;

  const FoodState({
    this.loadFoodCategoriesState = LoadFoodCategoriesState.initial,
    this.filterFoodState = FilterFoodState.initial,
    this.loadCatErrMsg,
    this.filterFoodErrMsg,
    this.selectedCategory,
    this.foodCategoriesList,
    this.mealsList,
  });
  FoodState copyWith({
    LoadFoodCategoriesState? loadFoodCategoriesState,
    FilterFoodState? filterFoodState,
    String? loadCatErrMsg,
    String? filterFoodErrMsg,
    String? selectedCategory,
    List<FoodCategoryEntity>? foodCategoriesList,
    List<MealEntity>? mealsList,
  }) {
    return FoodState(
      loadFoodCategoriesState:
          loadFoodCategoriesState ?? this.loadFoodCategoriesState,
      filterFoodState: filterFoodState ?? this.filterFoodState,
      loadCatErrMsg: loadCatErrMsg ?? this.loadCatErrMsg,
      filterFoodErrMsg: filterFoodErrMsg ?? this.filterFoodErrMsg,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      foodCategoriesList: foodCategoriesList ?? this.foodCategoriesList,
      mealsList: mealsList ?? this.mealsList,
    );
  }

  @override
  List<Object?> get props => [
    loadFoodCategoriesState,
    filterFoodState,
    selectedCategory,
    loadCatErrMsg,
    filterFoodErrMsg,
    foodCategoriesList,
    mealsList,
  ];
}
