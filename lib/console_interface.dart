import 'package:dart_console_user_interface/cursor.dart';

abstract class ConsoleInterface {
  final ConsoleInterfaceCursor cursor = ConsoleInterfaceCursor();
  void write(String text);
}

class STDTerminalInterface extends ConsoleInterface {
  void write(String text) {}
}

class VirtualConsoleInterface extends ConsoleInterface {
  final List<List<int>> lines = [];

  VirtualConsoleInterface() {
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
      lines[line][i + offset] = chars[i];
    }
  }

  @override
  void write(String text) {
    writeIntoLine(text, cursor.state.row, cursor.state.column);
  }

  void printToTerminal() {
    for (final line in lines) {
      print(String.fromCharCodes(line));
    }
  }
}