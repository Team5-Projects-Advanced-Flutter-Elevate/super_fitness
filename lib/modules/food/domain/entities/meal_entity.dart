class MealEntity {
  final String id;
  final String name;
  final String thumbnailUrl;

  MealEntity({
    required this.id,
    required this.name,
    required this.thumbnailUrl,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          thumbnailUrl == other.thumbnailUrl;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ thumbnailUrl.hashCode;

  @override
  String toString() {
    return 'MealEntity{id: $id, name: $name, thumbnailUrl: $thumbnailUrl}';
  }
}
