import 'dart:math';

import 'package:dart_console_user_interface/build_context.dart';
import 'package:dart_console_user_interface/console_interfaces/console_interface.dart';
import 'package:dart_console_user_interface/cursor.dart';

abstract class Renderer {
  void render(ConsoleInterface console);
  Dimensions get size;
}

abstract class Component {
  Component get parent;
  Iterable<Component> get children;
  Dimensions get size;
  Renderer buildRenderer(BuildContext context);
  void debugPrintTree(ConsoleInterface console);
}

class Dimensions {
  final int width;
  final int height;

  static const zero = Dimensions(0, 0);

  const Dimensions(this.width, this.height);

  @override
  String toString() {
    return "Dimensions($width, $height)";
  }
}

class FunctionRender extends Renderer {
  final void Function(ConsoleInterface) _render;
  @override
  final Dimensions size;
  FunctionRender(this._render, this.size);

  @override
  void render(ConsoleInterface console) {
    _render(console);
  }
}

abstract class ParentComponent extends Component {
  late Component _parent;
  void attachTo(Component parent) {
    _parent = parent;
  }

  @override
  Component get parent => _parent;
}

abstract class RendererComponent extends ParentComponent {
  @override
  Renderer buildRenderer(BuildContext context) {
    return FunctionRender((console) {
      render(console, context);
    }, size);
  }

  @override
  Iterable<Component> get children => [];

  void render(ConsoleInterface console, BuildContext context);

  @override
  void debugPrintTree(ConsoleInterface console) {
    console.write(runtimeType.toString());
    console.cursor.down();
  }
}

class Text extends RendererComponent {
  final String text;
  Text(this.text);
  @override
  void render(ConsoleInterface console, BuildContext context) {
    final maxWidth = context.layoutBoundaries.maxSize.width;
    if (maxWidth <= 0) return;
    console.write(text.substring(0, min(maxWidth, text.length)));
  }

  @override
  Dimensions get size => Dimensions(text.length, 1);
}

abstract class ChildrenRendererComponent extends ParentComponent {
  @override
  final List<Component> children;
  ChildrenRendererComponent({required this.children});

  @override
  Renderer buildRenderer(BuildContext context) {
    final children = buildChildrenRenderers(context);
    return FunctionRender((console) {
      renderChildren(console, context, children);
    }, size);
  }

  void renderChildren(ConsoleInterface console, BuildContext context,
      Iterable<Renderer> children);

  Iterable<Renderer> buildChildrenRenderers(
    BuildContext context,
  );

  @override
  void debugPrintTree(ConsoleInterface console) {
    console.write(runtimeType.toString());
    console.cursor.add(1, 4);
    for (final child in children) {
      child.debugPrintTree(console);
    }
    console.cursor.add(0, -4);
  }
}

class Row extends ChildrenRendererComponent {
  Row({required super.children});

  late Dimensions _size;

  @override
  Dimensions get size => _size;

  @override
  Iterable<Renderer> buildChildrenRenderers(BuildContext context) {
    int availableWidth = context.layoutBoundaries.maxSize.width;
    int height = 0;

    final r = children.map((child) {
      final r = child.buildRenderer(BuildContext(
          layoutBoundaries: LayoutBoundaries(
              maxSize: Dimensions(
                  availableWidth, context.layoutBoundaries.maxSize.height))));
      availableWidth -= child.size.width;
      if (r.size.height > height) height = r.size.height;
      return r;
    }).toList();

    _size = Dimensions(
        context.layoutBoundaries.maxSize.width - availableWidth, height);

    return r;
  }

  @override
  void renderChildren(ConsoleInterface console, BuildContext context,
      Iterable<Renderer> children) {
    for (final child in children) {
      ConsoleInterfaceCursorState pos = console.cursor.state;
      child.render(console);
      console.cursor.setState(pos);
      console.cursor.right(child.size.width);
    }
  }
}

class Column extends ChildrenRendererComponent {
  Column({required super.children});

  late Dimensions _size;

  @override
  Dimensions get size => _size;

  @override
  Iterable<Renderer> buildChildrenRenderers(BuildContext context) {
    int availableHeight = context.layoutBoundaries.maxSize.height;
    int width = 0;
    final r = children.map((child) {
      final r = child.buildRenderer(BuildContext(
          layoutBoundaries: LayoutBoundaries(
              maxSize: Dimensions(
                  context.layoutBoundaries.maxSize.width, availableHeight))));
      availableHeight -= child.size.height;
      if (r.size.width > width) width = r.size.width;
      return r;
    }).toList();

    _size = Dimensions(
        width, context.layoutBoundaries.maxSize.height - availableHeight);
    return r;
  }

  @override
  void renderChildren(ConsoleInterface console, BuildContext context,
      Iterable<Renderer> children) {
    for (final child in children) {
      ConsoleInterfaceCursorState pos = console.cursor.state;
      child.render(console);
      console.cursor.setState(pos);
      console.cursor.down(child.size.height);
    }
  }
}

class ExpandChar extends RendererComponent {
  final String char;
  ExpandChar(this.char);

  Dimensions? _size;

  @override
  void render(ConsoleInterface console, BuildContext context) {
    final maxWidth = context.layoutBoundaries.maxSize.width;
    _size = Dimensions(maxWidth, 1);
    for (int i = 0; i < maxWidth; i++) {
      console.write(char);
      console.cursor.right();
    }
  }

  @override
  Dimensions get size => _size ?? Dimensions(0, 1);
}

abstract class BuildableComponent extends ParentComponent {
  late Component _built;

  @override
  Renderer buildRenderer(BuildContext context) {
    _built = build(context);
    return _built.buildRenderer(context);
  }

  @override
  Iterable<Component> get children => _built.children;

  @override
  Dimensions get size => _built.size;

  Component build(BuildContext context);

  @override
  void debugPrintTree(ConsoleInterface console) {
    console.write(runtimeType.toString());
    console.cursor.down();
    console.cursor.right(4);
    _built.debugPrintTree(console);
    console.cursor.left(4);
  }
}
