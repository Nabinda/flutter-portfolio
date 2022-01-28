import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class CVProvider extends ChangeNotifier {
  String downloadCV() {
    String result = '';
    FirebaseAuth.instance.signInAnonymously().then((_) async {
      final ref = FirebaseStorage.instance.ref('CV/resume.pdf');
      Directory appDocDir = await getApplicationDocumentsDirectory();
      File downloadToFile = File('${appDocDir.path}/CV.pdf');

      try {
        await ref.writeToFile(downloadToFile);
      } on FirebaseException catch (e) {
        result = e.code;
      }
    });
    return result;
  }
}
