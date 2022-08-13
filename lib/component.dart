import 'package:dart_console_user_interface/boundaries.dart';
import 'package:dart_console_user_interface/build_context.dart';
import 'package:dart_console_user_interface/console_interface.dart';
import 'package:dart_console_user_interface/element.dart';

abstract class Component {
  Element createElement();
  void buildChildren(BuildContext context);
  void render(ConsoleInterface console, Element element);
  DimensionalBoundaries get size;
  LayoutBoundaries get layoutBoundaries;
}

abstract class RendererComponent extends Component {
  @override
  void buildChildren(BuildContext context) {
    // Do nothing
  }

  @override
  Element createElement() {
    return RenderableElement(this);
  }

  @override
  void render(ConsoleInterface console, Element element);
}

abstract class ChildrenRendererComponent extends RendererComponent {
  List<Component> children;
  ChildrenRendererComponent({required this.children});

  @override
  void buildChildren(BuildContext context) {
    for (final child in children) {
      context.addChild(child);
    }
  }

  @override
  LayoutBoundaries get layoutBoundaries => throw UnimplementedError();

  @override
  void render(ConsoleInterface console, Element element);
}

abstract class BuildableComponent extends Component {
  late final Component _built;

  Component build(BuildContext context);

  @override
  void buildChildren(BuildContext context) {
    _built = build(context);
    context.addChild(build(context));
  }

  @override
  Element createElement() {
    return Element(this);
  }

  @override
  void render(ConsoleInterface console, Element element) {
    _built.render(console, element);
  }

  @override
  LayoutBoundaries get layoutBoundaries => _built.layoutBoundaries;

  @override
  DimensionalBoundaries get size => _built.size;
}
