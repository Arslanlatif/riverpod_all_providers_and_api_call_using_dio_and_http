import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/all_riverpods/providers/stream_provider.dart';

class StreamProviderScreen extends ConsumerWidget {
  const StreamProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counterData = ref.watch(streamProvider);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          elevation: 5,
        ),
        body: counterData.when(
          data: (data) {
            return Center(
                child: Text(
              data.toString(),
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
