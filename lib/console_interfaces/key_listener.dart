import 'package:dart_console/dart_console.dart';

Stream<Key> getKeyStream(Console console) async* {
  while (true) {
    final key = console.readKey();
    yield key;
  }
}
