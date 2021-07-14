import 'package:salla/model/classmodel.dart';

abstract class Stateshop {}

class Iniatialstartshop extends Stateshop {}

class Loginsuccess extends Stateshop {
  Showlogindata? la;
  Loginsuccess(this.la);
}

class Loginfailed extends Stateshop {}
