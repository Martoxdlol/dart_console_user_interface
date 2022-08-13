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
  late LayoutBoundaries parentLayoutBoundaries;

  void build(Element element) {
    parentLayoutBoundaries = element.parent.layoutBoundaries;
  }

  @override
  void buildChildren(BuildContext context) {
    build(context as Element);
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
    super.buildChildren(context);
    for (final child in children) {
      context.addChild(child);
    }
  }

  @override
  void render(ConsoleInterface console, Element element);
}

abstract class BuildableComponent extends Component {
  late Component _built;

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
