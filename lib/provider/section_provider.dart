import 'package:flutter/material.dart';
import '/model/section.dart';
import '/widgets/about.dart';
import '/widgets/contact.dart';
import '/widgets/main_home.dart';
import '/widgets/skills.dart';
import '/widgets/work.dart';

class SectionProvider extends ChangeNotifier{
   final List<Section> _sections = [
    Section(key: GlobalKey(), title: "HOME", content: const MainHome()),
    Section(key: GlobalKey(), title: "ABOUT", content: const About()),
    Section(key: GlobalKey(), title: "SKILLS", content: const Skills()),
    Section(key: GlobalKey(), title: "WORKS", content: const Work()),
    Section(key: GlobalKey(), title: "CONTACT", content: const Contact()),
  ];

   List<Section> getSections(){
     return _sections;
   }
}

