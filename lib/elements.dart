import 'package:dart_console_user_interface/console_interface.dart';
import 'package:dart_console_user_interface/dart_console_user_interface.dart';
import 'package:dart_console_user_interface/tree.dart';

import 'dart_console_user_interface.dart';
import 'tree.dart';

/// Elements are part of the UI Tree
/// Components on the other side only handle render and business logic
/// Components are extendible and directly usable for users
/// Elements keep it's states on the tree while components are re built on ui update

typedef ComponentVisitor = void Function(ConsoleUIComponent component);

abstract class ConsoleUIElement implements TreeObject {
  ConsoleUIElement? _parent;

  @override
  ConsoleUIElement? get parent => _parent;

  final ConsoleUIComponent component;
  ConsoleUIElement(this.component);

  void attach(ConsoleUIElement parent) {
    _parent = parent;
  }

  @override
  void debugPrintTree(ConsoleInterface console) {
    console.write(objectName);
    console.cursor.down();

    console.cursor.right(4);
    for (final child in children) {
      child.debugPrintTree(console);
    }

    console.cursor.right(-4);
  }
}

class RendererUIElement extends ConsoleUIElement {
  RendererUIElement(super.component);

  @override
  List<TreeObject> get children => const [];

  @override
  String get objectName => "Renderer element";
}

class ChildrenRendererUIElement extends ConsoleUIElement {
  final List<ConsoleUIElement> _children;
  ChildrenRendererUIElement(super.component, this._children);

  @override
  List<TreeObject> get children => _children;

  void visitChildren(ComponentVisitor visitor) {
    for (final element in _children) {
      visitor(element.component);
    }
  }

  void clearChildren() {
    _children.clear();
  }

  void appendChild(ConsoleUIElement child) {
    _children.add(child);
  }

  void removeChild(ConsoleUIElement child) {
    _children.remove(child);
  }

  @override
  String get objectName => "Children element";
}
