import 'package:salla/model/classmodel.dart';

abstract class Stateshopregister {}

class Iniatialshop extends Stateshopregister {}

class Registersuccess extends Stateshopregister {
  Showlogindata? la;
  Registersuccess(this.la);
}

class Registerfailed extends Stateshopregister {}
