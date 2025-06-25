import 'package:equatable/equatable.dart';

class MusclesGroupResponseEntity extends Equatable {
  final String? message;
  final List<MuscleGroupEntity>? musclesGroup;

  const MusclesGroupResponseEntity({this.message, this.musclesGroup});

  @override
  List<Object?> get props => [message, musclesGroup];
}

class MuscleGroupEntity extends Equatable {
  final String? id;
  final String? name;

  const MuscleGroupEntity({this.id, this.name});

  @override
  List<Object?> get props => [id, name];
}
