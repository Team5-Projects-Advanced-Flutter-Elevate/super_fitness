part of 'food_details_cubit.dart';

enum FoodVideoStatus { playing, notPlaying }

class FoodDetailsState extends Equatable {
  final FoodVideoStatus foodVideoStatus;

  const FoodDetailsState({this.foodVideoStatus = FoodVideoStatus.notPlaying});

  FoodDetailsState copyWith({FoodVideoStatus? foodVideoStatus}) {
    return FoodDetailsState(
      foodVideoStatus: foodVideoStatus ?? this.foodVideoStatus,
    );
  }

  @override
  List<Object?> get props => [foodVideoStatus];
}
