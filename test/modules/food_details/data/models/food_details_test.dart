import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/modules/food_details/data/models/food_details.dart';
import 'package:super_fitness/modules/food_details/domain/entities/food_details_entity.dart';

void main() {
  group('foodDetailsModel', () {
    test(
      'toEntity with non-null values should return FoodDetailsEntity with all fields',
      () {
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
        // act
        final result = responseModel.toEntity();
        final jsonResult = responseModel.toJson();

        // verify that all fields are not null
        jsonResult.forEach((key, value) => expect(value, isNotNull));

        // assert
        expect(result, isA<FoodDetailsEntity>());
      },
    );

    test(
      'toEntity with null values should return FoodDetailsEntity with null values',
      () {
        // arrange
        final responseModel = FoodDetailsModel();

        // act
        final result = responseModel.toEntity();
        final jsonResult = responseModel.toJson();

        // verify that all fields are null
        jsonResult.forEach((key, value) => expect(value, isNull));

        // assert
        expect(result, isA<FoodDetailsEntity?>());
      },
    );
  });
}
