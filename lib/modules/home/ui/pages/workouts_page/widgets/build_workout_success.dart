import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/bases/base_inherited_widget.dart';
import 'package:super_fitness/modules/home/ui/pages/workouts_page/view_model/workouts_page_cubit.dart';

import '../../../../../../core/bases/base_statless_widget.dart';
import '../../../../../../core/widgets/custom_bottom_tab_bar.dart';
import '../../../../../../core/widgets/custom_item_container.dart';
import '../../../../../../core/widgets/error_state_widget.dart';
import '../../../../../../core/widgets/loading_state_widget.dart';

class BuildWorkoutsSuccessState extends BaseStatelessWidget {
  const BuildWorkoutsSuccessState({super.key, required this.state});

  final WorkoutsPageState state;

  @override
  Widget customBuild(BuildContext context, BaseInheritedWidget inherit) {
    return DefaultTabController(
      initialIndex: 0,
      length: state.musclesGroup!.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(inherit.appLocalizations.workouts),
          centerTitle: true,
          bottom: CustomBottomTabBar(
            isScrollable: true,
            onTabClick: (index) {
              BlocProvider.of<WorkoutsPageCubit>(context).doIntent(
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
                              inherit.appLocalizations.noWorkoutsAvailable,
                              style: inherit.theme.textTheme.titleLarge,
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
                                  width: inherit.screenWidth * 0.6,
                                  height: inherit.screenHeight * 0.26,
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
