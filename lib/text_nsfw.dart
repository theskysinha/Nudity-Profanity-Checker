import 'package:flutter/material.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'image_nsfw.dart';

class TextNSFW extends StatefulWidget {
  const TextNSFW({super.key});

  @override
  State<TextNSFW> createState() => _MyTextNSFWState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyTextNSFWState extends State<TextNSFW> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  String display="";
  final filter = ProfanityFilter();
  final myController = TextEditingController();


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profanity Detector")),
      body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: myController,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                display = myController.text;
                if(isNSFW(display)){
                  myController.text = cleanText(display);
                }
              });
            },
            child: Text("Submit")),
            if (isNSFW(display)) ...[
              Padding(padding: EdgeInsets.fromLTRB(10, 25, 10, 10),
              child: Text("This text contains profanity")),
              Text('The words which were replaced by * were: ${getAllProfanity(display).toString()}'),
          ] else ...[
              Padding(padding: EdgeInsets.all(10),
              child: Text("This text does not contains profanity")),
          ]
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
              MaterialPageRoute(builder: (context) => ImageNSFW()),
            );
          },
          child: const Center(
            child: Text('Onto Nudity Detector'),
          ),
        ),
      ),
    );
  }

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