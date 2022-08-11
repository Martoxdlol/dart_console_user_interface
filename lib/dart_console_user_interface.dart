import 'package:dart_console_user_interface/console_interface.dart';
import 'package:dart_console_user_interface/elements.dart';
import 'package:dart_console_user_interface/tree.dart';
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

class UITreeRoot extends ConsoleUIElement {
  ConsoleUIElement child;

  @override
  ConsoleUserInterface userInterface;
  UITreeRoot(this.child, this.userInterface) : super(child.component) {
    child.attach(this);
  }

  @override
  ConsoleUIElement? get parent => null;

  @override
  List<TreeObject> get children => [];

  @override
  void debugPrintTree(ConsoleInterface console) {
    console.write("Tree root");
    console.cursor.right(2);
    console.cursor.down();
    final child = this.child;
    child.debugPrintTree(console);
  }

  @override
  String get objectName => "Root";
}

class ConsoleUserInterface {
  final ConsoleInterface console;
  ConsoleUserInterface(this.console);

  late UITree tree;

  void attachRoot(ConsoleUIComponent component) {
    final root = UITreeRoot(component.createElement(), this);
    tree = UITree(root);
  }

  void renderTree() {
    tree.render(console);
  }

  void runApp(ConsoleUIComponent component) {
    attachRoot(component);
    renderTree();
  }
}
