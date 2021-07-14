class Categorymodel {
  bool? status;
  Categorydata? data;
  Categorymodel.fromjson(Map json) {
    status = json["status"];
    data = Categorydata.fromjson(json["data"]);
  }
}

class Categorydata {
  int? current_page;
  List<Categorydatadata>? data = [];

  Categorydata.fromjson(Map json) {
    current_page = json["current_page"];

    json["data"].forEach((element) {
      data!.add(Categorydatadata.fromjson(element));
    });
  }

  // HomeDataModel.fromJson(Map<String, dynamic> json) {
  //   json['banners'].forEach((element) {
  //     banners.add(BannerModel.fromJson(element));
  //   });
}

class Categorydatadata {
  int? id;
  String? name;
  String? image;

  Categorydatadata.fromjson(Map json) {
    id = json["id"];
    name = json["name"];
    image = json["image"];
  }
}
