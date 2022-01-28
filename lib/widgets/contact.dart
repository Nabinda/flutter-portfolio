import 'package:flutter/material.dart';
import '/responsive.dart';
import '/widgets/contact_form.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatelessWidget {
  const Contact({Key? key}) : super(key: key);

  static const String _githubUrl = 'https://github.com/Nabinda';
  static const String _facebookUrl =
      'https://www.facebook.com/nabin.dangol.9400';
  static const String _instaUrl = 'https://www.instagram.com/nabin.zzy/';
  static const String _linkedinUrl =
      'https://www.linkedin.com/in/nabin-dangol-8968b8187';
  void _openGithub() async {
    if (await canLaunch(_githubUrl)) {
      await launch(_githubUrl);
    } else {
      throw 'Could not launch ';
    }
  }



  void _openFacebook() async {
    if (await canLaunch(_facebookUrl)) {
      await launch(_facebookUrl);
    } else {
      throw 'Could not launch ';
    }
  }

  void _openInsta() async {
    if (await canLaunch(_instaUrl)) {
      await launch(_instaUrl);
    } else {
      throw 'Could not launch ';
    }
  }

  void _openLinkedin() async {
    if (await canLaunch(_linkedinUrl)) {
      await launch(_linkedinUrl);
    } else {
      throw 'Could not launch ';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 70),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          header(),
          const SizedBox(
            height: 50,
          ),
          content(context)
        ],
      ),
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
                  text: "CONTACT",
                  style: TextStyle(
                    color: Colors.black,
                  )),
              TextSpan(
                text: " ME",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ]));
  }

  Widget content(BuildContext context) {
    return Responsive.isLargeScreen(context)
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              contactForm(context),
              Column(
                children: const [
                  SizedBox(
                    height: 200,
                  ),
                  Text("OR,",style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.w600
                  ),),
                ],
              ),
              socialsHandle(context)
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              contactForm(context),
              const SizedBox(
                height: 30,
              ),
              const Text("OR",style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.w600
              ),),
              const SizedBox(
                height: 30,
              ),
              socialsHandle(context),
            ],
          );
  }

  Widget contactForm(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width < 1200
            ? MediaQuery.of(context).size.width * 0.8
            : MediaQuery.of(context).size.width * 0.5,
        child: const ContactForm());
  }

  Widget socialsHandle(BuildContext context) {
    List<ConnectSocial> _social = [
      ConnectSocial(link: _openGithub, imagePath: "assets/images/github.png"),
      ConnectSocial(link: _openFacebook, imagePath: "assets/images/fb.png"),
      ConnectSocial(
          link: _openLinkedin, imagePath: "assets/images/linkedin.png"),
      ConnectSocial(link: _openInsta, imagePath: "assets/images/insta.png"),
    ];
    return Column(
      children: [
        const Text("You can find me on",style: TextStyle(
            color: Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.w600
        ),),
        const SizedBox(
          height: 18,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width < 1200
              ? MediaQuery.of(context).size.width * 0.8
              : MediaQuery.of(context).size.width * 0.3,
          child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
            return GridView.builder(
                itemCount: _social.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        MediaQuery.of(context).size.width < 1200 ? 4 : 2,
                    childAspectRatio: 1,
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: 20.0),
                itemBuilder: (ctx, index) {
                  return GestureDetector(
                    onTap: _social[index].link,
                    child: Image.asset(_social[index].imagePath),
                  );
                });
          }),
        ),
      ],
    );
  }
}

class ConnectSocial {
  final String imagePath;
  final VoidCallback link;
  ConnectSocial({required this.link, required this.imagePath});
}
