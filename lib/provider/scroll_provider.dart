import 'package:flutter/cupertino.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ScrollProvider extends ChangeNotifier {
  final scrollController = AutoScrollController();

  AutoScrollController get controller => scrollController;

  scroll(int index) async {
    await scrollController.scrollToIndex(index,
        preferPosition: AutoScrollPosition.begin);
  }
}
