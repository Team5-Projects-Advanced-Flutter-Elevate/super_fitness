import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/food/data/api/api_client/food_api_client.dart';
import 'package:super_fitness/modules/food/data/data_sources_contracts/food_data_source_contract.dart';
import 'package:super_fitness/modules/food/data/data_sources_imp/food_data_source_imp.dart';
import 'package:super_fitness/modules/food/data/models/get_food_categories_model.dart';
import 'package:super_fitness/modules/food/domain/entities/food_categories_entity.dart';

import 'food_data_source_imp_test.mocks.dart';

@GenerateMocks([FoodApiClient])
void main() {
  late FoodApiClient foodApiClient;
  late FoodDataSourceContract foodDataSourceImp;
  setUp(() {
    foodApiClient = MockFoodApiClient();
    foodDataSourceImp = FoodDataSourceImp(foodApiClient);
  });
  test('test get food category methode', () async {
    var result = Success<List<FoodCategoryEntity>>(
      data: [FoodCategoryEntity(), FoodCategoryEntity()],
    ); // provideDummy<GetFoodCategoriesModel>(result);
    when(
      foodApiClient.getFoodCategories(),
    ).thenAnswer((_) async => result as GetFoodCategoriesModel);
    var actual = await foodDataSourceImp.getFoodCategories();
    verify(foodApiClient.getFoodCategories()).called(1);
    expect(actual, equals(result));
  });
}
