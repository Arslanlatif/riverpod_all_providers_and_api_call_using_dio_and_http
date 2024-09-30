import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/all_riverpods/screens/future_provider.dart';
import 'package:riverpod_example/api_call_using_riverpod/screens/posts_screen.dart';

void main() {
  //! by wraping [MyApp] with [ProviderScope] gives us state of all providers that we'll make
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 93, 0, 255)),
        useMaterial3: true,
      ),
      home: const PostScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FutureProviderScreen(),
                )),
            child: const Text(
              'Click For Action',
              style: TextStyle(color: Colors.black),
            )),
      ),
    );
  }
}
