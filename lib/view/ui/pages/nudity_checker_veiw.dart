import 'package:flutter/material.dart';
import 'package:nsfw_checker_app/controller/image_nsfw_controller.dart';
import 'package:nsfw_checker_app/view/ui/pages/profanity_checker_view.dart';

class ImageNSFWView extends StatefulWidget {
  const ImageNSFWView({Key? key});

  @override
  State<ImageNSFWView> createState() => _ImageNSFWViewState();
}

class _ImageNSFWViewState extends State<ImageNSFWView> {
  final ImageNSFWController _controller = ImageNSFWController();
  bool _isLoading = false;
  String res = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nudity Detector")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Center(
              child: ElevatedButton(
                onPressed: () async {
                  await _controller.getImageGallery();
                  setState(() {});
                },
                child: Text("Choose Image from Gallery"),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await _controller.getImageCamera();
              setState(() {});
            },
            child: Text("Choose Image from Camera"),
          ),
          ElevatedButton(
            onPressed: () async {
              setState(() {
                _isLoading = true;
              });
              res = await _controller.uploadImage(_controller.getImage());
              setState(() {
                _isLoading = false;
              });
            },
            child: Text("Upload Image"),
          ),
          if (res == "true")
            ...[
              Padding(
                padding: EdgeInsets.fromLTRB(10, 25, 10, 10),
                child: Text("This image contains nudity"),
              ),
            ]
          else if (res == "false")
            ...[
              Padding(
                padding: EdgeInsets.fromLTRB(10, 25, 10, 10),
                child: Text("This image does not contain nudity"),
              ),
            ]
          else
            ...[
              Padding(
                padding: EdgeInsets.fromLTRB(10, 25, 10, 10),
                child: Text(""),
              ),
            ],
          if (_isLoading) const CircularProgressIndicator(),
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
              MaterialPageRoute(builder: (context) => TextNSFWView()),
            );
          },
          child: const Center(
            child: Text('Back to Profanity Detector'),
          ),
        ),
      ),
    );
  }
} 
