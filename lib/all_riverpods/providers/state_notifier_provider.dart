import 'package:flutter_riverpod/flutter_riverpod.dart';

//! Exposing an immutable state which can change over time ,
//? we mostly use this one

final stateNotifierProvider = StateNotifierProvider<CounterNotifier, int>(
  (ref) {
    return CounterNotifier();
  },
);

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() {
    state = state + 1;
  }

  void dicrement() {
    state = state - 1;
  }
}
