import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salla/component/components.dart';
import 'package:salla/cubit/cubit.dart';
import 'package:salla/cubit/state.dart';
import 'package:salla/cubithome/cubithome.dart';
import 'package:salla/register/register.dart';
import 'package:salla/shared/cache.dart';
import 'package:salla/style/icon_broken.dart';

import 'home.dart';

class Login extends StatelessWidget {
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Cubitshop, Stateshop>(
      listener: (context, state) {
        if (state is Loginsuccess) {
          if (state.la!.status == true) {
            Fluttertoast.showToast(
                msg: "${state.la!.message}",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.black,
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
      builder: (context, state) => Expanded(
        child: Scaffold(
          appBar: AppBar(
              // title: Text(
              //   'LogIn',
              //   style: TextStyle(color: Colors.black),
              // ),
              ),
          body: Form(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                //  physics: NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.13,
                    ),
                    Text('LogIn',
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
                      preficon: Icon(Neue.Message),
                      label: 'Email',
                      control: emailcontroller,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defulttextform(
                        preficon: Icon(Neue.Password),
                        label: 'Password',
                        control: passwordcontroller,
                        suficon: Icon(Neue.Lock),
                        invisible: true),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      color: Colors.purple,
                      child: TextButton(
                        onPressed: () {
                          Cubitshop.getdata(context).senddatalogin(
                              email: emailcontroller.text,
                              password: passwordcontroller.text);
                        },
                        child: Text(
                          'LOGIN',
                          style: TextStyle(color: Colors.black, fontSize: 22),
                        ),
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'You do not have account ?',
                            style: TextStyle(color: Colors.black),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Registerdata()),
                                  (route) => false);
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(color: Colors.purpleAccent),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
