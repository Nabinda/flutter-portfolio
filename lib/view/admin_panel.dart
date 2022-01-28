import 'package:flutter/material.dart';
import '/provider/authentication_provider.dart';
import '/responsive.dart';
import '/widgets/admin_menu_items.dart';
import '/widgets/admin_widgets/about_me.dart';
import '/widgets/admin_widgets/cv.dart';
import '/widgets/admin_widgets/photo.dart';
import '/widgets/admin_widgets/quotes.dart';
import '/widgets/admin_widgets/skills.dart';
import '/widgets/admin_widgets/social_links.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'home_page.dart';

class AdminPanel extends StatefulWidget {
  static const routeName = "/admin_panel";
  const AdminPanel({Key? key}) : super(key: key);

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  int selectedIndex = 0;
  late bool status;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final PageController _pageController = PageController();
  final List<AdminMenu> _menuItems = [
    AdminMenu(imagePath: "assets/images/gallery.png", title: "Photo"),
    AdminMenu(imagePath: "assets/images/about-me.jpg", title: "About Me"),
    AdminMenu(imagePath: "assets/images/skills.png", title: "Skills"),
    AdminMenu(imagePath: "assets/images/cv.png", title: "CV"),
    AdminMenu(imagePath: "assets/images/quote.png", title: "Quotes"),
    AdminMenu(imagePath: "assets/images/social_icon.png", title: "Social Links")
  ];
  bool isMinimized = false;
  @override
  void initState() {
    status = true;
    status = Provider.of<AuthenticationProvider>(context, listen: false)
        .getLogInStatus();
    // if (!status) {
    //   WidgetsBinding.instance?.addPostFrameCallback((_) {
    //     Navigator.pushReplacementNamed(context, HomePage.routeName);
    //   });
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return status
        ? Scaffold(
            key: _key,
            drawer:
                Responsive.isSmallScreen(context) ? appDrawer(context) : null,
            body: Container(
              height: height,
              width: width,
              color: Colors.black87,
              child: Responsive.isSmallScreen(context)
                  ? mobileBuild()
                  : midAndAboveScreenBuild(context),
            ),
          )
        : Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: const Color(0xff303030),
              child: const Center(
                child: Text(
                  "HAHAHAHAHAHAHA",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                  ),
                ),
              ),
            ),
          );
  }

  Widget mobileBuild() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 40, left: 30),
          child: GestureDetector(
            onTap: () {
              _key.currentState?.openDrawer();
            },
            child: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 28.0,
            ),
          ),
        ),
        content()
      ],
    );
  }

  Widget content() {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
          color: const Color(0xff171717),
          borderRadius: BorderRadius.circular(20)),
      margin: kIsWeb
          ? const EdgeInsets.all(40.0)
          : const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 45.0, bottom: 20.0),
      padding:  kIsWeb
          ? const EdgeInsets.all(40.0)
          : const EdgeInsets.all(20.0),
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          Photo(),
          AboutMe(),
          Skills(),
          CV(),
          Quotes(),
          SocialLinks()
        ],
      ),
    ));
  }

  Widget midAndAboveScreenBuild(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          color: const Color(0xff171717),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
          child: menuItems(context),
        ),
        content()
      ],
    );
  }

  Widget appDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xff171717),
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 30),
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 24.0,
          ),
          child: menuItems(context),
        ),
      ),
    );
  }

  Widget menuItems(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
          child: InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const HomePage(),
                ),
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: Image.asset('assets/images/logo.png'),
                ),
                const Text(
                  "NABIN DANGOL",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
        ),
        Container(
          height: 2,
          width: Responsive.isSmallScreen(context) ? width * 0.8 : 255,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: const BoxDecoration(
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: Responsive.isSmallScreen(context) ? width * 0.8 : 255,
          height: 80 * _menuItems.length.toDouble(),
          child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    if (!kIsWeb) {
                      Navigator.pop(context);
                    }
                    setState(() {
                      selectedIndex = index;
                      _pageController.jumpToPage(index);
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    color: selectedIndex == index
                        ? Colors.red.withOpacity(0.7)
                        : Colors.transparent,
                    height: 45,
                    width: 255,
                    child: Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          width: 5,
                          height: selectedIndex == index ? 45 : 0,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        AdminMenuItems(
                          imagePath: _menuItems[index].imagePath,
                          title: _menuItems[index].title,
                          isMinimized: isMinimized,
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: _menuItems.length),
        )
      ],
    );
  }
}

class AdminMenu {
  final String imagePath;
  final String title;
  AdminMenu({required this.imagePath, required this.title});
}
