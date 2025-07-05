import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/food/domain/entities/food_categories_entity.dart';
import 'package:super_fitness/modules/food/domain/repositories_contracts/food_repo_contract.dart';
import 'package:super_fitness/modules/food/domain/use_cases/get_food_categories_use_case.dart';

import 'get_food_categories_use_case_test.mocks.dart';

@GenerateMocks([FoodRepoContract])
void main() {
  group('test get food categories use case', () {
    late FoodRepoContract foodRepoContract;
    late GetFoodCategoriesUseCase useCase;
    setUp(() {
      foodRepoContract = MockFoodRepoContract();
      useCase = GetFoodCategoriesUseCase(foodRepoContract);
    });
    test('test get food categories use case', () async {
      var result = Success<List<FoodCategoryEntity>>(
        data: [FoodCategoryEntity(), FoodCategoryEntity()],
      );
      provideDummy<ApiResult<List<FoodCategoryEntity>>>(result);
      when(
        foodRepoContract.getFoodCategories(),
      ).thenAnswer((_) async => result);
      var actual = await useCase.call();
      verify(foodRepoContract.getFoodCategories()).called(1);
      expect(actual, equals(result));
    });
  });
}
