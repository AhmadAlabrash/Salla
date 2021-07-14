import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/cubitsearch/states.dart';
import 'package:salla/model/searchmodel.dart';
import 'package:salla/network/diohelp.dart';

import 'package:salla/network/endpoints.dart';

class Cubitshopsearch extends Cubit<Stateshopsearch> {
  Cubitshopsearch() : super(Iniatialshopsearch());

  static Cubitshopsearch getdata(context) => BlocProvider.of(context);
  Searchmodel? searchdata;

  Future senddatasearch({
    @required word,
  }) async {
    emit(Loadingsearch());
    Dioshophelper.postdata(url: search, data: {
      'text': word,
    }).then((value) async {
      searchdata = await Searchmodel.fromJson(value.data);

      print(searchdata!.data);

      print(searchdata!.status);

      emit(Searchsuccess(searchdata));
    }).catchError((error) {
      emit(Searchfailed());
      print('iiiError beccccccccccc $error');
    });
  }
}
