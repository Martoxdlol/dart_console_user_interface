import 'package:dart_console_user_interface/cursor.dart';
import 'package:dart_console_user_interface/elements.dart';
import 'package:dart_console_user_interface/tree.dart';
import 'package:dart_console_user_interface/ui_tree.dart';

abstract class ConsoleInterface {
  final ConsoleInterfaceCursor cursor = ConsoleInterfaceCursor();
  void write(String text);
}

class STDTerminalInterface extends ConsoleInterface {
  void write(String text) {}
}

abstract class ConsoleUIComponent {
  void render(ConsoleInterface console);
  ConsoleUIElement createElement();
}

class ConsoleUserInterface {
  final ConsoleInterface console;
  ConsoleUserInterface(this.console);

  late UITree tree;

  void render(ConsoleUIComponent element) {
    tree = UITree(element.createElement());
    element.render(console);
  }
}
