import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/food/domain/entities/food_categories_entity.dart';
import 'package:super_fitness/modules/food/domain/entities/meal_entity.dart';
import 'package:super_fitness/modules/food/domain/use_cases/filter_meals_by_category_name_use_case.dart';
import 'package:super_fitness/modules/food/domain/use_cases/get_food_categories_use_case.dart';
import 'package:super_fitness/modules/food/ui/view_model/food_state.dart';
import 'package:super_fitness/modules/food/ui/view_model/food_view_model.dart';

import 'food_view_model_test.mocks.dart';

@GenerateMocks([FilterMealsByCategoryNameUseCase, GetFoodCategoriesUseCase])
void main() {
  late GetFoodCategoriesUseCase getFoodCategoriesUseCase;
  late FilterMealsByCategoryNameUseCase filterMealsByCategoryNameUseCase;
  late FoodViewModel foodViewModel;
  late List<FoodCategoryEntity> foodCategories;
  late List<MealEntity> meals;
  String selectedCategory = 'Beef';
  setUpAll(() {
    getFoodCategoriesUseCase = MockGetFoodCategoriesUseCase();
    filterMealsByCategoryNameUseCase = MockFilterMealsByCategoryNameUseCase();
    foodCategories = [
      FoodCategoryEntity(
        idCategory: '1',
        strCategory: 'strCategory 1',
        strCategoryThumb: 'strCategoryThumb',
        strCategoryDescription: 'strCategoryDescription',
      ),
      FoodCategoryEntity(
        idCategory: '2',
        strCategory: 'strCategory 2',
        strCategoryThumb: 'strCategoryThumb',
        strCategoryDescription: 'strCategoryDescription',
      ),
    ];
    meals = [
      MealEntity(id: '1', name: 'name 1', thumbnailUrl: 'thumbnailUrl1'),
      MealEntity(id: '2', name: 'name 2', thumbnailUrl: 'thumbnailUrl2'),
    ];
    ApiResult<List<MealEntity>> filterMealsResult = Success(data: meals);
    ApiResult<List<FoodCategoryEntity>> categoriesResult = Success(
      data: foodCategories,
    );
    provideDummy<ApiResult<List<FoodCategoryEntity>>>(categoriesResult);
    provideDummy<ApiResult<List<MealEntity>>>(filterMealsResult);
    when(
      getFoodCategoriesUseCase.call(),
    ).thenAnswer((_) async => categoriesResult);
    when(
      filterMealsByCategoryNameUseCase.call(selectedCategory),
    ).thenAnswer((_) async => filterMealsResult);
  });
  setUp(() {
    foodViewModel = FoodViewModel(
      getFoodCategoriesUseCase,
      filterMealsByCategoryNameUseCase,
    );
  });
  blocTest(
    'test get food categories',
    build: () => foodViewModel,
    act: (foodViewModel) {
      foodViewModel.onIntent(GetCategoriesIntent());
    },
    expect:
        () => [
          const FoodState(
            loadFoodCategoriesState: LoadFoodCategoriesState.loading,
          ),
          FoodState(
            loadFoodCategoriesState: LoadFoodCategoriesState.success,
            foodCategoriesList: foodCategories,
          ),
          FoodState(
            loadFoodCategoriesState: LoadFoodCategoriesState.idle,
            foodCategoriesList: foodCategories,
          ),
        ],
  );
  blocTest(
    'test filter meals by category',
    build: () => foodViewModel,
    act: (foodViewModel) {
      foodViewModel.onIntent(
        FilterMealsByCategoryIntent(selectedCategoryName: selectedCategory),
      );
    },
    expect:
        () => [
          FoodState(
            filterFoodState: FilterFoodState.loading,
            selectedCategory: selectedCategory,
          ),
          FoodState(
            filterFoodState: FilterFoodState.success,
            mealsList: meals,
            selectedCategory: selectedCategory,
          ),
        ],
  );
}
