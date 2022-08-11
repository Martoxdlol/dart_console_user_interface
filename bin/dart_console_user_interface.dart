import 'package:dart_console_user_interface/components.dart';
import 'package:dart_console_user_interface/console_interface.dart';
import 'package:dart_console_user_interface/dart_console_user_interface.dart';

void main(List<String> arguments) {
  final console = VirtualConsoleInterface();
  final userInterface = ConsoleUserInterface(console);
  userInterface.runApp(Column(children: [
    Text("Hi,"),
    Text("How are you?"),
    Row(children: [
      Text("Hey"),
      Text("how"),
      Text("are"),
      Text("you"),
    ])
  ]));

  console.printToTerminal();

  userInterface.tree.debugPrintTree().printToTerminal();
}
