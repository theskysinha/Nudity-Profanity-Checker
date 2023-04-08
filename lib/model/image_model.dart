class ImageModel {
  bool? unsafe;
  List<Objects>? objects;

  ImageModel({this.unsafe, this.objects});

  ImageModel.fromJson(Map<String, dynamic> json) {
    unsafe = json['unsafe'];
    if (json['objects'] != null) {
      objects = <Objects>[];
      json['objects'].forEach((v) {
        objects!.add(new Objects.fromJson(v));
      });
    }
  }
}

class Objects {
  List<int>? box;
  double? score;
  String? label;

  Objects({this.box, this.score, this.label});

  Objects.fromJson(Map<String, dynamic> json) {
    box = json['box'].cast<int>();
    score = json['score'];
    label = json['label'];
  }
}