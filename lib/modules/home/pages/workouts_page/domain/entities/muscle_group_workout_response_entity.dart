import 'package:super_fitness/modules/home/pages/workouts_page/domain/entities/muscles_group_response_entity.dart';

class MuscleGroupWorkoutsResponseEntity {
  final String? message;

  final MuscleGroupEntity? muscleGroupEntity;

  final List<MuscleEntity>? musclesEntity;

  MuscleGroupWorkoutsResponseEntity({
    this.message,
    this.muscleGroupEntity,
    this.musclesEntity,
  });
}

class MuscleEntity {
  final String? id;
  final String? name;
  final String? image;

  MuscleEntity({this.id, this.name, this.image});
}
