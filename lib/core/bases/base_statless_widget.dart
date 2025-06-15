import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness/main.dart';

import '../colors/app_colors.dart';
import 'base_inherited_widget.dart';

late BuildContext _context;
late ThemeData _theme;

abstract class BaseStatelessWidget extends StatelessWidget {
  const BaseStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    _context = context;
    BaseInheritedWidget inherit = BaseInheritedWidget.of(context);
    _theme = inherit.theme;

    return customBuild(context, inherit);
  }

  Widget customBuild(BuildContext context, BaseInheritedWidget inherit);

  Future<void> displaySnackBar({
    required ContentType contentType,
    required String title,
    String? message,
  }) async {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 2),
      content: AwesomeSnackbarContent(
        title: title,
        titleTextStyle: _theme.textTheme.titleMedium!.copyWith(
          color: Colors.white,
        ),
        message: message ?? "",
        messageTextStyle: _theme.textTheme.labelMedium!.copyWith(
          color: AppColors.white,
        ),
        contentType: contentType,
      ),
    );
    ScaffoldMessenger.of(globalNavigatorKey.currentContext!)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void hideAlertDialog() {
    Navigator.of(_context, rootNavigator: true).pop();
  }
}
