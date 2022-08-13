import 'package:dart_console_user_interface/boundaries.dart';
import 'package:dart_console_user_interface/component.dart';
import 'package:dart_console_user_interface/console_interface.dart';
import 'package:dart_console_user_interface/element.dart';

class Column extends ChildrenRendererComponent {
  Column({required super.children});

  @override
  LayoutBoundaries get layoutBoundaries => throw UnimplementedError();

  @override
  void render(ConsoleInterface console, Element element) {
    for (final child in element.children) {
      child.render(console);
      console.cursor.down();
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
  LayoutBoundaries get layoutBoundaries => throw UnimplementedError();

  @override
  void render(ConsoleInterface console, Element element) {
    for (final child in element.children) {
      child.render(console);
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
}
