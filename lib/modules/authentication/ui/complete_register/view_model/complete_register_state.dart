part of 'complete_register_cubit.dart';

enum CompleteRegisterStatus {
  selectGender,
  selectAage,
  selectWeight,
  selectHeight,
  selectGoal,
  selectActivity,
}

class CompleteRegisterState extends Equatable {
  final CompleteRegisterStatus status;
  final int counter;
  final bool? isMale;
  final int age;
  final int weight;
  final int height;
  final String? goal;
  final String? activity;

  const CompleteRegisterState({
    this.status = CompleteRegisterStatus.selectGender,
    this.counter = 1,
    this.isMale,
    this.age = 14,
    this.weight = 35,
    this.height = 100,
    this.activity,
    this.goal,
  });

  CompleteRegisterState copyWith({
    CompleteRegisterStatus? status,
    int? counter,
    bool? isMale,
    int? age,
    int? weight,
    int? height,
    String? goal,
    String? activity,
  }) {
    return CompleteRegisterState(
      status: status ?? this.status,
      counter: counter ?? this.counter,
      isMale: isMale ?? this.isMale,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      goal: goal ?? this.goal,
      activity: activity ?? this.activity,
    );
  }

  @override
  List<Object?> get props => [
    status,
    counter,
    isMale,
    age,
    weight,
    height,
    goal,
    activity,
  ];
}
