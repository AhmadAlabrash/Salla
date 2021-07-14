import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class Dioshophelper {
  static Dio? dioaid;
  static init() {
    dioaid = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> postdata({
    @required Map<String, dynamic>? data,
    @required url,
    token,
  }) async {
    dioaid!.options.headers = {
      'Content-Type': 'application/json',
      'lang': 'en',
      'Authorization': token
    };
    return await dioaid!.post(url, data: data);
  }

  static Future<Response> getdata({
    @required url,
    token,
  }) async {
    dioaid!.options.headers = {
      'Content-Type': 'application/json',
      'lang': 'en',
      'Authorization': token
    };
    return await dioaid!.get(url);
  }
}
