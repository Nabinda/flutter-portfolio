import 'dart:async';

import 'package:flutter/material.dart';

class CustomFadeTransition extends StatefulWidget {
  final Widget content;
  final int animationDuration;
  const CustomFadeTransition({Key? key, required this.content,required this.animationDuration}) : super(key: key);

  @override
  _CustomFadeTransitionState createState() => _CustomFadeTransitionState();
}

class _CustomFadeTransitionState extends State<CustomFadeTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Timer _timer;
  @override
  void initState() {
    _animationController= AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.animationDuration)
    );
    _timer = Timer(Duration(milliseconds: widget.animationDuration),
        () => _animationController.forward());
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0,1),
        end: Offset.zero,
      ).animate(_animationController),
      child: FadeTransition(
        opacity: _animationController,
        child: widget.content,
      ),
    );
  }
}
