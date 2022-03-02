import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '/animation/on_hover.dart';
import '/provider/cv_provider.dart';
import '/responsive.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';

class MainHome extends StatefulWidget {
  final VoidCallback func;
  final int currentIndex;
  const MainHome({Key? key, required this.func, required this.currentIndex})
      : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  late double topMargin;
  late Timer _timer;
  late int index;
  String result = '';
  static const colorizeColors = [
    Colors.grey,
    Colors.blue,
    Colors.yellow,
    Colors.teal,
    Colors.pink,
    Colors.red,
    Colors.white
  ];
  void bounceButton(Timer t) async {
    setState(() {
      topMargin = topMargin == 80 ? 40 : 80;
    });
  }

  final String _headerText = "Hi! I am \n Nabin Dangol";
  final List<String> _quotes = [
    "Peace begins with a smile.",
    "All our dreams can come true if we have the courage to pursue them.",
    "Sometime proving yourself is an insult."
  ];
  late String displayQuote;
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    index = 0;
    displayQuote = _quotes[0];
    topMargin = 80;
    _timer = Timer.periodic(const Duration(seconds: 1), bounceButton);
  }

  changeQuotes() {
    if (index < _quotes.length - 1) {
      index++;
      setState(() {
        displayQuote = _quotes[index];
      });
    } else {
      index = 0;
      setState(() {
        displayQuote = _quotes[index];
      });
    }
  }

  processCV() async {
    if (kIsWeb) {
      String url =
          "https://drive.google.com/file/d/1Zjk_pPbIT7VOtk06xFm6POgsPr2iRMuW/view?usp=sharing";
      if (!await launch(
        url,
      )) {
        throw 'Could not launch $url';
      }
    } else {
      result = Provider.of<CVProvider>(context, listen: false).downloadCV();
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: kIsWeb ? height : height*0.72,
      padding: !kIsWeb ? const EdgeInsets.only(top: 20,left: 20,right: 20) :Responsive.isLargeScreen(context)
          ? const EdgeInsets.symmetric(horizontal: 100, vertical: 30)
          : Responsive.isMediumScreen(context)
              ? const EdgeInsets.symmetric(horizontal: 70, vertical: 30)
              : const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          image: kIsWeb?DecorationImage(
              repeat: ImageRepeat.noRepeat,
              alignment: Alignment.center,
              fit: BoxFit.contain,
              image: AssetImage("assets/images/profile.png")):null),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///If both name and button to bounce remove
          ///Sized box and insert mainAxisAlignment in Column
          kIsWeb?SizedBox(
            height: height * 0.25,
          ):Container(
            margin: const EdgeInsets.only(bottom: 30.0),
            child: Image.asset("assets/images/profile.png",alignment: Alignment.center,),
          ),
          AnimatedTextKit(
            repeatForever: true,
            isRepeatingAnimation: true,
            pause: const Duration(milliseconds: 50),
            animatedTexts: [
              !kIsWeb?ColorizeAnimatedText(
                "Hi! I am Nabin Dangol",
                colors: colorizeColors,
                textStyle: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
                speed: const Duration(milliseconds: 300),
              ):
              Responsive.isLargeScreen(context)
                  ? ColorizeAnimatedText(
                      _headerText,
                      colors: colorizeColors,
                      textStyle: const TextStyle(
                          fontSize: 72,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                      speed: const Duration(milliseconds: 300),
                    )
                  : Responsive.isMediumScreen(context)
                      ? ColorizeAnimatedText(
                          _headerText,
                          colors: colorizeColors,
                          textStyle: const TextStyle(
                              fontSize: 52,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                          speed: const Duration(milliseconds: 300),
                        )
                      : ColorizeAnimatedText(
                          _headerText,
                          colors: colorizeColors,
                          textStyle: const TextStyle(
                              fontSize: 36,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                          speed: const Duration(milliseconds: 300),
                        ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          AnimatedTextKit(
              isRepeatingAnimation: true,
              repeatForever: true,
              onNext: (index, bool bool) {
                if (bool) {
                  changeQuotes();
                }
              },
              totalRepeatCount: 0,
              animatedTexts: [
                TypewriterAnimatedText(displayQuote,
                    speed: const Duration(milliseconds: 120),
                    textStyle: const TextStyle(color: Colors.white))
              ]),
          button(context)
        ],
      ),
    );
  }

  Widget button(BuildContext context) {
    if (kIsWeb) {
      return InkWell(
        onTap: () {
          processCV();
        },
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          curve: Curves.decelerate,
          margin: EdgeInsets.only(top: topMargin),
          child: OnHover(builder: (isHover) {
            final color = isHover ? Colors.red : Colors.black;
            final borderColor = isHover ? Colors.redAccent : Colors.red;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              curve: Curves.slowMiddle,
              decoration: BoxDecoration(
                  color: color,
                  border: Border.all(color: borderColor, width: 3)),
              child: const FittedBox(
                fit: BoxFit.cover,
                child: Text(
                  "Download CV",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }),
        ),
      );
    } else {
      return InkWell(
        onTap: processCV,
        child: Container(
          margin: const EdgeInsets.only(top: 35),
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            decoration: BoxDecoration(
                color: Colors.red,
                border: Border.all(color: Colors.redAccent, width: 3)),
            child: const FittedBox(
              fit: BoxFit.cover,
              child: Text(
                "Download CV",
                style: TextStyle(color: Colors.white),
              ),
            )),
      );
    }
  }
}
