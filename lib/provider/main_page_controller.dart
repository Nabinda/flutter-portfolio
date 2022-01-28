import 'package:flutter/material.dart';

class MainPageController extends ChangeNotifier{
  final PageController pageController = PageController();
  int selectedIndex = 0;
  void setSelectedIndex(int index){
    selectedIndex = index;
    pageController.jumpToPage(selectedIndex);
    notifyListeners();
  }
  int getIndex(){
    return selectedIndex;
  }
  PageController getController(){
    return pageController;
  }
  void disposeController(){
    pageController.dispose();
  }
}
