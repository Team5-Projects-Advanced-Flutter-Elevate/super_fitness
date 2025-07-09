import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/food/data/api/api_client/food_api_client.dart';
import 'package:super_fitness/modules/food/data/data_sources_contracts/food_data_source_contract.dart';
import 'package:super_fitness/modules/food/data/data_sources_imp/food_data_source_imp.dart';
import 'package:super_fitness/modules/food/data/models/get_food_categories_model.dart';
import 'package:super_fitness/modules/food/data/models/meal_by_category_model.dart';
import 'package:super_fitness/modules/food/domain/entities/food_categories_entity.dart';
import 'package:super_fitness/modules/food/domain/entities/meal_entity.dart';

import 'food_data_source_imp_test.mocks.dart';

@GenerateMocks([FoodApiClient])
void main() {
  late FoodApiClient foodApiClient;
  late FoodDataSourceContract foodDataSourceImp;
  const String selectedCategory = 'Beef';
  final mockError = Exception('Failed to fetch muscles group');
  setUp(() {
    foodApiClient = MockFoodApiClient();
    foodDataSourceImp = FoodDataSourceImp(foodApiClient);
  });
  group('test food categories', () {
    test('test get food category methode success case', () async {
      final result = GetFoodCategoriesModel(
        categories: [
          Categories(
            idCategory: '1',
            strCategory: 'strCategory',
            strCategoryThumb: 'strCategoryThumb',
            strCategoryDescription: 'strCategoryDescription',
          ),
          Categories(
            idCategory: '2',
            strCategory: 'strCategory',
            strCategoryThumb: 'strCategoryThumb',
            strCategoryDescription: 'strCategoryDescription',
          ),
        ],
      );
      when(foodApiClient.getFoodCategories()).thenAnswer((_) async => result);
      final actual = await foodDataSourceImp.getFoodCategories();
      verify(foodApiClient.getFoodCategories()).called(1);
      expect(actual, isA<Success<List<FoodCategoryEntity>>>());
    });
    test('test get food category methode failure case', () async {
      when(foodApiClient.getFoodCategories()).thenThrow(mockError);
      final actual = await foodDataSourceImp.getFoodCategories();
      verify(foodApiClient.getFoodCategories()).called(1);
      expect(actual, isA<Error<List<FoodCategoryEntity>>>());
    });
  });
  group('test filter meals by category', () {
    test('test filter meals by category success case', () async {
      final result = MealByCategoryModel(
        meals: [
          Meals(
            strMeal: 'strMeal',
            strMealThumb: 'strMealThumb',
            idMeal: 'idMeal',
          ),
          Meals(
            strMeal: 'strMeal',
            strMealThumb: 'strMealThumb',
            idMeal: 'idMeal',
          ),
        ],
      );
      when(
        foodApiClient.getMealByCategoryName(selectedCategory),
      ).thenAnswer((_) async => result);
      final actual = await foodDataSourceImp.getFoodByCategory(
        selectedCategory,
      );
      verify(foodApiClient.getMealByCategoryName(selectedCategory)).called(1);
      expect(actual, isA<Success<List<MealEntity>>>());
    });
    test('test filter meals by category failure case', () async {
      when(
        foodApiClient.getMealByCategoryName(selectedCategory),
      ).thenThrow(mockError);
      final actual = await foodDataSourceImp.getFoodByCategory(
        selectedCategory,
      );
      verify(foodApiClient.getMealByCategoryName(selectedCategory)).called(1);
      expect(actual, isA<Error<List<MealEntity>>>());
    });
  });
}
