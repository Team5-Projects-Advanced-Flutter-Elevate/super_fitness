import 'package:flutter/material.dart';
import 'package:super_fitness/core/apis/api_error/api_error_handler.dart';
import 'package:super_fitness/core/di/injectable_initializer.dart';

import '../bases/base_statless_widget.dart';

class ErrorStateWidget extends BaseStatelessWidget {
  final Object error;

  const ErrorStateWidget({super.key, required this.error});

  @override
  Widget customBuild(BuildContext context, inherit) {
    final ApiErrorHandler apiErrorHandler = getIt.get<ApiErrorHandler>();
    return Center(
      child: Text(
        apiErrorHandler.handle(error),
        textAlign: TextAlign.center,
        style: inherit.theme.textTheme.titleMedium,
      ),
    );
  }
}
