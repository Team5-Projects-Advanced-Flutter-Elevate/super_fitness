import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/food_details/data/api/api_client/food_details_api_client.dart';
import 'package:super_fitness/modules/food_details/data/datasource_impl/food_details_datasource_impl.dart';
import 'package:super_fitness/modules/food_details/data/models/food_details.dart';
import 'package:super_fitness/modules/food_details/domain/entities/food_details_entity.dart';

import 'food_details_datasource_impl_test.mocks.dart';

@GenerateMocks([FoodDetailsApiClient])
void main() {
  late MockFoodDetailsApiClient mockFoodDetailsApiClient;
  late FoodDetailsDataSourceImpl foodDetailsDataSourceImpl;
  setUpAll(() {
    mockFoodDetailsApiClient = MockFoodDetailsApiClient();
    foodDetailsDataSourceImpl = FoodDetailsDataSourceImpl(
      mockFoodDetailsApiClient,
    );
  });
  group('FoodDetailsDatasourceImpl', () {
    group('getFoodDetails', () {
      test(
        'should return a FoodDetailsEntity when the http call completes successfully',
        () async {
          // arrange
          final responseModel = FoodDetailsModel(
            meal: [
              Meal(
                idMeal: '1',
                strMeal: 'strMeal',
                strIngredient1: 'strIngredient1',
                strIngredient2: 'strIngredient2',
                strIngredient3: 'strIngredient3',
                strIngredient4: 'strIngredient4',
                strIngredient5: 'strIngredient5',
                strIngredient6: 'strIngredient6',
                strIngredient7: 'strIngredient7',
                strIngredient8: 'strIngredient8',
                strIngredient9: 'strIngredient9',
                strIngredient10: 'strIngredient10',
                strMeasure1: 'strMeasure1',
                strMeasure2: 'strMeasure2',
                strMeasure3: 'strMeasure3',
                strMeasure4: 'strMeasure4',
                strMeasure5: 'strMeasure5',
                strMeasure6: 'strMeasure6',
                strMeasure7: 'strMeasure7',
                strMeasure8: 'strMeasure8',
                strMeasure9: 'strMeasure9',
                strMeasure10: 'strMeasure10',
                strSource: 'strSource',
                strImageSource: 'strImageSource',
                strCreativeCommonsConfirmed: 'strCreativeCommonsConfirmed',
                dateModified: 'dateModified',
                strArea: 'strArea',
                strCategory: 'strCategory',
                strInstructions: 'strInstructions',
                strMealThumb: 'strMealThumb',
                strTags: 'strTags',
                strYoutube: 'strYoutube',
                strMealAlternate: 'strMealAlternate',
              ),
            ],
          );
          when(
            mockFoodDetailsApiClient.getFoodDetails(any),
          ).thenAnswer((_) async => responseModel);
          // act
          final result = await foodDetailsDataSourceImpl.getFoodDetails('1');
          // assert
          expect(result, isA<Success<FoodDetailsEntity>>());
          verify(mockFoodDetailsApiClient.getFoodDetails('1')).called(1);
        },
      );

      test(
        'should return a Error when the http call completes with an error',
        () async {
          // arrange
          final mockError = Exception('Failed to fetch food details');

          when(
            mockFoodDetailsApiClient.getFoodDetails(any),
          ).thenThrow(mockError);
          // act
          final result = await foodDetailsDataSourceImpl.getFoodDetails('1');
          // assert
          expect(result, isA<Error<FoodDetailsEntity>>());
          verify(mockFoodDetailsApiClient.getFoodDetails('1')).called(1);
        },
      );
    });
  });
}
