sealed class FoodDetailsIntent {}

class UpdateVideoStateIntent extends FoodDetailsIntent {
  bool isPlaying;

  UpdateVideoStateIntent(this.isPlaying);
}

class GetFoodDetailsIntent extends FoodDetailsIntent {
  String id;

  GetFoodDetailsIntent(this.id);
}
