import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  late String _name;
  late String _contact;
  late String _email;
  late String _message;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _contactController.dispose();
    _emailController.dispose();
    _messageController.dispose();
  }

  void _send() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final Uri emailLaunchUri = Uri(
          scheme: 'mailto',
          path: 'nabindangol2@gmail.com',
          query:
              'subject=Message from Portfolio Website&body=Name: $_name\nContact: $_contact\nEmail:$_email\nMessage:$_message');
      String url = emailLaunchUri.toString();
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.withOpacity(0.3),
              ),
              child: TextFormField(
                controller: _nameController,
                onSaved: (value) {
                  _name = value!;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                ],
                validator: (value) {
                  if (_nameController.text.length < 5) {
                    return 'Name not long enough';
                  }
                  if (_nameController.text.trim() == "") {
                    return 'Field should not be empty';
                  }
                  return null;
                },
                cursorColor: Colors.black.withOpacity(0.8),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Full Name",
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.withOpacity(0.3),
              ),
              child: TextFormField(
                controller: _contactController,
                onSaved: (value) {
                  _contact = value!;
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                ],
                validator: (value) {
                  if (_contactController.text.length != 10) {
                    return 'Invalid Number Length';
                  }
                  if (_nameController.text.trim() == "") {
                    return 'Field should not be empty';
                  }
                  return null;
                },
                cursorColor: Colors.black.withOpacity(0.8),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Contact",
                  prefixIcon: Icon(
                    Icons.call,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.withOpacity(0.3),
              ),
              child: TextFormField(
                controller: _emailController,
                onSaved: (value) {
                  _email = value!;
                },
                validator: (value) {
                  if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(_emailController.text)) {
                    return 'Invalid Email';
                  }
                  if (_nameController.text.trim() == "") {
                    return 'Field should not be empty';
                  }
                  return null;
                },
                cursorColor: Colors.black.withOpacity(0.8),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Email",
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.withOpacity(0.3),
              ),
              child: TextFormField(
                cursorColor: Colors.black.withOpacity(0.8),
                controller: _messageController,
                onSaved: (value) {
                  _message = value!;
                },
                validator: (value) {
                  if (_messageController.text.trim() == "") {
                    return 'Field should not be empty';
                  }
                  return null;
                },
                maxLines: 10,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Write a message....",
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(vertical: 15),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              height: 50,
              child: TextButton(
                onPressed: _send,
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => Colors.transparent),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.red.withOpacity(0.8),
                  ),
                  child: const Text(
                    'Send',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
