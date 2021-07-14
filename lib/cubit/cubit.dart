import 'package:bloc/bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/cubit/state.dart';
import 'package:salla/model/classmodel.dart';
import 'package:salla/network/diohelp.dart';
import 'package:salla/network/endpoints.dart';

class Cubitshop extends Cubit<Stateshop> {
  Cubitshop() : super(Iniatialstartshop());

  static Cubitshop getdata(context) => BlocProvider.of(context);
  Showlogindata? logindata;

  senddatalogin({
    @required email,
    @required password,
  }) {
    Dioshophelper.postdata(
        url: login, data: {'email': email, 'password': password}).then((value) {
      print(value);
      logindata = Showlogindata.fromjs(value.data);
      print(logindata!.message);

      emit(Loginsuccess(logindata));
    }).catchError((error) {
      emit(Loginfailed());
      print('Error beccccccccccc $error');
    });
  }
}
