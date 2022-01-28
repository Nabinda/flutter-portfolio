import 'package:flutter/material.dart';
import '/provider/header_provider.dart';
import '/widgets/about.dart';
import '/widgets/contact.dart';
import '/widgets/footer.dart';
import '/widgets/header.dart';
import '/widgets/header_items.dart';
import '/widgets/main_home.dart';
import '/widgets/skills.dart';
import '/widgets/work.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../responsive.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/";
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late bool _showBackToTopButton;

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _showBackToTopButton = false;
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  @override
  void dispose() {
    _scrollController.dispose(); // dispose the controller
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _key,
      endDrawer: Responsive.isSmallScreen(context) ? appDrawer(context) : null,
      body: Builder(builder: (context) {
        _scrollController = ScrollController()
          ..addListener(() {
            setState(() {
              if (_scrollController.offset >= 250) {
                _showBackToTopButton = true; // show the back-to-top button
              } else {
                _showBackToTopButton = false; // hide the back-to-top button
              }
            });
          });
        return SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                ///----Main Page------
                Container(
                  key: const Key("MainPage"),
                  height: kIsWeb ? height : height * 0.8,
                  width: width,
                  color: Colors.black,
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.15, child: const Header()),
                      SizedBox(
                          height: kIsWeb ? height * 0.85 : height * 0.65,
                          child: const MainHome()),
                    ],
                  ),
                ),

                ///-----About Section-----
                const About(),

                ///-----Skills Section-----
                const Skills(),

                ///-----Works Section-----
                const Work(),

                ///-----Contact Section-----
                const Contact(),

                ///-----Footer Section-----
                const Footer()
              ],
            ));
      }),
      floatingActionButton: _showBackToTopButton == false
          ? null
          : FloatingActionButton(
              onPressed: _scrollToTop,
              backgroundColor: Colors.red,
              child: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
    );
  }

  Widget appDrawer(BuildContext context) {
    final headerItems =
    Provider.of<HeaderProvider>(context, listen: false).getHeaderItem();
    return Drawer(
      backgroundColor: Colors.black,
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 30),
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 24.0,
          ),
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              if (kIsWeb) {
                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: HeaderItems(title: headerItems[index].title),
                );
              } else {
                return HeaderItems(title: headerItems[index].title);
              }
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 10.0,
              );
            },
            itemCount: headerItems.length,
          ),
        ),
      ),
    );
  }
}

