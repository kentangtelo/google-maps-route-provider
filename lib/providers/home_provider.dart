import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  TextEditingController originController = TextEditingController();
  String get originText => originController.text;

  set originText(String originText) {
    originController.text = originText;
    notifyListeners();
  }

  @override
  void dispose() {
    originController.dispose();
    super.dispose();
  }

  void testing() {
    print(originText);
  }
}
