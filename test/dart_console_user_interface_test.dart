import 'package:dart_console_user_interface/base.dart';
import 'package:dart_console_user_interface/build_context.dart';
import 'package:dart_console_user_interface/console_interfaces/console_interface.dart';
import 'package:dart_console_user_interface/console_interfaces/virtual.dart';
import 'package:dart_console_user_interface/dart_console_user_interface.dart';
import 'package:dart_console_user_interface/hooks.dart/hooks.dart';
import 'package:test/test.dart';

void main() {
  test("Hello world", () {
    final console = VirtualConsoleInterface(60, 20);
    final userInterface = ConsoleUserInterface(console);
    userInterface.runApp(Text("Hello world"));

    expect(console.line(0).trimRight(), "Hello world");
  });

  test("Hi, ↵ How are you?", () {
    final console = VirtualConsoleInterface(60, 20);
    final userInterface = ConsoleUserInterface(console);
    userInterface.runApp(Column(children: [
      Text("Hi,"),
      Text("How are you?"),
    ]));

    expect(console.line(0).trimRight(), "Hi,");
    expect(console.line(1).trimRight(), "How are you?");
  });

  test("Tree test", () {
    final console = VirtualConsoleInterface(60, 20);
    final userInterface = ConsoleUserInterface(console);
    userInterface.runApp(Column(children: [
      Text("Hi,"),
      Text("How are you?"),
      Row(children: [
        Text("Hey "),
        Text("how "),
        Text("are "),
        Text("you"),
      ])
    ]));

    final out = VirtualConsoleInterface(60, 20);

    userInterface.root.debugPrintTree(out);

    expect(out.line(0).trimRight(), "Column");
    expect(out.line(1).trimRight(), "    Text");
    expect(out.line(2).trimRight(), "    Text");
    expect(out.line(3).trimRight(), "    Row");
    expect(out.line(4).trimRight(), "        Text");
    expect(out.line(5).trimRight(), "        Text");
    expect(out.line(6).trimRight(), "        Text");
    expect(out.line(7).trimRight(), "        Text");
  });

  test("Buildable", () {
    final console = VirtualConsoleInterface(60, 20);
    final userInterface = ConsoleUserInterface(console);
    userInterface.runApp(Column(children: [SumExpression(4, 5)]));
    expect(console.line(0).trimRight(), "4 + 5");

    final out = VirtualConsoleInterface(60, 20);

    userInterface.root.debugPrintTree(out);

    expect(out.line(0).trimRight(), "Column");
    expect(out.line(1).trimRight(), "    SumExpression");
    expect(out.line(2).trimRight(), "        Row");
    expect(out.line(3).trimRight(), "            Text");
    expect(out.line(4).trimRight(), "            Text");
    expect(out.line(5).trimRight(), "            Text");
  });

  test("useState", () {
    final console = VirtualConsoleInterface(60, 20);
    final userInterface = ConsoleUserInterface(console);
    userInterface.runApp(Column(children: [TestUseState()]));

    final out = VirtualConsoleInterface(60, 20);
    userInterface.hooks.tree.debugPrintTree(out);

    out.printToTerminal();

    // expect(console.line(0).trimRight(), "0");
    // testUseStateValue.value = 1;
    userInterface.update();
    userInterface.update();
    userInterface.update();
    userInterface.update();

    print("");

    userInterface.hooks.tree.debugPrintTree(out);
    out.printToTerminal();

    // testUseStateValue.value = 2;
    userInterface.update();

    print("");

    userInterface.hooks.tree.debugPrintTree(out);
    out.printToTerminal();

    expect(console.line(0).trimRight(), "2");
  });
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

late StateValue<int> testUseStateValue;

class TestUseState extends BuildableComponent {
  @override
  Component build(BuildContext context) {
    testUseStateValue = useState(0);
    // final v2 = useState(DateTime.now().millisecondsSinceEpoch);

    return Row(children: [
      Text(testUseStateValue.value.toString()),
    ]);
  }
}
