import 'package:dart_console_user_interface/dart_console_user_interface.dart';

class Text extends ConsoleUIElement {
  final String text;
  Text(this.text);

  void print(ConsoleInterface console) {
    console.write(text);
  }
}
