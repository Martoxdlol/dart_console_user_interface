import 'dart:async';

import 'package:dart_console_user_interface/basic.dart';
import 'package:dart_console_user_interface/build_context.dart';
import 'package:dart_console_user_interface/component.dart';
import 'package:dart_console_user_interface/console_interface.dart';
import 'package:dart_console_user_interface/dart_console_user_interface.dart';
import 'package:dart_console_user_interface/element.dart';
import 'package:dart_console_user_interface/event_stream.dart';

final console = VirtualConsoleInterface();

void main(List<String> arguments) {
  final userInterface = ConsoleUserInterface(console);

  final events = ConsoleEventsStream();

  userInterface.runApp(Column(children: [
    Text("Hi,"),
    Text("How are you?"),
    Container(
      padding: 1,
      child: Column(children: [
        Row(children: [
          Text("Hey "),
          Text("how "),
          Text("are "),
          Text("you "),
          ExpandibleRow("="),
          // PrintUserInterface(),
        ]),
        ExpandibleRow("="),
      ]),
    ),
    ExpandibleRow("="),
  ]));

  console.printToTerminal();

  events.emitEvent(ConsoleEvent());

  // userInterface.tree.debugPrintTree().printToTerminal();
}

// class PrintUserInterface extends StateComponent {
//   @override
//   ConsoleUIComponent build(ConsoleUIElement context) {
//     return Text(element.userInterface.toString());
//   }
// }

String a = "x";

class X extends BuildableComponent {
  @override
  Component build(BuildContext context) {
    Timer timer = Timer(Duration(milliseconds: 2500), () {
      final elem = context as Element;

      a += "x";

      elem.build();

      console.reset();
      elem.parent.parent.parent.parent.parent.parent.render(console);

      console.printToTerminal();
    });
    return Column(children: [Text("REPEAT $a")]);
  }
}
