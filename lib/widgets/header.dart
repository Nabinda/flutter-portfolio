import 'package:flutter/material.dart';
import '/provider/authentication_provider.dart';
import '/view/admin_panel.dart';
import 'package:provider/provider.dart';

class HeaderLogo extends StatefulWidget {
  const HeaderLogo({Key? key}) : super(key: key);

  @override
  State<HeaderLogo> createState() => _HeaderLogoState();
}

class _HeaderLogoState extends State<HeaderLogo> {
  final _key = GlobalKey<FormState>();
  late String _email;
  late String _password;

  void _login() async {
    _key.currentState?.save();
    var result =
        await Provider.of<AuthenticationProvider>(context, listen: false)
            .login(_email, _password);
    if (result == "Success") {
      Navigator.pop(context);
      Navigator.of(context).pushNamed(AdminPanel.routeName);
    } else {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(result),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK")),
            ],
          );
        },
      );
    }
  }

  Future _forgetPassword() {
    String errorText = "USE BRAIN DON'T BE DUMB.\n SHAME ON YOU! FUCK OFF";
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("DUDE!!!"),
          content: Text(errorText),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("SORRY")),
          ],
        );
      },
    );

  }

  @override
  Widget build(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: const Text("Admin Login"),
      content: SizedBox(
        height: 120,
        child: Form(
            key: _key,
            child: Column(
              children: [
                TextFormField(
                  onSaved: (value) {
                    _email = value!;
                  },
                  decoration: const InputDecoration(hintText: "Email"),
                ),
                TextFormField(
                  onSaved: (value) {
                    _password = value!;
                  },
                  obscureText: true,
                  decoration: const InputDecoration(hintText: "Password"),
                ),
              ],
            )),
      ),
      actions: [
        TextButton(onPressed: _login, child: const Text("Login")),
        TextButton(
            onPressed: _forgetPassword, child: const Text("Forget Password")),
      ],
    );
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      child: GestureDetector(
          onLongPressEnd: (details) {
            print(details.globalPosition.dx);
            if (details.globalPosition.dx < 5) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );
            }
          },
          child: Image.asset('assets/images/logo.png')),
    );
  }
}

