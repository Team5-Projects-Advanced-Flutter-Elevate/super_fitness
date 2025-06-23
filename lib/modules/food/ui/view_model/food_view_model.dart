import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/modules/food/domain/entities/meal_entity.dart';
import 'package:super_fitness/modules/food/domain/use_cases/get_food_categories_use_case.dart';
import 'package:super_fitness/modules/food/ui/view_model/food_state.dart';

import '../../../../core/apis/api_error/api_error_handler.dart';
import '../../../../core/apis/api_result/api_result.dart';
import '../../../../core/di/injectable_initializer.dart';
import '../../domain/entities/food_categories_entity.dart';
import '../../domain/use_cases/filter_meals_by_category_name_use_case.dart';

@injectable
class FoodViewModel extends Cubit<FoodState> {
  FoodViewModel(this._categoriesUseCase, this._filterMealsByCategoryNameUseCase)
    : super(const FoodState());
  final GetFoodCategoriesUseCase _categoriesUseCase;
  final FilterMealsByCategoryNameUseCase _filterMealsByCategoryNameUseCase;

  void onIntent(FoodIntent intent) {
    switch (intent) {
      case GetCategoriesIntent():
        _getCategories();
        break;
      case FilterMealsByCategoryIntent():
        _filterMealsByCategory(
          selectedCategoryName: intent.selectedCategoryName,
        );
        break;
    }
  }

  Future<void> _getCategories() async {
    emit(
      state.copyWith(loadFoodCategoriesState: LoadFoodCategoriesState.loading),
    );
    var result = await _categoriesUseCase.call();
    switch (result) {
      case Success<List<FoodCategoryEntity>>():
        emit(
          state.copyWith(
            loadFoodCategoriesState: LoadFoodCategoriesState.success,
            foodCategoriesList: result.data,
            selectedCategory: result.data.first.strCategory,
          ),
        );
        break;
      case Error<List<FoodCategoryEntity>>():
        emit(
          state.copyWith(
            loadFoodCategoriesState: LoadFoodCategoriesState.error,
            loadCatErrMsg: getIt.get<ApiErrorHandler>().handle(result.error),
          ),
        );
        break;
    }
  }

  Future<void> _filterMealsByCategory({
    required String selectedCategoryName,
  }) async {
    emit(
      state.copyWith(
        filterFoodState: FilterFoodState.loading,
        selectedCategory: selectedCategoryName,
      ),
    );
    var result = await _filterMealsByCategoryNameUseCase.call(
      selectedCategoryName,
    );
    switch (result) {
      case Success<List<MealEntity>>():
        emit(
          state.copyWith(
            filterFoodState: FilterFoodState.success,
            mealsList: result.data,
          ),
        );
        break;
      case Error<List<MealEntity>>():
        emit(
          state.copyWith(
            filterFoodState: FilterFoodState.error,
            filterFoodErrMsg: getIt.get<ApiErrorHandler>().handle(result.error),
          ),
        );
        break;
    }
  }
}

sealed class FoodIntent {}

class GetCategoriesIntent extends FoodIntent {}

class FilterMealsByCategoryIntent extends FoodIntent {
  String selectedCategoryName;
  FilterMealsByCategoryIntent({required this.selectedCategoryName});
}
