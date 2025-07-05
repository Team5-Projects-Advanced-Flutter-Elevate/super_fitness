import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/food/data/data_sources_contracts/food_data_source_contract.dart';
import 'package:super_fitness/modules/food/data/repositories_imp/food_repo_imp.dart';
import 'package:super_fitness/modules/food/domain/entities/food_categories_entity.dart';
import 'package:super_fitness/modules/food/domain/entities/meal_entity.dart';

import 'food_repo_imp_test.mocks.dart';

@GenerateMocks([FoodDataSourceContract])
void main() {
  group('test food repo', () {
    late FoodDataSourceContract foodDataSourceContract;
    late FoodRepoImp foodRepoImp;
    setUp(() {
      foodDataSourceContract = MockFoodDataSourceContract();
      foodRepoImp = FoodRepoImp(foodDataSourceContract);
    });
    test('test get food categories in food repo impl', () async {
      var result = Success<List<FoodCategoryEntity>>(
        data: [FoodCategoryEntity(), FoodCategoryEntity()],
      );
      provideDummy<ApiResult<List<FoodCategoryEntity>>>(result);
      when(
        foodDataSourceContract.getFoodCategories(),
      ).thenAnswer((_) async => result);
      var actual = await foodRepoImp.getFoodCategories();
      verify(foodRepoImp.getFoodCategories()).called(1);
      expect(actual, equals(result));
    });
    test('test get meals by categories in food repo impl', () async {
      var result = Success<List<MealEntity>>(
        data: [
          MealEntity(id: '1', name: 'name 1', thumbnailUrl: 'thumbnailUrl1'),
          MealEntity(id: '2', name: 'name 2', thumbnailUrl: 'thumbnailUrl2'),
        ],
      );
      provideDummy<ApiResult<List<MealEntity>>>(result);
      when(
        foodRepoImp.getFoodByCategory('Beef'),
      ).thenAnswer((_) async => result);
      var actual = await foodRepoImp.getFoodByCategory('Beef');
      verify(foodRepoImp.getFoodByCategory('Beef')).called(1);
      expect(actual, equals(result));
    });
  });
}
