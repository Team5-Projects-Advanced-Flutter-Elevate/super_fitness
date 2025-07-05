import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/food/domain/entities/meal_entity.dart';
import 'package:super_fitness/modules/food/domain/repositories_contracts/food_repo_contract.dart';
import 'package:super_fitness/modules/food/domain/use_cases/filter_meals_by_category_name_use_case.dart';

import 'get_food_categories_use_case_test.mocks.dart';

@GenerateMocks([FoodRepoContract])
void main() {
  group('test get meals by category use case', () {
    late FoodRepoContract foodRepoContract;
    late FilterMealsByCategoryNameUseCase useCase;
    setUp(() {
      foodRepoContract = MockFoodRepoContract();
      useCase = FilterMealsByCategoryNameUseCase(foodRepoContract);
    });
    test('test get meals by category use case', () async {
      var result = Success<List<MealEntity>>(
        data: [
          MealEntity(id: '1', name: 'name 1', thumbnailUrl: 'thumbnailUrl1'),
          MealEntity(id: '2', name: 'name 2', thumbnailUrl: 'thumbnailUrl2'),
        ],
      );
      provideDummy<ApiResult<List<MealEntity>>>(result);
      when(
        foodRepoContract.getFoodByCategory('Beef'),
      ).thenAnswer((_) async => result);
      var actual = await useCase.call('Beef');
      verify(foodRepoContract.getFoodByCategory('Beef')).called(1);
      expect(actual, equals(result));
    });
  });
}
