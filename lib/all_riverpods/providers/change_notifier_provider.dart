import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//! use to listen to and expose a change notifier provider by flutter itself 
//? works for mutable states although immutable is prefered 
//? discouranged by riverpod officails just there so that switching from prover can be easier as it's present there as well

final changeNotifierProvider=  ChangeNotifierProvider<ChangeNotifierStatee>((ref) 
  =>  ChangeNotifierStatee()
);   

class ChangeNotifierStatee extends ChangeNotifier {
String name='Arslan';

void changeName(){
name='hi im arslan';
notifyListeners();
}

}