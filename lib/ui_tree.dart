import 'package:dart_console_user_interface/console_interface.dart';
import 'package:dart_console_user_interface/elements.dart';
import 'package:dart_console_user_interface/tree.dart';

class UITree extends Tree {
  final ConsoleUIElement rootElement;

  UITree(this.rootElement) : super(rootElement);

  void render(ConsoleInterface console) {
    rootElement.render(console);
  }

  VirtualConsoleInterface debugPrintTree() {
    final debugConsole = VirtualConsoleInterface();
    rootElement.debugPrintTree(debugConsole);
    return debugConsole;
  }
}
