import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salla/component/components.dart';
import 'package:salla/cubithome/cubithome.dart';
import 'package:salla/cubithome/statehome.dart';
import 'package:salla/login.dart';
import 'package:salla/shared/cache.dart';
import 'package:salla/style/icon_broken.dart';

class Setting extends StatelessWidget {
  dynamic namecontroller = TextEditingController();
  dynamic emailcontroller = TextEditingController();
  dynamic phonecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Cubitshoplayout, Statesshoplayout>(
        listener: (context, state) {
      {}
    }, builder: (context, state) {
      return ConditionalBuilder(
        condition: Cubitshoplayout.getdata(context).allprofiledata != null,
        builder: (BuildContext context) {
          namecontroller.text =
              Cubitshoplayout.getdata(context).allprofiledata!.data!.name;

          emailcontroller.text =
              Cubitshoplayout.getdata(context).allprofiledata!.data!.email;

          phonecontroller.text =
              Cubitshoplayout.getdata(context).allprofiledata!.data!.phone;
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                defulttextform(
                    preficon: Icon(Neue.User),
                    label: 'Name',
                    control: namecontroller),
                SizedBox(
                  height: 20,
                ),
                defulttextform(
                    preficon: Icon(Neue.Message),
                    label: 'Email Address',
                    control: emailcontroller),
                SizedBox(
                  height: 20,
                ),
                defulttextform(
                    preficon: Icon(Neue.Call),
                    label: 'Phone',
                    control: phonecontroller,
                    invisible: false),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 60,
                  color: Colors.purple,
                  child: TextButton(
                      onPressed: () {
                        Fluttertoast.showToast(
                            msg: "LogOut Done Successfuly",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 18.0);
                        Sharedprefrenceslocal.cleardata(word: 'token').then(
                            (value) => Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                                (route) => false));
                      },
                      child: Text(
                        'LogOut',
                        style: TextStyle(fontSize: 24, color: Colors.black),
                      )),
                )
              ],
            ),
          );
        },
        fallback: (context) => Center(child: CircularProgressIndicator()),
      );
    });
  }
}
