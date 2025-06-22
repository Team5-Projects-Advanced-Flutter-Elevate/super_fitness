import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness/modules/home/pages/workouts_page/domain/entities/muscles_group_response_entity.dart';

part 'get_all_muscles_group_response.g.dart';

@JsonSerializable()
class GetMusclesGroupResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "musclesGroup")
  final List<MusclesGroup>? musclesGroup;

  GetMusclesGroupResponse({this.message, this.musclesGroup});

  factory GetMusclesGroupResponse.fromJson(Map<String, dynamic> json) {
    return _$GetMusclesGroupResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetMusclesGroupResponseToJson(this);
  }

  MusclesGroupResponseEntity toEntity() {
    return MusclesGroupResponseEntity(
      message: message,
      musclesGroup: musclesGroup?.map((e) => e.toEntity()).toList(),
    );
  }
}

@JsonSerializable()
class MusclesGroup {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;

  MusclesGroup({this.id, this.name});

  factory MusclesGroup.fromJson(Map<String, dynamic> json) {
    return _$MusclesGroupFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MusclesGroupToJson(this);
  }

  MuscleGroupEntity toEntity() {
    return MuscleGroupEntity(id: id, name: name);
  }
}
