import 'package:dart_console/dart_console.dart';
import 'package:dart_console_user_interface/base.dart';
import 'package:dart_console_user_interface/console_interfaces/console_interface.dart';
import 'package:dart_console_user_interface/console_interfaces/key_listener.dart';
import 'package:dart_console_user_interface/console_interfaces/virtual.dart';
import 'package:dart_console_user_interface/cursor.dart';

class STDTerminalInterface extends ConsoleInterface {
  final console = Console();
  late final VirtualConsoleInterface virtual;
  late VirtualConsoleInterface lastFrame;
  @override
  late Stream<Key>? keyStream;

  STDTerminalInterface() {
    virtual =
        VirtualConsoleInterface(console.windowWidth, console.windowHeight);
    lastFrame = virtual;
    keyStream = getKeyStream(console);
  }

  @override
  void init() {
    console.cursorPosition = Coordinate(0, 0);
    console.hideCursor();
    console.clearScreen();
  }

  @override
  ConsoleInterfaceCursor get cursor => virtual.cursor;

  @override
  void write(String text) {
    virtual.write(text);
  }

  @override
  Dimensions get size => Dimensions(console.windowWidth, console.windowHeight);

  @override
  void paint() {
    for (int i = 0; i < size.height; i++) {
      console.cursorPosition = Coordinate(i, 0);
      console.write(virtual.line(i));
    }
    virtual.reset();
    // final newFrame = virtual.diff(lastFrame);
    // console.cursorPosition = Coordinate(0, 0);
    // for (final line in newFrame.lines) {
    //   console.write(String.fromCharCodes(line));
    //   console.cursorDown();
    // }
    // console.cursorPosition = Coordinate(size.height - 1, 0);
    // lastFrame = virtual.clone();
    // virtual.reset();
  }
}
