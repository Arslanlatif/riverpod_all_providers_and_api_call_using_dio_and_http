import 'package:flutter_riverpod/flutter_riverpod.dart';

//? StreamProvider is same as future provider but work for streams instead of futures like web sockets etc

final streamProvider = StreamProvider<int>(
  (ref) {
    return counterStream();
  },
);

// example Stream for counter
Stream<int> counterStream() {
  return Stream.periodic(
          const Duration(seconds: 1), (computationCount) => computationCount)
      .take(100);
}
