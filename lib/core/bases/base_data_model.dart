import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

abstract class BaseDataModel extends Equatable {
  @JsonKey(includeToJson: false, includeFromJson: false)
  final List<Object?> equatableProps;

  const BaseDataModel({required this.equatableProps});

  @JsonKey(includeToJson: false, includeFromJson: false)
  @override
  List<Object?> get props => equatableProps;

  @JsonKey(includeToJson: false, includeFromJson: false)
  @override
  bool? get stringify => super.stringify;

  @JsonKey(includeToJson: false, includeFromJson: false)
  @override
  // ignore_for_file: hash_and_equals
  int get hashCode => super.hashCode;
}
