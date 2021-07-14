import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/cubit/cubit.dart';
import 'package:salla/cubit/state.dart';
import 'package:salla/cubithome/cubithome.dart';
import 'package:salla/home.dart';
import 'package:salla/login.dart';
import 'package:salla/network/diohelp.dart';
import 'package:salla/onboardingscreen.dart';
import 'package:salla/register/cubitregister/cubit.dart';
import 'package:salla/shared/cache.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Sharedprefrenceslocal.initshared();
  Dioshophelper.init();

  var onboarding = await Sharedprefrenceslocal.getdata(word: 'onboarding');

  String token = await Sharedprefrenceslocal.getdata(word: 'token');

  Widget startWidget;

  if (onboarding == true) {
    if (token == null) {
      startWidget = Login();
    } else {
      startWidget = Myhome();
    }
  } else {
    startWidget = Onboarding();
  }

  runApp(MyApp(startWidget, token));
}

class MyApp extends StatelessWidget {
  Widget start;
  String token;
  MyApp(this.start, this.token);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => Cubitshop(),
          ),
          BlocProvider(
              create: (BuildContext context) => Cubitshoplayout()
                ..getoken()
                ..getprofiledata(token)
                ..getcategorydata()
                ..getfavdata(token: token)
                ..gethomedata(token)),
          BlocProvider(
            create: (BuildContext context) => Cubitshopregister(),
          ),
        ],
        child: BlocConsumer<Cubitshop, Stateshop>(
            listener: (context, state) {},
            builder: (context, state) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: start,
                  theme: ThemeData(
                    textTheme: TextTheme(title: TextStyle(fontFamily: 'Jana')),
                    primarySwatch: Colors.purple,
                    scaffoldBackgroundColor: Colors.white,
                    bottomNavigationBarTheme: BottomNavigationBarThemeData(
                        elevation: 7, backgroundColor: Colors.white),
                    appBarTheme: AppBarTheme(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        iconTheme: IconThemeData(color: Colors.purple)),
                  ),
                  darkTheme: ThemeData(
                    primarySwatch: Colors.cyan,
                    scaffoldBackgroundColor: Colors.grey[600],
                    bottomNavigationBarTheme: BottomNavigationBarThemeData(
                        selectedItemColor: Colors.white,
                        elevation: 7,
                        backgroundColor: Colors.grey[400]),
                    appBarTheme: AppBarTheme(
                        backgroundColor: Colors.grey[400],
                        elevation: 0,
                        iconTheme: IconThemeData(color: Colors.black)),
                  ),
                  themeMode: ThemeMode.light,
                )));
  }
}
