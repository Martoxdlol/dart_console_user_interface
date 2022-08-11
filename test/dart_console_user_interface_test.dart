import 'package:dart_console_user_interface/buildable.dart';
import 'package:dart_console_user_interface/console_interface.dart';
import 'package:dart_console_user_interface/dart_console_user_interface.dart';
import 'package:dart_console_user_interface/components.dart';
import 'package:test/test.dart';

void main() {
  test("Hello world", () {
    final console = VirtualConsoleInterface();
    final userInterface = ConsoleUserInterface(console);
    userInterface.runApp(Text("Hello world"));

    expect(console.getLineAsString(0).trimRight(), "Hello world");
  });

  test("Hi, ↵ How are you?", () {
    final console = VirtualConsoleInterface();
    final userInterface = ConsoleUserInterface(console);
    userInterface.runApp(Column(children: [
      Text("Hi,"),
      Text("How are you?"),
    ]));

    expect(console.getLineAsString(0).trimRight(), "Hi,");
    expect(console.getLineAsString(1).trimRight(), "How are you?");
  });

  test("Tree test", () {
    final console = VirtualConsoleInterface();
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

    final output = userInterface.tree.debugPrintTree();

    expect(output.getLineAsString(0).trimRight(), "Tree root");
    expect(output.getLineAsString(1).trimRight(), "  Children element");
    expect(output.getLineAsString(2).trimRight(), "      Renderer element");
    expect(output.getLineAsString(3).trimRight(), "      Renderer element");
    expect(output.getLineAsString(4).trimRight(), "      Children element");
    expect(output.getLineAsString(5).trimRight(), "          Renderer element");
    expect(output.getLineAsString(6).trimRight(), "          Renderer element");
  });

  test("Buildable", () {
    final console = VirtualConsoleInterface();
    final userInterface = ConsoleUserInterface(console);
    userInterface.runApp(Column(children: [SumExpression(4, 5)]));
    expect(console.getLineAsString(0).trimRight(), "4 + 5");
  });
}

class SumExpression extends Buildable {
  final int a;
  final int b;
  SumExpression(this.a, this.b);

  @override
  ConsoleUIComponent build() {
    return Row(children: [
      Text(a.toString()),
      Text(" + "),
      Text(b.toString()),
    ]);
  }
}
