import 'dart:async';

import 'package:flutter/material.dart';

class CustomSideTransition extends StatefulWidget {
  final Widget content;
  final int duration;
  const CustomSideTransition(
      {Key? key, required this.content, this.duration = 2000})
      : super(key: key);

  @override
  _CustomSideTransitionState createState() => _CustomSideTransitionState();
}

class _CustomSideTransitionState extends State<CustomSideTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Timer _timer;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.duration));
    _timer = Timer(Duration(milliseconds: widget.duration),
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
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(_animationController),
      child: FadeTransition(
        opacity: _animationController,
        child: widget.content,
      ),
    );
  }
}
