import 'dart:math';

import 'package:dart_console_user_interface/console_interface.dart';
import 'package:dart_console_user_interface/dart_console_user_interface.dart';
import 'package:dart_console_user_interface/elements.dart';

abstract class RendererComponent extends ConsoleUIComponent {
  @override
  ConsoleUIElement createElement() {
    return RendererUIElement(this);
  }
}

class Text extends RendererComponent {
  final String text;
  Text(this.text);

  @override
  void render(ConsoleInterface console) {
    console.write(text);
  }

  @override
  int get boundariesHeight => 1;

  @override
  int get boundariesOffsetTop => 0;

  @override
  int get boundariesOffsetLeft => 0;

  @override
  int get boundariesWidth => text.length;

  @override
  int get height => 1;

  @override
  int get width => text.length;
}

abstract class ChildrenRendererComponent extends RendererComponent {
  final List<ConsoleUIComponent> children;
  ChildrenRendererComponent(this.children);

  @override
  ConsoleUIElement createElement() {
    return ChildrenRendererUIElement(
        this, children.map((e) => e.createElement()).toList());
  }
}

class Column extends ChildrenRendererComponent {
  Column({required List<ConsoleUIComponent> children}) : super(children);

  @override
  int get width {
    int width = 0;
    for (final child in children) {
      width = max(width, child.width);
    }
    return width;
  }

  @override
  int get height {
    int height = 0;
    for (final child in children) {
      height += child.height;
    }
    return height;
  }

  @override
  int get boundariesHeight => height;

  @override
  int get boundariesOffsetLeft => 0;

  @override
  int get boundariesOffsetTop => 0;

  @override
  int get boundariesWidth => width;

  @override
  void render(ConsoleInterface console) {
    for (final child in children) {
      child.render(console);
      console.cursor.down();
    }
  }
}

class Row extends ChildrenRendererComponent {
  Row({required List<ConsoleUIComponent> children}) : super(children);

  @override
  int get width {
    int width = 0;
    for (final child in children) {
      width = max(width, child.width);
    }
    return width;
  }

  @override
  int get height {
    int height = 0;
    for (final child in children) {
      height = max(height, child.height);
    }
    return height;
  }

  @override
  int get boundariesHeight => height;

  @override
  int get boundariesOffsetLeft => 0;

  @override
  int get boundariesOffsetTop => 0;

  @override
  int get boundariesWidth => width;

  @override
  void render(ConsoleInterface console) {
    for (final child in children) {
      child.render(console);
      console.cursor.right(child.width);
    }
  }
}
