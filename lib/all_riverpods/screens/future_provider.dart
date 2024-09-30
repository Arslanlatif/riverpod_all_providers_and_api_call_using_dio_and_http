import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/all_riverpods/providers/future_provider.dart';

class FutureProviderScreen extends ConsumerWidget {
  const FutureProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final futureValue = ref.watch(futureProvider('Islamabad'));
    final futureValue = ref.watch(futureProvider);

    return Scaffold(
        appBar: AppBar(
          elevation: 5,                backgroundColor: Colors.amber,

        ),
        body: futureValue.when(
          data: (data) {
            return Center(
                child: Text(
              data,
              style: const TextStyle(fontSize: 45, color: Colors.black),
            ));
          },
          error: (error, stackTrace) {
            return const Center(
                child: Text(
              'Error',
              style: TextStyle(fontSize: 45, color: Colors.black),
            ));
          },
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
