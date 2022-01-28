import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '/provider/authentication_provider.dart';
import '/provider/cv_provider.dart';
import '/provider/header_provider.dart';
import '/provider/main_page_controller.dart';
import '/provider/skill_provider.dart';
import '/view/admin_panel.dart';
import '/view/home_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
          options: kIsWeb?const FirebaseOptions(
              apiKey: "AIzaSyBYKu1JkcGneRqY4ia6v_913K4M7sqK3NE",
              authDomain: "portfolio-eb268.firebaseapp.com",
              projectId: "portfolio-eb268",
              storageBucket: "portfolio-eb268.appspot.com",
              messagingSenderId: "579196681339",
              appId: "1:579196681339:web:3c9ed83ceccb983bfb36de",
              measurementId: "G-JXW2CGV7TM"):null)
      .whenComplete(() {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HeaderProvider()),
        ChangeNotifierProvider(create: (_) => SkillProvider()),
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => MainPageController()),
        ChangeNotifierProvider(create: (_) => CVProvider()),
      ],
      child: MaterialApp(
        title: 'Nabin Dangol',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (ctx) => const HomePage(),
          AdminPanel.routeName: (ctx) => const AdminPanel(),
        },
      ),
    );
  }
}
