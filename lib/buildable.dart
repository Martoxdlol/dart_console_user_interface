import 'dart:ffi';

import 'package:dart_console_user_interface/components.dart';
import 'package:dart_console_user_interface/console_interface.dart';
import 'package:dart_console_user_interface/dart_console_user_interface.dart';
import 'package:dart_console_user_interface/elements.dart';

abstract class Buildable extends RendererComponent {
  late ConsoleUIComponent _built;

  @override
  ConsoleUIElement createElement() {
    return _built.createElement();
  }

  ConsoleUIComponent build(ConsoleUIElement contextElement);

  @override
  int get boundariesHeight {
    return _built.boundariesHeight;
  }

  @override
  int get boundariesOffsetLeft {
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

class StateElement extends RendererUIElement {
  final StateComponent _component;
  StateElement(this._component) : super(_component);

  dynamic state;

  void setState(dynamic state) {
    this.state = state;
    markNeedsRebuild();
  }

  void markNeedsRebuild() {}
}

abstract class StateComponent extends Buildable {
  late StateElement element;

  void setState(dynamic newState) {
    element.setState(newState);
  }

  ConsoleUIComponent buildWithElement(StateElement element) {
    this.element = element;
    return build();
  }
}
