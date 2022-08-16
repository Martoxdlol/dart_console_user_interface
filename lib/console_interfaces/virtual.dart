import 'package:dart_console_user_interface/base.dart';
import 'package:dart_console_user_interface/console_interfaces/console_interface.dart';

class VirtualConsoleInterface extends ConsoleInterface {
  final List<List<int>> lines = [];

  int _width;
  int _height;

  VirtualConsoleInterface(this._width, this._height) {
    reset();
  }

  void reset() {
    lines.clear();
    for (int i = 0; i < _height; i++) {
      lines.add(List.filled(_width, " ".codeUnitAt(0)));
    }
  }

  void updateSize(int width, int height) {
    _width = width;
    _height = height;
    reset();
  }

  void printToTerminal([void Function(String? object)? printFunction]) {
    final r = toString();

    if (printFunction != null) {
      printFunction(r);
    } else {
      print(r);
    }
  }

  @override
  String toString() {
    return lines
        .map((line) => String.fromCharCodes(line))
        .join("\n")
        .trimRight();
  }

  @override
  Dimensions get size => Dimensions(_width, _height);

  @override
  void write(String text) {
    final lineIndex = cursor.state.row;
    if (lineIndex < 0 || lineIndex >= _height) return;

    int column = cursor.state.column;

    for (final char in text.codeUnits) {
      if (column < 0 || column >= _width) break;
      lines[lineIndex][column] = char;
      column++;
    }
  }

  VirtualConsoleInterface clone() {
    final clone = VirtualConsoleInterface(_width, _height);
    clone.lines.addAll(lines.map((line) => [...line]));
    return clone;
  }

  VirtualConsoleInterface diff(VirtualConsoleInterface other) {
    if (other.size.height != size.height || other.size.width != size.width) {
      return clone();
    }

    final newConsole = VirtualConsoleInterface(_width, _height);
    for (int i = 0; i < _height; i++) {
      final line = lines[i];
      final otherLine = other.lines[i];
      for (int j = 0; j < _width; j++) {
        if (line[j] != otherLine[j]) {
          newConsole.lines[i][j] = line[j];
        } else {
          newConsole.lines[i][j] = 0;
        }
      }
    }

    return clone();
    return newConsole;
  }

  String line(int row) {
    return String.fromCharCodes(lines[row]);
  }

  @override
  void paint() {
    printToTerminal();
  }
}
