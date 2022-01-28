import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class Work extends StatelessWidget {
  const Work({Key? key}) : super(key: key);
  static const String _url = 'https://github.com/Nabinda';
  _openGithub() async {
    if (await canLaunch(_url)) {
      await launch(_url);
    } else {
      throw 'Could not launch ';
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 70),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: [
              header(),
              const SizedBox(
                height: 50,
              ),
              content(width),
            ],
          ),
        ),
        Divider(
          thickness: 1,
          color: Colors.grey.withOpacity(0.5),
        ),
      ],
    );
  }

  Widget header() {
    return RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w900,
            ),
            children: [
              TextSpan(
                  text: "MY",
                  style: TextStyle(
                    color: Colors.black,
                  )),
              TextSpan(
                text: " WORKS",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ]));
  }

  Widget content(double width) {
    return SizedBox(
      height: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: width * 0.6,
            child: Shimmer.fromColors(
              baseColor: Colors.red,
              highlightColor: Colors.green,
              child: const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'All I have done is some projects to learn, \n you can check it on my github profile',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: width*0.3,
            child: TextButton(
              child: const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Github Link",
                    style: TextStyle(
                      fontSize: 32.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
              onPressed: _openGithub,
            ),
          )
        ],
      ),
    );
  }
}
