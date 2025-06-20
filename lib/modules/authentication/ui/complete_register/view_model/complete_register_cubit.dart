import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'complete_register_state.dart';

@injectable
class CompleteRegisterCubit extends Cubit<CompleteRegisterState> {
  CompleteRegisterCubit() : super(const CompleteRegisterState());

  void updateStatus(
    CompleteRegisterStatus status, {
    bool? isMale,
    int? age,
    int? weight,
    int? height,
    String? goal,
    String? activity,
  }) {
    {
      switch (status) {
        case CompleteRegisterStatus.selectGender:
          emit(
            state.copyWith(
              status: CompleteRegisterStatus.selectAage,
              counter: state.counter + 1,
              isMale: isMale,
            ),
          );
        case CompleteRegisterStatus.selectAage:
          emit(
            state.copyWith(
              status: CompleteRegisterStatus.selectWeight,
              counter: state.counter + 1,
              age: age,
            ),
          );
        case CompleteRegisterStatus.selectWeight:
          emit(
            state.copyWith(
              status: CompleteRegisterStatus.selectHeight,
              counter: state.counter + 1,
              weight: weight,
            ),
          );
        case CompleteRegisterStatus.selectHeight:
          emit(
            state.copyWith(
              status: CompleteRegisterStatus.selectGoal,
              counter: state.counter + 1,
              height: height,
            ),
          );
        case CompleteRegisterStatus.selectGoal:
          emit(
            state.copyWith(
              status: CompleteRegisterStatus.selectActivity,
              counter: state.counter + 1,
              goal: goal,
            ),
          );
        case CompleteRegisterStatus.selectActivity:
          emit(state.copyWith(activity: activity));
      }
    }
  }

  void goBack(
    CompleteRegisterStatus status, {
    bool? isMale,
    int? age,
    int? weight,
    int? height,
    String? goal,
    String? activity,
    required PageController pageViewController,
  }) {
    switch (status) {
      case CompleteRegisterStatus.selectGender:
        pageViewController.jumpToPage(0);
      case CompleteRegisterStatus.selectAage:
        emit(
          state.copyWith(
            status: CompleteRegisterStatus.selectGender,
            counter: state.counter - 1,
          ),
        );
      case CompleteRegisterStatus.selectWeight:
        emit(
          state.copyWith(
            status: CompleteRegisterStatus.selectAage,
            counter: state.counter - 1,
          ),
        );
      case CompleteRegisterStatus.selectHeight:
        emit(
          state.copyWith(
            status: CompleteRegisterStatus.selectWeight,
            counter: state.counter - 1,
          ),
        );
      case CompleteRegisterStatus.selectGoal:
        emit(
          state.copyWith(
            status: CompleteRegisterStatus.selectHeight,
            counter: state.counter - 1,
          ),
        );
      case CompleteRegisterStatus.selectActivity:
        emit(
          state.copyWith(
            status: CompleteRegisterStatus.selectGoal,
            counter: state.counter - 1,
          ),
        );
    }
  }
}
