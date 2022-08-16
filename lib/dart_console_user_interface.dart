import 'package:dart_console/dart_console.dart';
import 'package:dart_console_user_interface/base.dart';
import 'package:dart_console_user_interface/build_context.dart';
import 'package:dart_console_user_interface/console_interfaces/console_interface.dart';
import 'package:dart_console_user_interface/hooks.dart/hooks.dart';

class RootComponent extends BuildableComponent implements HookComponent {
  final Component child;
  final ConsoleUserInterface ui;
  RootComponent(this.child, this.ui);

  @override
  ConsoleUserInterface get userInterface => ui;

  @override
  Component build(BuildContext context) {
    return child;
  }

  @override
  void debugPrintTree(ConsoleInterface console) {
    child.debugPrintTree(console);
  }

  @override
  String? key;

  @override
  void update() {
    userInterface.update();
  }
}

class ConsoleUserInterface {
  final ConsoleInterface console;
  ConsoleUserInterface(this.console);

  late final HooksManager hooks;

  late final HookComponent root;

  void update() {
    hooks.startCycle();
    final renderer = root.buildRenderer(BuildContext(
        layoutBoundaries: LayoutBoundaries(
            maxSize: Dimensions(console.size.width, console.size.height))));

    renderer.render(console);
  }

  Future<void> runApp(Component component) async {
    root = RootComponent(component, this);
    hooks = HooksManager(root);

    update();

    if (console.keyStream != null) {
      await for (final key in console.keyStream!) {
        if (key.controlChar == ControlCharacter.ctrlC) {
          break;
        }
      }
    }
  }
}
