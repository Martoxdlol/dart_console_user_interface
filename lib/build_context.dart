import 'package:dart_console_user_interface/boundaries.dart';
import 'package:dart_console_user_interface/component.dart';
import 'package:dart_console_user_interface/element.dart';

abstract class BuildContext {
  BuildContext get owner;
  LayoutBoundaries get layoutBoundaries;
  DimensionalBoundaries get size;
  List<Element> get children;
  void addChild(Component child);
}
