import 'package:dart_console/dart_console.dart';
import 'package:dart_console_user_interface/base.dart';
import 'package:dart_console_user_interface/build_context.dart';
import 'package:dart_console_user_interface/console_interfaces/std_interface.dart';
import 'package:dart_console_user_interface/console_interfaces/virtual.dart';
import 'package:dart_console_user_interface/dart_console_user_interface.dart';
import 'package:dart_console_user_interface/hooks.dart/hooks.dart';

final console = STDTerminalInterface();

void main(List<String> arguments) {
  final userInterface = ConsoleUserInterface(console);

  userInterface.runApp(
      Column(children: [Text("Valor acumulativo usando estados: "), Add()]));
}

bool listening = false;

class Add extends HookComponent {
  @override
  Component build(BuildContext context) {
    final value = useState<int>(0);

    if (!listening) {
      userInterface.addKeyEventListener((Key key) {
        if (key.controlChar == ControlCharacter.arrowUp) {
          value.value++;
        } else if (key.controlChar == ControlCharacter.arrowDown) {
          value.value--;
        }
      });
      listening = true;
    }

    return Column(children: [
      Text("Valor: $value"),
    ]);
  }
}
