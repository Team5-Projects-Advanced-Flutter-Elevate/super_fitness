import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'food_details_state.dart';

class FoodDetailsCubit extends Cubit<FoodDetailsState> {
  FoodDetailsCubit() : super(const FoodDetailsState());

  void updateVideoState(bool isPlaying) =>
      emit(state.copyWith(foodVideoStatus: FoodVideoStatus.playing));
}
