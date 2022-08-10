import 'package:dart_console_user_interface/dart_console_user_interface.dart';
import 'package:dart_console_user_interface/elements.dart';
import 'package:test/test.dart';

class TestConsoleInterface extends ConsoleInterface {
  final List<List<int>> lines = [];

  TestConsoleInterface() {
    for (int i = 0; i < 10; i++) {
      lines.add(List.from("                              ".codeUnits));
    }
  }

  String getLineAsString(int index) {
    return String.fromCharCodes(lines[index]);
  }

  void writeIntoLine(String text, [int line = 0, int offset = 0]) {
    final chars = text.codeUnits;
    for (int i = 0; i < chars.length; i++) {
      lines[line][i] = chars[i];
    }
  }

  @override
  void write(String text) {
    writeIntoLine(text, cursor.state.row, cursor.state.column);
  }
}

void main() {
  test("Hello world", () {
    final console = TestConsoleInterface();
    final userInterface = ConsoleUserInterface(console);
    userInterface.render(Text("Hello world"));

    expect(console.getLineAsString(0).trimRight(), "Hello world");
  });

  test("Hi, ↵ How are you?", () {
    final console = TestConsoleInterface();
    final userInterface = ConsoleUserInterface(console);
    userInterface.render(Column(children: [
      Text("Hi,"),
      Text("How are you?"),
    ]));

    expect(console.getLineAsString(0).trimRight(), "Hi,");
    expect(console.getLineAsString(1).trimRight(), "How are you?");
  });
}
