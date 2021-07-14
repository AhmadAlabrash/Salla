import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salla/component/components.dart';
import 'package:salla/cubithome/cubithome.dart';
import 'package:salla/home.dart';
import 'package:salla/register/cubitregister/cubit.dart';
import 'package:salla/register/cubitregister/states.dart';
import 'package:salla/shared/cache.dart';
import 'package:salla/style/icon_broken.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Registerdata extends StatelessWidget {
  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var phonecontroller = TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Cubitshopregister, Stateshopregister>(
      listener: (BuildContext context, state) {
        if (state is Registersuccess) {
          if (state.la!.status == true) {
            Fluttertoast.showToast(
                msg: "${state.la!.message}",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 18.0);
            Sharedprefrenceslocal.putdata(
                    word: 'token', valueofword: state.la!.data!.token)
                .then((value) {
              Cubitshoplayout.getdata(context)
                  .gethomedata(state.la!.data!.token);
              Cubitshoplayout.getdata(context)
                  .getfavdata(token: state.la!.data!.token);

              Cubitshoplayout.getdata(context)
                  .getprofiledata(state.la!.data!.token);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Myhome()),
                  (route) => false);
            });
          } else {
            Fluttertoast.showToast(
                msg: "${state.la!.message}",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 18.0);
          }
        }
      },
      builder: (BuildContext context, Object? state) => Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Text('Register',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Now we will browse our online shop',
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                  SizedBox(
                    height: 50,
                  ),
                  defulttextform(
                      preficon: Icon(Neue.User),
                      label: 'Name',
                      control: namecontroller),
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
                  defulttextform(
                      preficon: Icon(Neue.Message),
                      label: 'Email Address',
                      control: emailcontroller),
                  SizedBox(
                    height: 20,
                  ),
                  defulttextform(
                      preficon: Icon(Neue.Password),
                      label: 'Password',
                      control: passwordcontroller,
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
                          if (formkey.currentState!.validate()) {
                            Cubitshopregister.getdata(context).senddataregister(
                                name: namecontroller.text,
                                phone: phonecontroller.text,
                                email: emailcontroller.text,
                                password: passwordcontroller.text);
                          }
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
