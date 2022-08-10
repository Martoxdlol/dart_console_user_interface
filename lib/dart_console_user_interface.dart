abstract class ConsoleInterface {
  void write(String text);
}

class STDTerminalInterface extends ConsoleInterface {
  void write(String text) {}
}

abstract class ConsoleUIElement {
  void print(ConsoleInterface console);
}

class ConsoleUserInterface {
  final ConsoleInterface console;
  ConsoleUserInterface(this.console);

  void render(ConsoleUIElement element) {
    element.print(console);
  }
}
