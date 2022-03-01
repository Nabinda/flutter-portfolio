import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class OnHover extends StatefulWidget {
  final Widget Function(bool isHovered) builder;

  const OnHover({Key? key, required this.builder}) : super(key: key);

  @override
  _OnHoverState createState() => _OnHoverState();
}

class _OnHoverState extends State<OnHover> {

  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    final hovered = Matrix4.identity()..translate(0,-10,0);
    final transform = isHovered ? hovered : Matrix4.identity();
    if(kIsWeb) {
      return MouseRegion(
        onEnter: (_) => onEntered(true),
        onExit: (_) => onEntered(false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: transform,
          child: widget.builder(isHovered),
        ),
      );
    }else{
     return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: transform,
        child: widget.builder(isHovered),
      );
    }
  }

  void onEntered(bool isHovered){
    setState(() {
      this.isHovered = isHovered;
    });
  }
}
