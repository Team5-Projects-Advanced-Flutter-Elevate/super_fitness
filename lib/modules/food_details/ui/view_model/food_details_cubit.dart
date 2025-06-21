import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/food_details/domain/usecases/get_food_details_use_case.dart';

import '../../domain/entities/food_details_entity.dart';

part 'food_details_state.dart';

@injectable
class FoodDetailsCubit extends Cubit<FoodDetailsState> {
  FoodDetailsCubit(this.getFoodDetailsUseCase)
    : super(const FoodDetailsState());
  final GetFoodDetailsUseCase getFoodDetailsUseCase;

  void doIntent(FoodDetailsIntent intent) {
    switch (intent) {
      case GetFoodDetailsIntent():
        _getFoodDetails(intent.id);
      case UpdateVideoStateIntent():
        _updateVideoState(intent.isPlaying);
    }
  }

  void _updateVideoState(bool isPlaying) => emit(
    state.copyWith(
      foodVideoStatus:
          !isPlaying ? FoodVideoStatus.notPlaying : FoodVideoStatus.playing,
    ),
  );

  Future<void> _getFoodDetails(String id) async {
    emit(state.copyWith(getFoodDetailsStatus: GetFoodDetailsStatus.loading));
    var result = await getFoodDetailsUseCase.execute(id);
    switch (result) {
      case Success<FoodDetailsEntity>():
        List<String> ingredients = [];
        List<String> measures = [];
        var filteredResult = Map.fromEntries(
          result.data.mealEntity?.toJson().entries.where((e) {
                return (e.key.contains('Ingredient') ||
                        e.key.contains('Measure')) &&
                    e.value != null &&
                    e.value.toString().trim().isNotEmpty;
              }) ??
              [],
        );
        filteredResult.forEach((k, v) {
          if (k.toString().contains('Ingredient')) {
            ingredients.add(v.toString());
          } else if (k.toString().contains('Measure')) {
            measures.add(v.toString());
          }
        });

        emit(
          state.copyWith(
            getFoodDetailsStatus: GetFoodDetailsStatus.success,
            foodDetailsEntity: result.data,
            ingredients: ingredients,
            measures: measures,
          ),
        );
      case Error<FoodDetailsEntity>():
        emit(
          state.copyWith(
            getFoodDetailsStatus: GetFoodDetailsStatus.error,
            getFoodDetailsError: result.error,
          ),
        );
    }
  }
}

sealed class FoodDetailsIntent {}

class UpdateVideoStateIntent extends FoodDetailsIntent {
  bool isPlaying;

  UpdateVideoStateIntent(this.isPlaying);
}

class GetFoodDetailsIntent extends FoodDetailsIntent {
  String id;

  GetFoodDetailsIntent(this.id);
}
