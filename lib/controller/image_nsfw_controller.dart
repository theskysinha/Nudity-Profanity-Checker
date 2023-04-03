import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../model/image_model.dart';
import '../view/ui/pages/nudity_checker_veiw.dart';
import '../view/ui/pages/profanity_checker_view.dart';


class ImageNSFWController {
  late ImageNSFWView _view;
  late ImageNSFWModel _model;

  ImageNSFWController() {
    _model = ImageNSFWModel();
  }

  void bindView(ImageNSFWView view) {
    _view = view;
  }

  Future<XFile?> getImageGallery() async {
    return await _model.getImageGallery();
  }

  Future<XFile?> getImageCamera() async {
    return await _model.getImageCamera();
  }

  Future<String> uploadImage(XFile? file) async {
    return await _model.uploadImage(file);
  }

  void navigateToTextNSFWView(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TextNSFWView()),
    );
  }

  void dispose() {}
}
