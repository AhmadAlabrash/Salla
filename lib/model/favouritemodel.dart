class Favouriteaddmodel {
  bool? status;
  String? message;

  Favouriteaddmodel.fromJson(Map json) {
    status = json["status"];
    message = json["message"];
  }
}
