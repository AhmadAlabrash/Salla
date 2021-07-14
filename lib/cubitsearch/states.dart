import 'package:salla/model/searchmodel.dart';

abstract class Stateshopsearch {}

class Iniatialshopsearch extends Stateshopsearch {}

class Loadingsearch extends Stateshopsearch {}

class Searchsuccess extends Stateshopsearch {
  Searchmodel? la;
  Searchsuccess(this.la);
}

class Searchfailed extends Stateshopsearch {}
