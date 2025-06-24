import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/bases/base_stateful_widget_state.dart';
import 'package:super_fitness/core/widgets/error_state_widget.dart';
import 'package:super_fitness/core/widgets/loading_state_widget.dart';
import 'package:super_fitness/modules/home/domain/entities/random_exercises/random_exercises_response_entity.dart';
import 'package:super_fitness/modules/home/ui/pages/home_page/view_model/home_page_state.dart';
import 'package:super_fitness/modules/home/ui/pages/home_page/view_model/home_page_view_model.dart';
import 'package:super_fitness/modules/home/ui/pages/home_page/widgets/custom_recommendation_container.dart';

class RecommendationToDaySection extends StatefulWidget {
  const RecommendationToDaySection({super.key});

  @override
  State<RecommendationToDaySection> createState() =>
      _RecommendationToDaySectionState();
}

class _RecommendationToDaySectionState
    extends BaseStatefulWidgetState<RecommendationToDaySection> {
  late HomePageViewModel homePageViewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    homePageViewModel = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appLocalizations.recommendationToDay,
          textAlign: TextAlign.start,
          style: theme.textTheme.titleMedium!.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 104,
          width: screenWidth,
          child: BlocBuilder<HomePageViewModel, HomePageState>(
            buildWhen: (previous, current) {
              if (previous.randomExercisesStatus !=
                  current.randomExercisesStatus) {
                return true;
              }
              return false;
            },
            builder: (context, state) {
              switch (state.randomExercisesStatus) {
                case Status.idle:
                  return const SizedBox();
                case Status.loading:
                  return const LoadingStateWidget();
                case Status.success:
                  List<ExerciseEntity> exercises =
                      state.randomExercisesResponse?.exercises ?? [];
                  List<String> thumbnailsUrls =
                      state.exercisesVideosThumbnailsUrls ?? [];
                  return exercises.isEmpty
                      ? Center(
                        child: Text(
                          appLocalizations.noData,
                          style: theme.textTheme.titleMedium!.copyWith(
                            fontSize: 20,
                          ),
                        ),
                      )
                      : ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: exercises.length,
                        itemBuilder: (context, index) {
                          return CustomRecommendationContainer(
                            imageUrl: thumbnailsUrls[index],
                            title: exercises[index].exercise ?? "",
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(width: 18);
                        },
                      );

                case Status.error:
                  return ErrorStateWidget(error: state.randomExercisesError!);
              }
            },
          ),
        ),
      ],
    );
  }
}
