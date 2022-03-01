import 'package:flutter/material.dart';
import '/animation/fade_transition.dart';
import '/responsive.dart';

class About extends StatelessWidget {
  final VoidCallback func;
  final int currentIndex;
  const About({Key? key, required this.func, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
      smallScreen: smallScreen(),
      mediumScreen: midAndAboveScreen(context),
      largeScreen: midAndAboveScreen(context),
    );
  }

  Widget smallScreen(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 70),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          header(true),
          const SizedBox(
            height: 50,
          ),
          content()
        ],
      ),
    );
  }
  Widget midAndAboveScreen(BuildContext context){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 110),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.35,
              child: header(false)),
          Flexible(child: content())
        ],
      ),
    );
  }

  Widget header(bool isMobileView) {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w900,
            ),
            children: [
              const TextSpan(
                  text: "ABOUT",
                  style: TextStyle(
                    color: Colors.black,
                  )),
              TextSpan(text: isMobileView ? " " : "\n"),
              const TextSpan(
                text: "ME",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ]));
  }

  Widget content() {
    return CustomFadeTransition(
      content: RichText(
          textAlign: TextAlign.justify,
          text: const TextSpan(
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400,color: Colors.black),
              children: [
                TextSpan(
                    text:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                TextSpan(text: "\n\n\n"),
                TextSpan(
                    text:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
              ])),
      animationDuration: 500,
    );
  }
}
