import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/food_details/domain/entities/food_details_entity.dart';
import 'package:super_fitness/modules/food_details/domain/usecases/get_food_details_use_case.dart';
import 'package:super_fitness/modules/food_details/ui/view_model/food_details_cubit.dart';
import 'package:super_fitness/modules/food_details/ui/view_model/food_details_intent.dart';

import 'food_details_cubit_test.mocks.dart';

@GenerateMocks([GetFoodDetailsUseCase])
void main() {
  late MockGetFoodDetailsUseCase mockGetFoodDetailsUseCase;
  late FoodDetailsCubit foodDetailsCubit;
  late Object error;
  group('FoodDetailsCubit ', () {
    setUp(() {
      mockGetFoodDetailsUseCase = MockGetFoodDetailsUseCase();
      foodDetailsCubit = FoodDetailsCubit(mockGetFoodDetailsUseCase);
    });

    group('get food details ', () {
      blocTest(
        'emits loading → success state when use case returns success and filtered ingredients and measures',
        build: () => foodDetailsCubit,
        setUp: () {
          const responseModel = FoodDetailsEntity(
            mealEntity: MealEntity(
              strMeal: "Apam Balik",
              strIngredient1: "Flour",
              strIngredient2: "Eggs",
              strMeasure1: "2 cups",
              strMeasure2: "3 pcs",
            ),
          );
          provideDummy<ApiResult<FoodDetailsEntity>>(
            Success<FoodDetailsEntity>(data: responseModel),
          );

          when(mockGetFoodDetailsUseCase.execute(any)).thenAnswer(
            (_) async => Success<FoodDetailsEntity>(data: responseModel),
          );
        },
        act: (cubit) => cubit.doIntent(GetFoodDetailsIntent('1')),
        expect:
            () => <FoodDetailsState>[
              const FoodDetailsState(
                getFoodDetailsStatus: GetFoodDetailsStatus.loading,
              ),
              const FoodDetailsState(
                getFoodDetailsStatus: GetFoodDetailsStatus.success,
                foodDetailsEntity: FoodDetailsEntity(
                  mealEntity: MealEntity(
                    strMeal: "Apam Balik",
                    strIngredient1: "Flour",
                    strIngredient2: "Eggs",
                    strMeasure1: "2 cups",
                    strMeasure2: "3 pcs",
                  ),
                ),
                ingredients: ["Flour", "Eggs"],
                measures: ["2 cups", "3 pcs"],
              ),
            ],
      );

      blocTest(
        'emits loading → error state when use case returns error',
        build: () => foodDetailsCubit,
        setUp: () {
          error = Exception('network error');

          provideDummy<ApiResult<FoodDetailsEntity>>(
            Error<FoodDetailsEntity>(error: error),
          );

          when(
            mockGetFoodDetailsUseCase.execute(any),
          ).thenAnswer((_) async => Error<FoodDetailsEntity>(error: error));
        },
        act: (cubit) => cubit.doIntent(GetFoodDetailsIntent('1')),
        expect:
            () => <FoodDetailsState>[
              const FoodDetailsState(
                getFoodDetailsStatus: GetFoodDetailsStatus.loading,
              ),
              FoodDetailsState(
                getFoodDetailsStatus: GetFoodDetailsStatus.error,
                getFoodDetailsError: error,
              ),
            ],
      );
    });

    group('update video state', () {
      blocTest(
        'toggle video state from not playing to playing',
        build: () => foodDetailsCubit,
        act: (cubit) => cubit.doIntent(UpdateVideoStateIntent(true)),
        expect:
            () => <FoodDetailsState>[
              const FoodDetailsState(foodVideoStatus: FoodVideoStatus.playing),
            ],
      );

      blocTest(
        'toggle video state from  playing to not playing',
        build: () => foodDetailsCubit,
        act: (cubit) => cubit.doIntent(UpdateVideoStateIntent(false)),
        expect:
            () => <FoodDetailsState>[
              const FoodDetailsState(
                foodVideoStatus: FoodVideoStatus.notPlaying,
              ),
            ],
      );
    });
  });
}
