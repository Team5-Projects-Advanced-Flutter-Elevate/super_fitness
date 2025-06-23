// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'muscle_group_workouts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MuscleGroupWorkoutsResponse _$MuscleGroupWorkoutsResponseFromJson(
  Map<String, dynamic> json,
) => MuscleGroupWorkoutsResponse(
  message: json['message'] as String?,
  muscleGroup:
      json['muscleGroup'] == null
          ? null
          : MuscleGroup.fromJson(json['muscleGroup'] as Map<String, dynamic>),
  muscles:
      (json['muscles'] as List<dynamic>?)
          ?.map((e) => Muscle.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$MuscleGroupWorkoutsResponseToJson(
  MuscleGroupWorkoutsResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'muscleGroup': instance.muscleGroup,
  'muscles': instance.muscles,
};

MuscleGroup _$MuscleGroupFromJson(Map<String, dynamic> json) =>
    MuscleGroup(id: json['_id'] as String?, name: json['name'] as String?);

Map<String, dynamic> _$MuscleGroupToJson(MuscleGroup instance) =>
    <String, dynamic>{'_id': instance.id, 'name': instance.name};

Muscle _$MuscleFromJson(Map<String, dynamic> json) => Muscle(
  id: json['_id'] as String?,
  name: json['name'] as String?,
  image: json['image'] as String?,
);

Map<String, dynamic> _$MuscleToJson(Muscle instance) => <String, dynamic>{
  '_id': instance.id,
  'name': instance.name,
  'image': instance.image,
};
