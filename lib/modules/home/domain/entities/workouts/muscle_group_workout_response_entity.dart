import 'package:equatable/equatable.dart';
import 'package:super_fitness/modules/home/domain/entities/workouts/muscles_group_response_entity.dart';

class MuscleGroupWorkoutsResponseEntity extends Equatable {
  final String? message;

  final MuscleGroupEntity? muscleGroupEntity;

  final List<MuscleEntity>? musclesEntity;

  const MuscleGroupWorkoutsResponseEntity({
    this.message,
    this.muscleGroupEntity,
    this.musclesEntity,
  });

  @override
  List<Object?> get props => [message, muscleGroupEntity, musclesEntity];
}

class MuscleEntity extends Equatable {
  final String? id;
  final String? name;
  final String? image;

  const MuscleEntity({this.id, this.name, this.image});

  @override
  List<Object?> get props => [id, name, image];
}
