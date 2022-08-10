import 'package:dart_console_user_interface/cursor.dart';

abstract class ConsoleInterface {
  final ConsoleInterfaceCursor cursor = ConsoleInterfaceCursor();
  void write(String text);
}

class STDTerminalInterface extends ConsoleInterface {
  void write(String text) {}
}

abstract class ConsoleUIElement {
  void print(ConsoleInterface console);
}

class ConsoleUserInterface {
  final ConsoleInterface console;
  ConsoleUserInterface(this.console);

  void render(ConsoleUIElement element) {
    element.print(console);
  }
}
