part of 'food_details_cubit.dart';

enum FoodVideoStatus { playing, notPlaying }

enum GetFoodDetailsStatus { initial, loading, success, error }

class FoodDetailsState extends Equatable {
  final FoodVideoStatus foodVideoStatus;
  final GetFoodDetailsStatus getFoodDetailsStatus;
  final FoodDetailsEntity? foodDetailsEntity;
  final Object? getFoodDetailsError;
  final List<String>? ingredients;

  final List<String>? measures;

  const FoodDetailsState({
    this.foodVideoStatus = FoodVideoStatus.notPlaying,
    this.getFoodDetailsStatus = GetFoodDetailsStatus.initial,
    this.foodDetailsEntity,
    this.getFoodDetailsError,
    this.ingredients,
    this.measures,
  });

  FoodDetailsState copyWith({
    FoodVideoStatus? foodVideoStatus,
    GetFoodDetailsStatus? getFoodDetailsStatus,
    FoodDetailsEntity? foodDetailsEntity,
    Object? getFoodDetailsError,
    List<String>? ingredients,
    List<String>? measures,
  }) {
    return FoodDetailsState(
      foodVideoStatus: foodVideoStatus ?? this.foodVideoStatus,
      getFoodDetailsStatus: getFoodDetailsStatus ?? this.getFoodDetailsStatus,
      foodDetailsEntity: foodDetailsEntity ?? this.foodDetailsEntity,
      getFoodDetailsError: getFoodDetailsError ?? this.getFoodDetailsError,
      ingredients: ingredients ?? this.ingredients,
      measures: measures ?? this.measures,
    );
  }

  @override
  List<Object?> get props => [
    foodVideoStatus,
    getFoodDetailsStatus,
    foodDetailsEntity,
    getFoodDetailsError,
    ingredients,
    measures,
  ];
}
