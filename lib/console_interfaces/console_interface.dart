import 'package:dart_console_user_interface/base.dart';
import 'package:dart_console_user_interface/cursor.dart';

abstract class ConsoleInterface {
  final ConsoleInterfaceCursor cursor = ConsoleInterfaceCursor();
  void write(String text);
  Dimensions get size;
  void paint();
}
