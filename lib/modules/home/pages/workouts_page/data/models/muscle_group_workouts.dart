import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness/modules/home/pages/workouts_page/domain/entities/muscle_group_workout_response_entity.dart';

import '../../domain/entities/muscles_group_response_entity.dart';

part 'muscle_group_workouts.g.dart';

@JsonSerializable()
class MuscleGroupWorkoutsResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "muscleGroup")
  final MuscleGroup? muscleGroup;
  @JsonKey(name: "muscles")
  final List<Muscle>? muscles;

  MuscleGroupWorkoutsResponse({this.message, this.muscleGroup, this.muscles});

  factory MuscleGroupWorkoutsResponse.fromJson(Map<String, dynamic> json) {
    return _$MuscleGroupWorkoutsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MuscleGroupWorkoutsResponseToJson(this);
  }

  MuscleGroupWorkoutsResponseEntity toEntity() {
    return MuscleGroupWorkoutsResponseEntity(
      message: message,
      muscleGroupEntity: MuscleGroupEntity(
        id: muscleGroup?.id,
        name: muscleGroup?.name,
      ),
      musclesEntity:
          muscles
              ?.map((e) => MuscleEntity(id: e.id, name: e.name, image: e.image))
              .toList(),
    );
  }
}

@JsonSerializable()
class MuscleGroup {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;

  MuscleGroup({this.id, this.name});

  factory MuscleGroup.fromJson(Map<String, dynamic> json) {
    return _$MuscleGroupFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MuscleGroupToJson(this);
  }
}

@JsonSerializable()
class Muscle {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "image")
  final String? image;

  Muscle({this.id, this.name, this.image});

  factory Muscle.fromJson(Map<String, dynamic> json) {
    return _$MuscleFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MuscleToJson(this);
  }
}
