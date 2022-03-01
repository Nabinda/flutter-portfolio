import 'package:flutter/material.dart';
import '/animation/on_hover.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class HeaderItems extends StatelessWidget {
  final String title;
  final bool isSelected;
  const HeaderItems({Key? key, required this.title,required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return OnHover(
          builder: (isHover) {
        final color = isHover ? Colors.red : Colors.black;
        return Transform(
          transform: Matrix4.skewX(-0.5),
          origin: const Offset(0, 0),
          child: AnimatedContainer(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            color: color,
            duration: const Duration(milliseconds: 600),
            curve: Curves.bounceIn,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                style: TextStyle(
                  color: isHover?Colors.white:isSelected?Colors.green:Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        );
      });
    } else {
      return MobileHeaderItems(title: title);
    }
  }
}

class MobileHeaderItems extends StatelessWidget {
  final String title;
  const MobileHeaderItems(
      {Key? key, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
      child: Transform(
        transform: Matrix4.skewX(-0.5),
        origin: const Offset(0, 0),
        child: AnimatedContainer(
          padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          color: Colors.red,
          duration: const Duration(milliseconds: 600),
          curve: Curves.bounceIn,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
