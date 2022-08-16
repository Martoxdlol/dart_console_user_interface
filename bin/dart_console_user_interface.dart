import 'package:dart_console_user_interface/base.dart';
import 'package:dart_console_user_interface/build_context.dart';
import 'package:dart_console_user_interface/console_interface.dart';
import 'package:dart_console_user_interface/dart_console_user_interface.dart';
import 'package:dart_console_user_interface/event_stream.dart';

final console = VirtualConsoleInterface();

void main(List<String> arguments) {
  final userInterface = ConsoleUserInterface(console);

  final events = ConsoleEventsStream();

  userInterface.runApp(Column(children: [
    Row(children: [
      Text("Hola "),
      Text("Mundo "),
      Text("Mundo "),
      Text("Mundo "),
      Column(children: [
        Text("YEA "),
        Text("YEB "),
      ]),
      Text("Mundo "),
      Text("Mundo "),
    ]),
    Text("YEA"),
    ExpandChar("A"),
    Row(children: [
      Text("YEA"),
      Text("YEB"),
      ExpandChar("="),
    ]),
    SumExpression(5, 5)
  ]));

  console.printToTerminal();

  events.emitEvent(ConsoleEvent());
}

class SumExpression extends BuildableComponent {
  final int a;
  final int b;
  SumExpression(this.a, this.b);

  @override
  Component build(BuildContext context) {
    return Row(children: [
      Text(a.toString()),
      Text(" + "),
      Text(b.toString()),
    ]);
  }
}
