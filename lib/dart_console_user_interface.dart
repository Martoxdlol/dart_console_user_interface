import 'package:dart_console_user_interface/base.dart';
import 'package:dart_console_user_interface/build_context.dart';
import 'package:dart_console_user_interface/console_interface.dart';

class ConsoleUserInterface {
  final ConsoleInterface console;
  ConsoleUserInterface(this.console);

  void runApp(Component component) {
    component
        .buildRenderer(BuildContext(
            layoutBoundaries: LayoutBoundaries(maxSize: Dimensions(30, 10))))
        .render(console);
  }
}
