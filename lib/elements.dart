import 'package:dart_console_user_interface/dart_console_user_interface.dart';
import 'package:dart_console_user_interface/tree.dart';

import 'dart_console_user_interface.dart';
import 'tree.dart';

/// Elements are part of the UI Tree
/// Components on the other side only handle render and business logic
/// Components are extendible and directly usable for users
/// Elements keep it's states on the tree while components are re built on ui update

abstract class ConsoleUIElement implements TreeObject {
  final ConsoleUIComponent component;
  ConsoleUIElement(this.component);
}

class RendererUIElement extends ConsoleUIElement {
  RendererUIElement(super.component);

  @override
  List<TreeObject> get children => throw UnimplementedError();

  @override
  TreeObject? get parent => throw UnimplementedError();
}
