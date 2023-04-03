import 'package:flutter/material.dart';
import '../../model/text_model.dart';
import '../view/ui/pages/nudity_checker_veiw.dart';
import '../view/ui/pages/profanity_checker_view.dart';

class TextNSFWController {
  late TextNSFWView _view;
  late TextNSFWModel _model;

  TextNSFWController() {
    _model = TextNSFWModel();
  }

  void bindView(TextNSFWView view) {
    _view = view;
  }

  bool isNSFW(String text) {
    return _model.isNSFW(text);
  }

  String cleanText(String text) {
    return _model.cleanText(text);
  }

  List<String> getAllProfanity(String text) {
    return _model.getAllProfanity(text);
  }

  void navigateToImageNSFWView(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ImageNSFWView()),
    );
  }

  void dispose() {}
}
