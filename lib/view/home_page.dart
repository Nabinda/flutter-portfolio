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
  int activeIndex = 0;
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
      endDrawer:
          Responsive.isSmallScreen(context) ? appDrawer(context, height) : null,
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
        return Stack(
          children: [
            SingleChildScrollView(
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
                          MainHome(
                            currentIndex: activeIndex,
                            func: () {
                              setState(() {
                                activeIndex = 0;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    ///-----About Section-----
                    About(
                      currentIndex: activeIndex,
                      func: () {
                        setState(() {
                          activeIndex = 1;
                        });
                      },
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey.withOpacity(0.5),
                    ),

                    ///-----Skills Section-----
                    const Skills(),

                    ///-----Works Section-----
                    const Work(),
                    Divider(
                      thickness: 1,
                      color: Colors.grey.withOpacity(0.5),
                    ),

                    ///-----Contact Section-----
                    const Contact(),

                    ///-----Footer Section-----
                    const Footer()
                  ],
                )),
            Container(
                color: Colors.black,
                height: height * 0.1,
                child: header(context, height)),
          ],
        );
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

  Widget appDrawer(BuildContext context, double height) {
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
                return GestureDetector(
                  onTap: () {
                    //TODO:: Location offset properly
                    _scrollController.animateTo(
                        ((height + 30) * headerItems[index].index),
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn);
                    setState(() {
                      activeIndex = headerItems[index].index;
                    });
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: HeaderItems(
                      title: headerItems[index].title,
                      isSelected: activeIndex == headerItems[index].index
                          ? true
                          : false,
                    ),
                  ),
                );
              } else {
                return GestureDetector(
                    onTap: () {
                      _scrollController.animateTo(
                          ((height + 30) * headerItems[index].index),
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn);

                      setState(() {
                        activeIndex = headerItems[index].index;
                      });
                    },
                    child: HeaderItems(
                      title: headerItems[index].title,
                      isSelected: activeIndex == headerItems[index].index
                          ? true
                          : false,
                    ));
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

  Widget header(BuildContext context, double height) {
    return Responsive(
      largeScreen: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: buildHeader(context, height),
      ),
      smallScreen: buildMobileHeader(context),
      mediumScreen: buildHeader(context, height),
    );
  }

  // mobile header
  Widget buildMobileHeader(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const HeaderLogo(),
            GestureDetector(
              onTap: () {
                Scaffold.of(context).openEndDrawer();
              },
              child: const Icon(
                Icons.menu,
                color: Colors.white,
                size: 28.0,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context, double height) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const HeaderLogo(),
          menuItem(context, height),
        ],
      ),
    );
  }

  Widget menuItem(BuildContext context, double height) {
    final headerItems =
        Provider.of<HeaderProvider>(context, listen: false).getHeaderItem();
    return Row(
      children: headerItems
          .map((item) => GestureDetector(
                onTap: () {
                  _scrollController.animateTo(
                      ((height - height * 0.11) * item.index),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn);

                  setState(() {
                    activeIndex = item.index;
                  });
                },
                child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: HeaderItems(
                      title: item.title,
                      isSelected:
                          activeIndex == item.index ? true: false,
                    )),
              ))
          .toList(),
    );
  }
}
