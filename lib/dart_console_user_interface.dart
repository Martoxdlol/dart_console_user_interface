import 'package:dart_console_user_interface/console_interface.dart';
import 'package:dart_console_user_interface/elements.dart';
import 'package:dart_console_user_interface/ui_tree.dart';

abstract class ConsoleUIComponent {
  void render(ConsoleInterface console);
  ConsoleUIElement createElement();

  int get width;
  int get height;

  int get boundariesOffsetTop;
  int get boundariesOffsetLeft;

  int get boundariesHeight;
  int get boundariesWidth;
}

class ConsoleUserInterface {
  final ConsoleInterface console;
  ConsoleUserInterface(this.console);

  late UITree tree;

  void attachRoot(ConsoleUIComponent component) {
    tree = UITree(component.createElement());
  }

  void renderTree() {
    tree.render(console);
  }

  void runApp(ConsoleUIComponent component) {
    attachRoot(component);
    renderTree();
  }
}
