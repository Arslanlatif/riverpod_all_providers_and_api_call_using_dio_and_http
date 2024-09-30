import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/all_riverpods/providers/state_notifier_provider.dart';

class StateNotifierProviderScreen extends ConsumerWidget {
  const StateNotifierProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Consumer(
            builder: (context, ref, child) {
              int counter = ref.watch(stateNotifierProvider);

              return Text(
                counter.toString(),
                style: const TextStyle(fontSize: 45, color: Colors.black),
              );
            },
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    ref.read(stateNotifierProvider.notifier).increment();
                  },
                  child: const Icon(Icons.plus_one)),
              ElevatedButton(
                  onPressed: () {
                    ref.read(stateNotifierProvider.notifier).dicrement();
                  },
                  child: const Icon(Icons.exposure_minus_1_sharp)),
            ],
          )
        ],
      ),
    );
  }
}
