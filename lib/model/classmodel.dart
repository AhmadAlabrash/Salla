class Showlogindata {
  bool? status;
  String? message;
  Showlogindataperson? data;

  Showlogindata.fromjs(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] != null
        ? Showlogindataperson.fromjson(json["data"])
        : null;
  }
}

class Showlogindataperson {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  Showlogindataperson.fromjson(Map<String, dynamic> data) {
    id = data["id"];
    name = data["name"];
    email = data["email"];
    phone = data["phone"];
    points = data["points"];
    credit = data["credit"];
    token = data["token"];
  }
}
