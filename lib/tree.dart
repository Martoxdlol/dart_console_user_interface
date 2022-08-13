import 'package:dart_console_user_interface/console_interface.dart';

abstract class Tree {
  Tree get parent;
  List<Tree> get children;

  // DEBUG
  void debugPrintTree(ConsoleInterface console);
}
