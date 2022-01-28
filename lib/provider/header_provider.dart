import 'package:flutter/material.dart';
import '/model/header_model.dart';

class HeaderProvider extends ChangeNotifier{
    final List<HeaderModel> _headerList = [
      HeaderModel(title: "HOME", index: 0),
      HeaderModel(title: "ABOUT", index: 1),
      HeaderModel(title: "SKILLS", index: 2),
      HeaderModel(title: "WORKS", index: 3),
      HeaderModel(title: "CONTACT", index: 4),
    ];
    //TODO:: Scroll Controls

    List<HeaderModel> getHeaderItem(){
      return _headerList;
    }
}
