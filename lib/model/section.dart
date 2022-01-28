import 'package:flutter/cupertino.dart';

class Section{
  final GlobalKey key;
  final String title;
  final Widget content;
  Section({
    required this.key,
    required this.title,
    required this.content
});
}
