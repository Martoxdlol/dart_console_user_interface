import 'package:dart_console_user_interface/dart_console_user_interface.dart';

class Text extends ConsoleUIElement {
  final String text;
  Text(this.text);

  @override
  void print(ConsoleInterface console) {
    console.write(text);
  }
}

class Column extends ConsoleUIElement {
  final List<ConsoleUIElement> children;
  Column({required this.children});

  @override
  void print(ConsoleInterface console) {
    for (final child in children) {
      child.print(console);
      console.cursor.down();
    }
  }
}
