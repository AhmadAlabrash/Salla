import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/model/classmodel.dart';
import 'package:salla/network/diohelp.dart';
import 'package:salla/network/endpoints.dart';
import 'package:salla/register/cubitregister/states.dart';

class Cubitshopregister extends Cubit<Stateshopregister> {
  Cubitshopregister() : super(Iniatialshop());

  static Cubitshopregister getdata(context) => BlocProvider.of(context);
  Showlogindata? logindata;

  senddataregister({
    @required name,
    @required phone,
    @required email,
    @required password,
  }) {
    Dioshophelper.postdata(url: register, data: {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password
    }).then((value) {
      print(value.data);
      logindata = Showlogindata.fromjs(value.data);
      print(logindata!.message);

      emit(Registersuccess(logindata));
    }).catchError((error) {
      emit(Registerfailed());
      print('Hi      iiiError beccccccccccc $error');
    });
  }
}
