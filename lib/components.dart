import 'dart:html';

import 'package:dart_console_user_interface/dart_console_user_interface.dart';
import 'package:dart_console_user_interface/tree.dart';

class Text extends ConsoleUIComponent {
  final String text;
  Text(this.text);

  @override
  void render(ConsoleInterface console) {
    console.write(text);
  }
}

class Column extends ConsoleUIComponent {
  final List<ConsoleUIComponent> children;
  Column({required this.children});

  @override
  void render(ConsoleInterface console) {
    for (final child in children) {
      child.render(console);
      console.cursor.down();
    }
  }
}
