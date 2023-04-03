import 'package:flutter/material.dart';
import 'package:nsfw_checker_app/view/ui/pages/nudity_checker_veiw.dart';
import '../../../model/text_model.dart';

class TextNSFWView extends StatefulWidget {
  const TextNSFWView({Key? key});

  @override
  State<TextNSFWView> createState() => _TextNSFWViewState();
}

class _TextNSFWViewState extends State<TextNSFWView> {
  final TextNSFWModel model = TextNSFWModel();
  String display = "";
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profanity Detector")),
      body: Column(
        children: [
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
                if (model.isNSFW(display)) {
                  myController.text = model.cleanText(display);
                }
              });
            },
            child: Text("Submit"),
          ),
          if (model.isNSFW(display))
            ...[
              Padding(
                padding: EdgeInsets.fromLTRB(10, 25, 10, 10),
                child: Text("This text contains profanity"),
              ),
              Text(
                  'The words which were replaced by * were: ${model.getAllProfanity(display).toString()}'),
            ]
          else
            ...[
              Padding(
                padding: EdgeInsets.all(10),
                child: Text("This text does not contain profanity"),
              ),
            ],
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
              MaterialPageRoute(builder: (context) => ImageNSFWView()),
            );
          },
          child: const Center(
            child: Text('Onto Nudity Detector'),
          ),
        ),
      ),
    );
  }
}