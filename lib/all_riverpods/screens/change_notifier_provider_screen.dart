import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/all_riverpods/providers/change_notifier_provider.dart';

class ChangeNotifierProviderScreen extends ConsumerWidget {
  const ChangeNotifierProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
        ),
        body: Center(child: Consumer(
          builder: (context, ref, child) {
            var data = ref.watch(changeNotifierProvider);
            return Text(
              data.name,
              style: const TextStyle(fontSize: 45, color: Colors.black),
            );
          },
        )),
        floatingActionButton: ButtonBar(
          children: [
            FloatingActionButton(
                onPressed: () {
                  ref.read(changeNotifierProvider.notifier).changeName();
                },
                child: const Icon(Icons.change_circle_outlined)),
          ],
        ));
  }
}
