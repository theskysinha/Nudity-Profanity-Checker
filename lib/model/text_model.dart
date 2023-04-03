import 'package:flutter/material.dart';
import 'package:profanity_filter/profanity_filter.dart';

class TextNSFWModel {
  final filter = ProfanityFilter();

  bool isNSFW(String text) {
    return filter.hasProfanity(text);
  }

  String cleanText(String text) {
    return filter.censor(text);
  }

  List<String> getAllProfanity(String text) {
    return filter.getAllProfanity(text);
  }
}
