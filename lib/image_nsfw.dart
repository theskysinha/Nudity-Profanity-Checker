import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nsfw_checker_app/text_nsfw.dart';

class ImageNSFW extends StatefulWidget {
  const ImageNSFW({super.key});

  @override
  State<ImageNSFW> createState() => _MyImageNSFWState();
}

class _MyImageNSFWState extends State<ImageNSFW>{
  XFile? _image;
  String res = "";
  Dio dio = new Dio();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nudity Detector")),
    body: Column(
      children: [
        Padding(padding: EdgeInsets.fromLTRB(0, 10,0 ,0),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              getImageGallery();
          },
          child: Text("Choose Image from Gallery")),
        )),
        ElevatedButton(
          onPressed: () {
            getImageCamera();
          },
          child: Text("Choose Image from Camera")),
        ElevatedButton(
          onPressed: () {
            uploadImage(_image);
            setState(() {
              _isLoading=true;
            });
          },
          child: Text("Upload Image")),
          if(res == "true") ...[
            Padding(padding: EdgeInsets.fromLTRB(10, 25, 10, 10),
            child: Text("This image contains nudity")),
          ] else if(res == "false")...[
            Padding(padding: EdgeInsets.fromLTRB(10, 25, 10, 10),
            child: Text("This image does not contain nudity")),
          ] else...[
            Padding(padding: EdgeInsets.fromLTRB(10, 25, 10, 10),
            child: Text("")),
          ],
          if(_isLoading)
          const CircularProgressIndicator(),
        ],
      ),
    floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TextNSFW()),
            );
          },
          child: const Center(
            child: Text('Back to Profanity Detector'),
          ),
        ),
      ),
    );
  }

  void uploadImage(XFile? file) async {
    String fileName = file!.path.split('/').last;
    FormData formData = FormData.fromMap({"image": await MultipartFile.fromFile(file.path, filename:fileName),
    });
    String endPoint = "https://nsfw-images-detection-and-classification.p.rapidapi.com/adult-content-file";
    dio.options.headers['X-RapidAPI-Key'] = '48baaa321emsh10ce063e09ad399p1c5029jsn16dbc0fcae3a';
    dio.options.headers['X-RapidAPI-Host'] = 'nsfw-images-detection-and-classification.p.rapidapi.com';
    var response = await dio.post(endPoint, data: formData);
    res = response.data['unsafe'].toString();
    setState(() {
      _isLoading=false;
    });
    
}

  getImageGallery() async {
    XFile? imageFile;
    imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = imageFile;
    });
  }

  getImageCamera() async {
    XFile? imageFile;
    imageFile = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _image = imageFile;
    });
  }
}