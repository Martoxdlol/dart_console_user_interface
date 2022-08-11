import 'package:dart_console_user_interface/components.dart';
import 'package:dart_console_user_interface/console_interface.dart';
import 'package:dart_console_user_interface/dart_console_user_interface.dart';
import 'package:dart_console_user_interface/elements.dart';

abstract class Buildable extends RendererComponent {
  bool isBuilt = false;
  late ConsoleUIComponent _built;

  void buildFirst() {
    if (!isBuilt) {
      _built = build();
      isBuilt = true;
    }
  }

  @override
  ConsoleUIElement createElement() {
    buildFirst();
    return _built.createElement();
  }

  ConsoleUIComponent build();

  @override
  int get boundariesHeight {
    buildFirst();
    return _built.boundariesHeight;
  }

  @override
  int get boundariesOffsetLeft {
    buildFirst();
    return _built.boundariesOffsetLeft;
  }

  @override
  int get boundariesOffsetTop {
    buildFirst();
    return _built.boundariesOffsetTop;
  }

  @override
  int get boundariesWidth {
    buildFirst();
    return _built.boundariesWidth;
  }

  @override
  int get height {
    buildFirst();
    return _built.height;
  }

  @override
  int get width {
    buildFirst();
    return _built.width;
  }

  @override
  void render(ConsoleInterface console) {
    buildFirst();
    _built.render(console);
  }
}
