import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/food_details/domain/usecases/get_food_details_use_case.dart';

import '../../../../core/constants/assets_paths/assets_paths.dart';
import '../../domain/entities/food_details_entity.dart';
import 'food_details_intent.dart';

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
        var ingredients = _getIngredientsAndMeasures(result).first;
        var measures = _getIngredientsAndMeasures(result).last;

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

  List<List<String>> _getIngredientsAndMeasures(result) {
    List<String> ingredients = [];
    List<String> measures = [];
    var filteredResult = Map.fromEntries(
      result.data.mealEntity?.toJson().entries.where((e) {
            return (e.key.contains(AssetsPaths.ingredientKey) ||
                    e.key.contains(AssetsPaths.measureKey)) &&
                e.value != null &&
                e.value.toString().trim().isNotEmpty;
          }) ??
          [],
    );
    filteredResult.forEach((k, v) {
      if (k.toString().contains(AssetsPaths.ingredientKey)) {
        ingredients.add(v.toString());
      } else if (k.toString().contains(AssetsPaths.measureKey)) {
        measures.add(v.toString());
      }
    });
    return [ingredients, measures];
  }
}

