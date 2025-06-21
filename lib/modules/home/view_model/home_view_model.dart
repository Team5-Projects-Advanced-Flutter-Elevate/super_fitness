import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeViewModel extends ChangeNotifier {
  ValueNotifier<int> currentPageIndexNotifier = ValueNotifier(0);
  PageController pageViewController = PageController();
}
