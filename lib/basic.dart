import 'package:dart_console_user_interface/boundaries.dart';
import 'package:dart_console_user_interface/component.dart';
import 'package:dart_console_user_interface/console_interface.dart';
import 'package:dart_console_user_interface/element.dart';

class Column extends ChildrenRendererComponent {
  Column({required super.children});

  @override
  LayoutBoundaries get layoutBoundaries => parentLayoutBoundaries;

  @override
  void render(ConsoleInterface console, Element element) {
    for (final child in element.children) {
      final pos = console.cursor.state;
      child.render(console);
      console.cursor.setState(pos);
      console.cursor.down(child.size.height);
    }
  }

  @override
  DimensionalBoundaries get size {
    final size = children.fold(DimensionalBoundaries(0, 0),
        (DimensionalBoundaries acc, Component child) {
      return DimensionalBoundaries(
          acc.width < child.size.width ? child.size.width : acc.width,
          acc.height + child.size.height);
    });
    return size;
  }
}

class Text extends RendererComponent {
  final String text;
  Text(this.text);

  @override
  LayoutBoundaries get layoutBoundaries => throw UnimplementedError();

  @override
  void render(ConsoleInterface console, Element element) {
    console.write(text);
  }

  @override
  DimensionalBoundaries get size => DimensionalBoundaries(text.length, 1);
}

class Row extends ChildrenRendererComponent {
  Row({required super.children});

  @override
  void render(ConsoleInterface console, Element element) {
    for (final child in element.children) {
      final pos = console.cursor.state;
      child.render(console);
      console.cursor.setState(pos);
      console.cursor.right(child.size.width);
    }
  }

  @override
  DimensionalBoundaries get size {
    final size = children.fold(DimensionalBoundaries(0, 0),
        (DimensionalBoundaries acc, Component child) {
      return DimensionalBoundaries(acc.width + child.size.width,
          acc.height < child.size.height ? child.size.height : acc.height);
    });
    return size;
  }

  @override
  LayoutBoundaries get layoutBoundaries => parentLayoutBoundaries;
}

class Container extends ChildrenRendererComponent {
  final int padding;
  final int margin;
  Container({required Component child, this.padding = 0, this.margin = 0})
      : super(children: [child]);
  Component get child => children.first;

  @override
  void render(ConsoleInterface console, Element element) {
    console.cursor.down(padding + margin);
    console.cursor.right(padding + margin);
    element.children.first.render(console);
  }

  @override
  DimensionalBoundaries get size {
    return DimensionalBoundaries(child.size.width + (padding + margin) * 2,
        child.size.height + (padding + margin) * 2);
  }

  @override
  LayoutBoundaries get layoutBoundaries {
    return LayoutBoundaries(
        parentLayoutBoundaries.minSize,
        DimensionalBoundaries(
          parentLayoutBoundaries.maxSize.width - (padding + margin) * 2,
          parentLayoutBoundaries.maxSize.height - (padding + margin) * 2,
        ));
  }
}

class ExpandibleRow extends RendererComponent {
  final String char;
  ExpandibleRow(this.char);

  @override
  LayoutBoundaries get layoutBoundaries => parentLayoutBoundaries;

  @override
  void render(ConsoleInterface console, Element element) {
    for (int i = 0; i < element.layoutBoundaries.maxSize.width; i++) {
      console.write(char);
      console.cursor.right();
    }
  }

  @override
  DimensionalBoundaries get size =>
      DimensionalBoundaries(parentLayoutBoundaries.maxSize.width, 1);
}
