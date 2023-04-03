import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class ImageNSFWModel {
  XFile? _image;
  String res = "";
  Dio dio = new Dio();

  Future<String> uploadImage(XFile? file) async {
    String fileName = file!.path.split('/').last;
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(file.path, filename: fileName),
    });
    String endPoint =
        "https://nsfw-images-detection-and-classification.p.rapidapi.com/adult-content-file";
    dio.options.headers['X-RapidAPI-Key'] =
        '48baaa321emsh10ce063e09ad399p1c5029jsn16dbc0fcae3a';
    dio.options.headers['X-RapidAPI-Host'] =
        'nsfw-images-detection-and-classification.p.rapidapi.com';
    var response = await dio.post(endPoint, data: formData);
    res = response.data['unsafe'].toString();
    return res;
  }

  Future<XFile?> getImageGallery() async {
    XFile? imageFile;
    imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    _image = imageFile;
    return imageFile;
  }

  Future<XFile?> getImageCamera() async {
    XFile? imageFile;
    imageFile = await ImagePicker().pickImage(source: ImageSource.camera);
    _image = imageFile;
    return imageFile;
  }

  XFile? getImage() {
    return _image;
  }
}
