// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_muscles_group_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMusclesGroupResponse _$GetMusclesGroupResponseFromJson(
  Map<String, dynamic> json,
) => GetMusclesGroupResponse(
  message: json['message'] as String?,
  musclesGroup:
      (json['musclesGroup'] as List<dynamic>?)
          ?.map((e) => MusclesGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$GetMusclesGroupResponseToJson(
  GetMusclesGroupResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'musclesGroup': instance.musclesGroup,
};

MusclesGroup _$MusclesGroupFromJson(Map<String, dynamic> json) =>
    MusclesGroup(id: json['_id'] as String?, name: json['name'] as String?);

Map<String, dynamic> _$MusclesGroupToJson(MusclesGroup instance) =>
    <String, dynamic>{'_id': instance.id, 'name': instance.name};
