import 'package:dart_console_user_interface/buildable.dart';
import 'package:dart_console_user_interface/components.dart';
import 'package:dart_console_user_interface/console_interface.dart';
import 'package:dart_console_user_interface/dart_console_user_interface.dart';
import 'package:dart_console_user_interface/elements.dart';
import 'package:dart_console_user_interface/event_stream.dart';

void main(List<String> arguments) {
  final console = VirtualConsoleInterface();
  final userInterface = ConsoleUserInterface(console);

  final events = ConsoleEventsStream();

  userInterface.runApp(Column(children: [
    Text("Hi,"),
    Text("How are you?"),
    Row(children: [
      Text("Hey "),
      Text("how "),
      Text("are "),
      Text("you "),
      PrintUserInterface(),
    ])
  ]));

  console.printToTerminal();

  events.emitEvent(ConsoleEvent());

  userInterface.tree.debugPrintTree().printToTerminal();
}

class PrintUserInterface extends StateComponent {
  @override
  ConsoleUIComponent build(ConsoleUIElement context) {
    return Text(element.userInterface.toString());
  }
}
