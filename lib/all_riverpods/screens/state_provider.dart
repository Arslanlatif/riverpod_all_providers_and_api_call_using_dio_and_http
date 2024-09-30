import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/all_riverpods/providers/state_provider.dart';

class StateProviderScreen extends ConsumerWidget {
  const StateProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(                backgroundColor: Colors.amber,
),
        body: Center(child: Consumer(
          builder: (context, ref, child) {
            int count = ref.watch(stateProvider);
            return Text(
              count.toString(),
              style: const TextStyle(fontSize: 45, color: Colors.black),
            );
          },
        )),
        floatingActionButton: ButtonBar(
          children: [
            FloatingActionButton(
                onPressed: () {
                  ref.read(stateProvider.notifier).state++;
                },
                child: const Icon(Icons.plus_one)),
            FloatingActionButton(
                onPressed: () {
                  ref.read(stateProvider.notifier).state--;
                },
                child: const Icon(Icons.exposure_minus_1_sharp)),
          ],
        ));
  }
}
