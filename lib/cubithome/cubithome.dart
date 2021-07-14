import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/cubithome/statehome.dart';
import 'package:salla/model/categorymodel.dart';
import 'package:salla/model/classmodel.dart';
import 'package:salla/model/favmodel.dart';
import 'package:salla/model/favouritemodel.dart';
import 'package:salla/model/homemodelabdallh.dart';
import 'package:salla/network/diohelp.dart';
import 'package:salla/network/endpoints.dart';
import 'package:salla/shared/cache.dart';

class Cubitshoplayout extends Cubit<Statesshoplayout> {
  Cubitshoplayout() : super(Iniatialshoplayout());

  static Cubitshoplayout getdata(context) => BlocProvider.of(context);
  HomeModel? allhomedata;
  Categorymodel? allcategorydata;
  Favouriteaddmodel? addfavourite;
  Favmodel? allmyfavourite;
  bool infavorite = false;
  Map favouriecubit = {};
  dynamic toke;
  var currintindex = 0;

  void changebottom(idpage) {
    currintindex = idpage;
    emit(Changenavbottom());
  }

  Future getoken() async {
    toke = await Sharedprefrenceslocal.getdata(word: 'token');
    print('$toke');
  }

  Future gethomedata(token) async {
    emit(Getdatahomeloading());
    Dioshophelper.getdata(url: home, token: token).then((value) async {
      allhomedata = HomeModel.fromJson(value.data);
      allhomedata!.data!.products.forEach((element) {
        favouriecubit.addAll({element.id: element.inFavorites});
      });
      print(favouriecubit);

      emit(Getdatahome());
    }).catchError((error) {
      emit(Getdatahomeerror());
      print('error becccccccccccc $error');
    });
  }

  void getcategorydata() {
    Dioshophelper.getdata(
      url: categories,
    ).then((value) {
      allcategorydata = Categorymodel.fromjson(value.data);

      emit(Getdatacategory());
    }).catchError((error) {
      emit(Getdatacategoryerror());
      print('error becccccccccccc $error');
    });
  }

  void getfavdata({token}) {
    emit(Getdatafavloading());
    Dioshophelper.getdata(url: favorites, token: token ?? toke).then((value) {
      allmyfavourite = Favmodel.fromJson(value.data);

      emit(Getdatafav());
      print('all my favourites are come ::::::::::');
      print('${allmyfavourite!.data!.data}');
    }).catchError((error) {
      emit(Getdatafaverror());
      print('error becccccccccccc hada anaa $error');
    });
  }

  void getsettingsdata(token) {
    Dioshophelper.getdata(url: settings, token: token).then((value) {
      allmyfavourite = Favmodel.fromJson(value.data);

      emit(Getdatafav());
      print('all my favourites are come ::::::::::');
      print('${allmyfavourite!.data!.data}');
    }).catchError((error) {
      emit(Getdatafaverror());
      print('error becccccccccccc hada anaa $error');
    });
  }

  Showlogindata? allprofiledata;
  void getprofiledata(token) {
    Dioshophelper.getdata(url: profile, token: token).then((value) {
      allprofiledata = Showlogindata.fromjs(value.data);

      emit(Getdataprofile());
      print('all my profile data are come ::::');
    }).catchError((error) {
      emit(Getdataprofileerror());
      print('error becccccccccccc hada anaa $error');
    });
  }

  void postfavourite({@required id, token}) {
    favouriecubit[id] = !favouriecubit[id];
    Dioshophelper.postdata(
            data: {'product_id': id}, url: favorites, token: toke)
        .then((value) {
      addfavourite = Favouriteaddmodel.fromJson(value.data);
      print(addfavourite!.message);
      print('مرحباااااا');
      if (addfavourite!.status == false) {
        favouriecubit[id] = !favouriecubit[id];
      } else {
        getfavdata();
        print('Data is updatef now :::::');
      }

      emit(Postfavourite());
    }).catchError((error) {
      emit(Postfavouriteerror());
    });
  }
}
