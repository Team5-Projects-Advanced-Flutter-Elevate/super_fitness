import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/bases/base_stateful_widget_state.dart';
import 'package:super_fitness/core/di/injectable_initializer.dart';
import 'package:super_fitness/core/widgets/error_state_widget.dart';
import 'package:super_fitness/core/widgets/loading_state_widget.dart';
import 'package:super_fitness/modules/home/pages/workouts_page/ui/view_model/workouts_page_cubit.dart';

import '../../../../../core/widgets/custom_bottom_tab_bar.dart';
import '../../../../../core/widgets/custom_item_container.dart';

class WorkoutsPage extends StatefulWidget {
  const WorkoutsPage({super.key});

  @override
  State<WorkoutsPage> createState() => _WorkoutsPageState();
}

class _WorkoutsPageState extends BaseStatefulWidgetState<WorkoutsPage> {
  @override
  void initState() {
    workoutsPageCubit.doIntent(GetMusclesGroupIntent());
    super.initState();
  }

  WorkoutsPageCubit workoutsPageCubit = getIt.get<WorkoutsPageCubit>();
  bool firstTime = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => workoutsPageCubit,
      child: BlocConsumer<WorkoutsPageCubit, WorkoutsPageState>(
        listener: (context, state) {
          if (state.getMusclesGroupStatus == WorkoutsPageStatus.success &&
              firstTime) {
            workoutsPageCubit.doIntent(
              GetMuscleGroupWorkoutsIntent(
                id: state.musclesGroup![0].id.toString(),
              ),
            );
            firstTime = false;
          }
        },
        builder: (context, state) {
          switch (state.getMusclesGroupStatus) {
            case WorkoutsPageStatus.initial:
            case WorkoutsPageStatus.loading:
              return const LoadingStateWidget();
            case WorkoutsPageStatus.success:
              return buildSuccess(state);
            case WorkoutsPageStatus.error:
              return ErrorStateWidget(error: state.getMusclesGroupError!);
          }
        },
      ),
    );
  }

  Widget buildSuccess(WorkoutsPageState state) {
    return DefaultTabController(
      initialIndex: 0,
      length: state.musclesGroup!.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Workouts'),
          centerTitle: true,
          bottom: CustomBottomTabBar(
            isScrollable: true,
            onTabClick: (index) {
              workoutsPageCubit.doIntent(
                GetMuscleGroupWorkoutsIntent(
                  id: state.musclesGroup![index].id.toString(),
                ),
              );
            },
            tabs:
                state.musclesGroup!
                    .map((element) => Tab(child: Text(element.name ?? '')))
                    .toList(),
          ),
        ),
        body: BlocBuilder<WorkoutsPageCubit, WorkoutsPageState>(
          builder: (context, state) {
            switch (state.getMuscleGroupWorkoutsStatus) {
              case WorkoutsPageStatus.initial:
              case WorkoutsPageStatus.loading:
                return const LoadingStateWidget();
              case WorkoutsPageStatus.success:
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  child:
                      state.muscleGroupWorkouts!.isEmpty
                          ? Center(
                            child: Text(
                              'No workouts available',
                              style: theme.textTheme.titleLarge,
                            ),
                          )
                          : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 18,
                                  mainAxisSpacing: 18,
                                ),
                            itemBuilder:
                                (context, index) => CustomItemContainer(
                                  imageUrl:
                                      state.muscleGroupWorkouts![index].image ??
                                      '',
                                  width: screenWidth * 0.6,
                                  height: screenHeight * 0.26,
                                  title:
                                      state.muscleGroupWorkouts![index].name ??
                                      '',
                                ),

                            itemCount: state.muscleGroupWorkouts!.length,
                          ),
                );

              case WorkoutsPageStatus.error:
                return ErrorStateWidget(
                  error: state.getMuscleGroupWorkoutsError!,
                );
            }
          },
        ),
      ),
    );
  }
}
