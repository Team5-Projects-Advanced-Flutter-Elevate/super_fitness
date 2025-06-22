class MusclesGroupResponseEntity {
  final String? message;
  final List<MuscleGroupEntity>? musclesGroup;

  MusclesGroupResponseEntity({this.message, this.musclesGroup});
}

class MuscleGroupEntity {
  final String? id;
  final String? name;

  MuscleGroupEntity({this.id, this.name});
}
