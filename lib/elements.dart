import 'package:dart_console_user_interface/dart_console_user_interface.dart';
import 'package:dart_console_user_interface/tree.dart';

/// Elements are part of the UI Tree
/// Components on the other side only handle render and business logic
/// Components are extendible and directly usable for users
/// Elements keep it's states on the tree while components are re built on ui update

abstract class ConsoleUIElement implements TreeObject {
  ConsoleUIElement(ConsoleUIComponent component);
}
