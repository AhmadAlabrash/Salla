import 'package:flutter/material.dart';
import 'package:salla/component/components.dart';
import 'package:salla/login.dart';
import 'package:salla/model/models.dart';
import 'package:salla/shared/cache.dart';

class Onboarding extends StatelessWidget {
  List<Pageviewitems> listpages = [
    Pageviewitems(
        title: 'Welcome',
        content: 'We Are Now Going To Browse The shop',
        urlimage:
            'https://thumbs.dreamstime.com/b/store-shop-front-view-vector-illustration-cartoon-line-outline-storefront-street-isolated-white-background-94312651.jpg'),
    Pageviewitems(
        title: 'Hope You Enjoy',
        content: 'We Have A lot Of Things you Are Need To It',
        urlimage:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTr-n6ME7g8a8nxOXduJcvt9epJcV9s6EXHMH0Sgey_CAGMo7lt4ws-_z6mrxELXCIiOrU&usqp=CAU'),
    Pageviewitems(
        title: 'Have A Nice Day',
        content: 'And You Are Can Puy ANything In Minutes',
        urlimage:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSActaEsU5eqH-pzYTiKxDS91Ra_oU1B47fHy5jxCvB2pmpiHSL2WpUm0s339_F0eA_kDQ&usqp=CAU'),
  ];
  static var pagecontroller = PageController();
  bool islastpage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                Sharedprefrenceslocal.putdata(
                        word: 'onboarding', valueofword: true)
                    .then((value) {
                  if (value) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                        (route) => false);
                  }
                });
              },
              child: Text(
                'Skip',
                style: TextStyle(color: Colors.black),
              ))
        ],
        backgroundColor: Colors.white,
      ),
      body: PageView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) =>
            itemonboarding(context, listpages[index]),
        itemCount: 3,
        controller: pagecontroller,
        onPageChanged: (value) =>
            value == 2 ? islastpage = true : islastpage = false,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward),
        onPressed: () {
          if (islastpage) {
            Sharedprefrenceslocal.putdata(word: 'onboarding', valueofword: true)
                .then((value) {
              if (value) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                    (route) => false);
              }
            });
          } else {
            Onboarding.pagecontroller.nextPage(
                duration: Duration(seconds: 1),
                curve: Curves.fastLinearToSlowEaseIn);
          }
        },
      ),
    );
  }
}
