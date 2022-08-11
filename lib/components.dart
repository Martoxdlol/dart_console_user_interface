import 'package:dart_console_user_interface/dart_console_user_interface.dart';
import 'package:dart_console_user_interface/elements.dart';

abstract class RendererComponent extends ConsoleUIComponent {
  @override
  ConsoleUIElement createElement() {
    return RendererUIElement(this);
  }
}

class Text extends RendererComponent {
  final String text;
  Text(this.text);

  @override
  void render(ConsoleInterface console) {
    console.write(text);
  }
}

class Column extends RendererComponent {
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
