import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/category/category.dart';
import 'package:salla/cubithome/cubithome.dart';
import 'package:salla/cubithome/statehome.dart';
import 'package:salla/favourite/favourite.dart';
import 'package:salla/products/product.dart';
import 'package:salla/search.dart';
import 'package:salla/settings/setting.dart';
import 'package:salla/style/icon_broken.dart';

class Myhome extends StatelessWidget {
  List<Widget> allhomescreen = [Product(), Category(), Favourite(), Setting()];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Cubitshoplayout, Statesshoplayout>(
      listener: (context, state) {
        if (state is Changenavbottom) {
          // Cubitshoplayout.getdata(context).gethomedata();
        }
      },
      builder: (context, state) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Salla',
            style: TextStyle(
                fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Neue.Search,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Search()));
                }),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: allhomescreen[Cubitshoplayout.getdata(context).currintindex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.purpleAccent,
          items: [
            BottomNavigationBarItem(icon: Icon(Neue.Home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Neue.Category), label: 'Category'),
            BottomNavigationBarItem(icon: Icon(Neue.Heart), label: 'Favorite'),
            BottomNavigationBarItem(
                icon: Icon(Neue.Setting), label: 'Settings'),
          ],
          currentIndex: Cubitshoplayout.getdata(context).currintindex,
          type: BottomNavigationBarType.fixed,
          onTap: (value) =>
              Cubitshoplayout.getdata(context).changebottom(value),
        ),
      ),
    );
  }
}
