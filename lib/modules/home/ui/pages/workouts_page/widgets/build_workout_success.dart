import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/bases/base_stateful_widget_state.dart';
import 'package:super_fitness/core/routing/defined_routes.dart';
import 'package:super_fitness/modules/home/ui/pages/workouts_page/view_model/workouts_page_cubit.dart';
import '../../../../../../core/widgets/custom_bottom_tab_bar.dart';
import '../../../../../../core/widgets/custom_item_container.dart';
import '../../../../../../core/widgets/error_state_widget.dart';
import '../../../../../../core/widgets/loading_state_widget.dart';

class BuildWorkoutsSuccessState extends StatefulWidget {
  const BuildWorkoutsSuccessState({super.key, required this.state});

  final WorkoutsPageState state;

  @override
  State<BuildWorkoutsSuccessState> createState() =>
      _BuildWorkoutsSuccessStateState();
}

class _BuildWorkoutsSuccessStateState
    extends BaseStatefulWidgetState<BuildWorkoutsSuccessState> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: widget.state.musclesGroup!.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(appLocalizations.workouts),
          centerTitle: true,
          bottom: CustomBottomTabBar(
            isScrollable: true,
            onTabClick: (index) {
              if (currentIndex != index) {
                BlocProvider.of<WorkoutsPageCubit>(context).doIntent(
                  GetMuscleGroupWorkoutsIntent(
                    id: widget.state.musclesGroup![index].id.toString(),
                  ),
                );
              }
              currentIndex = index;
            },
            tabs:
                widget.state.musclesGroup!
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
                              appLocalizations.noWorkoutsAvailable,
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
                                (context, index) => InkWell(
                                  hoverColor: WidgetStateColor.transparent,
                                  overlayColor: WidgetStateColor.transparent,
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      DefinedRoutes.exerciseScreenRoute,
                                      arguments:
                                          state.muscleGroupWorkouts![index].id,
                                    );
                                  },
                                  child: CustomItemContainer(
                                    imageUrl:
                                        state
                                            .muscleGroupWorkouts![index]
                                            .image ??
                                        '',
                                    width: screenWidth * 0.6,
                                    height: screenHeight * 0.26,
                                    title:
                                        state
                                            .muscleGroupWorkouts![index]
                                            .name ??
                                        '',
                                  ),
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
