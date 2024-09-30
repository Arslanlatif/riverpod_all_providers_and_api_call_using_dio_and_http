import 'package:flutter_riverpod/flutter_riverpod.dart';
//! [Provider] we use this to only get the specific value ,can't be used where value is changing
//? if we add [Provider.autoDispose] the state will be lost or we can say that
//? it'll be rebuild from begning else will be same where we left it

final stringProvider = Provider<String>((ref) {
  return 'Hi! Arslan Here';
});
