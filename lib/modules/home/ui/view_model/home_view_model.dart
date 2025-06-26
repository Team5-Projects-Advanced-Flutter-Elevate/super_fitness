import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeViewModel extends ChangeNotifier {
  ValueNotifier<int> currentPageIndexNotifier = ValueNotifier(0);
  PageController pageViewController = PageController();

  void navigateToPage(int index) {
    currentPageIndexNotifier.value = index;
    pageViewController.jumpToPage(index);
  }
}
