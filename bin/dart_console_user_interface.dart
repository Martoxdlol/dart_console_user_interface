import 'package:dart_console_user_interface/base.dart';
import 'package:dart_console_user_interface/build_context.dart';
import 'package:dart_console_user_interface/console_interfaces/std_interface.dart';
import 'package:dart_console_user_interface/dart_console_user_interface.dart';

import 'use_state.dart';

final console = STDTerminalInterface();

void main(List<String> arguments) {
  final userInterface = ConsoleUserInterface(console);

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
    SumExpression(5, 5),
    Add(),
  ]));
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
