import 'package:flutter_riverpod/flutter_riverpod.dart';

//! [FutureProvider] givea async data, that will come from api or some other networks it's same as provider but for asynchronus code

//? if we add [FutureProvider.autoDispose] the state will be lost or we can say that
//? it'll be rebuild from begning else will be same where we left it

final futureProvider = FutureProvider<String>(
  (ref) {
    return futureData();
  },
);

// example future data
Future<String> futureData() async {
  return await Future.delayed(
    const Duration(seconds: 2),
    () => 'Temp:22°c',
  );
}

// Family modifier example if we need a value from client /user we can use this modifier
// final futureProvider = FutureProvider.family<String, String>(
//   (ref, cityName) {
//     return futureData(city: cityName);
//   },
// );

// // example future data
// Future<String> futureData({required String city}) async {
//   return await Future.delayed(
//     const Duration(seconds: 2),
//     () => 'City:$city | Temp:22°c',
//   );
// }
