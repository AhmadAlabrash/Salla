import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sharedprefrenceslocal {
  static SharedPreferences? sharedit;

  static Future initshared() async {
    sharedit = await SharedPreferences.getInstance();
  }

  static Future putdata({
    @required word,
    @required dynamic valueofword,
  }) async {
    if (valueofword is String) {
      return await sharedit!.setString(word, valueofword);
    }

    if (valueofword is int) {
      return await sharedit!.setInt(word, valueofword);
    }

    if (valueofword is bool) {
      return await sharedit!.setBool(word, valueofword);
    }

    if (valueofword is double) {
      return await sharedit!.setDouble(word, valueofword);
    }
  }

  static Future getdata({@required word}) async {
    return await sharedit!.get(word);
  }

  static Future cleardata({@required word}) async {
    return await sharedit!.remove(word);
  }
}
