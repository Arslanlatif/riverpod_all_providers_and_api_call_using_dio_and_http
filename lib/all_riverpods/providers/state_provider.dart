import 'package:flutter_riverpod/flutter_riverpod.dart';
//! [StateProvider] we use this to get the value and to get the updated value by time, like it can get that value if its changing 
//? if we add [StateProvide.autoDispose] the state will be lost or we can say that
//? it'll be rebuild from begning else will be same where we left it
final stateProvider = StateProvider<int>((ref) {
  return 0;
});
