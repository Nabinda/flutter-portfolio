import 'package:flutter/material.dart';
import '/model/skill_model.dart';

class SkillProvider extends ChangeNotifier{
    final List<SkillModel> _skills =  [
      SkillModel(title: "PYTHON", progress: 40, colors: Colors.purple),
      SkillModel(title: "HTML & CSS", progress: 50, colors: Colors.red),
      SkillModel(title: "FLUTTER", progress: 60, colors: Colors.lime),
      SkillModel(title: "C PROGRAMMING", progress: 45, colors: Colors.teal),
      SkillModel(title: "PHP", progress: 40, colors: Colors.indigo),
    ];

    List<SkillModel> getSkills(){
      return _skills;
    }
}
