import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/all_riverpods/providers/provider.dart';

class SimpleProvider extends ConsumerWidget {
  const SimpleProvider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String data = ref.read<String>(stringProvider);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
        ),
        body: Center(
            child: Text(
          data,
          style: const TextStyle(fontSize: 45, color: Colors.black),
        )));
  }
}
