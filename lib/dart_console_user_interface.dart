import 'package:dart_console_user_interface/boundaries.dart';
import 'package:dart_console_user_interface/build_context.dart';
import 'package:dart_console_user_interface/component.dart';
import 'package:dart_console_user_interface/console_interface.dart';
import 'package:dart_console_user_interface/element.dart';

class Screen extends Element {
  Screen(super.component);

  @override
  LayoutBoundaries get layoutBoundaries => component.layoutBoundaries;
}

class ScreenComponent extends BuildableComponent {
  Component child;
  ScreenComponent({required this.child});

  @override
  Element createElement() {
    return Screen(this);
  }

  @override
  Component build(BuildContext context) {
    return child;
  }

  @override
  LayoutBoundaries get layoutBoundaries => LayoutBoundaries(
      DimensionalBoundaries(0, 0), DimensionalBoundaries(30, 10));

  @override
  DimensionalBoundaries get size => DimensionalBoundaries(30, 10);
}

class ConsoleUserInterface {
  final ConsoleInterface console;
  ConsoleUserInterface(this.console);

  late Element root;

  void runApp(Component component) {
    root = ScreenComponent(child: component).createElement();
    root.build();
    root.render(console);
  }

  void runAppDebug(Component component) {
    final console = VirtualConsoleInterface();
    final elem = ScreenComponent(child: component).createElement();
    elem.build();
    elem.debugPrintTree(console);
    console.printToTerminal();
    elem.render(console);
    console.printToTerminal();
  }
}
