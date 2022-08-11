import 'package:dart_console_user_interface/console_interface.dart';

abstract class TreeObject {
  TreeObject? get parent;
  List<TreeObject> get children;

  String get objectName;

  void debugPrintTree(ConsoleInterface console);
}

class TreeError extends Error {
  final String message;
  TreeError(this.message);
}

class TreeRoot extends TreeObject {
  TreeObject? child;
  TreeRoot([this.child]);

  @override
  TreeObject? get parent => null;

  @override
  List<TreeObject> get children => [];

  void appendChild(TreeObject child) {
    if (this.child != null) throw TreeError("Only one child allowed");
    child = child;
  }

  @override
  void debugPrintTree(ConsoleInterface console) {
    console.write("Tree root");
    console.cursor.right(2);
    console.cursor.down();
    final child = this.child;
    if (child != null) {
      child.debugPrintTree(console);
    }
  }

  @override
  String get objectName => "Root";
}

class Tree {
  TreeObject? root;
  Tree([this.root]);
}
