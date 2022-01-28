import 'package:flutter/material.dart';

class AdminMenuItems extends StatelessWidget {
  final String imagePath;
  final String title;
  final bool isMinimized;
  const AdminMenuItems(
      {Key? key,
      required this.imagePath,
      required this.title,
      required this.isMinimized
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: const BoxDecoration(
        color: Colors.transparent
      ),
      child: Row(
        children: [
          Image.asset(imagePath,color: Colors.green,height: 30,),
          const SizedBox(width: 20,),
          Text(title,style: const TextStyle(
            color: Colors.white
          ),)
        ],
      ),
    );
  }
}
