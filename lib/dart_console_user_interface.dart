import 'package:dart_console_user_interface/base.dart';
import 'package:dart_console_user_interface/build_context.dart';
import 'package:dart_console_user_interface/console_interfaces/console_interface.dart';

class ConsoleUserInterface {
  final ConsoleInterface console;
  ConsoleUserInterface(this.console);

  late final Component root;

  void runApp(Component component) {
    root = component;
    component
        .buildRenderer(BuildContext(
            layoutBoundaries: LayoutBoundaries(
                maxSize: Dimensions(console.size.width, console.size.height))))
        .render(console);
  }
}
